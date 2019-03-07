$TargetVersionELK = "6.5.4"

$OpenJDKZipFile = "java-1.8.0-openjdk-1.8.0.191-1.b12.ojdkbuild.windows.x86_64.zip"
$ElasticSearchOssZipFile = "elasticsearch-oss-${TargetVersionELK}.zip"
$LogstashOssZipFile = "logstash-oss-${TargetVersionELK}.zip"
$KibanaOssZipfile = "kibana-oss-${TargetVersionELK}-windows-x86_64.zip"

$OpenJDKUri = "https://github.com/ojdkbuild/ojdkbuild/releases/download/1.8.0.191-1/java-1.8.0-openjdk-1.8.0.191-1.b12.ojdkbuild.windows.x86_64.zip"
$ElasticSearchOssDownloadUri = "https://artifacts.elastic.co/downloads/elasticsearch/${ElasticSearchOssZipFile}"
$LogstashOssDownloadUri = "https://artifacts.elastic.co/downloads/logstash/${LogstashOssZipFile}"
$KibanaOssDownloadUri = "https://artifacts.elastic.co/downloads/kibana/${KibanaOssZipfile}"

function Create-Folder-If-Missing ($relativePath) {
    if ((Test-Path -Path $relativePath) -eq $false) {
        New-Item -ItemType directory -Force $relativePath > $null
    }
}

function Download-If-Missing ($expectedZipLocation, $downloadUri) {
    if ((Test-Path -Path $expectedZipLocation) -eq $false) {
		DownloadFile $downloadUri $expectedZipLocation
    }
}

function Copy-App ($appFolderName, $sourcePath, $destinationPath) {
    if ((Test-Path -Path ($destinationPath + $appFolderName) -Exclude *.zip) -eq $false) {
        Copy-Item -Recurse -Path ($sourcePath + "\\" + $appFolderName) -Destination ($destinationPath + "jdk-" + $appFolderName) -Exclude *.zip
    }
}

function Copy-File-If-Missing ($sourceFilePath, $destFilePath) {
    if ((Test-Path -Path $destFilePath) -eq $false) {
        Copy-Item -Path $sourceFilePath -Destination $destFilePath -Force
    }
}

function Get-JDK-App ($sourcesFolder) {
    $jdkFolder = Get-ChildItem ($sourcesFolder + "\java*") -Directory

    if($jdkFolder.length -eq 0) {
        Write-Host "No JDK has been found in 'sources' folder"
        return $null
    } 
    if ($jdkFolder.length -gt 1) {
        Write-Host "More than one JDK was found in 'sources' folder"
        return $null
    } 
    
    $jdkFolder = $jdkFolder[0].Name
    return $jdkFolder
}

function DownloadFile {
	# Courtesy of Jason Niver / https://blogs.msdn.microsoft.com/jasonn/2008/06/13/downloading-files-from-the-internet-in-powershell-with-progress/
	param([string]$url, [string]$targetFile)

	"Downloading $url"
	$uri = New-Object "System.Uri" "$url"
	$request = [System.Net.HttpWebRequest]::Create($uri)
	$request.ServicePoint.Expect100Continue = $false;
	$request.ProtocolVersion = [System.Net.HttpVersion]::Version11;
	$request.set_Timeout(15000) # 15 second timeout
	$response = $request.GetResponse()
	Try {
		$totalLength = [System.Math]::Floor($response.get_ContentLength()/1024)
		
		$responseStream = $response.GetResponseStream()
		Try {
			$targetStream = [System.IO.FileStream]::new($targetFile, [System.IO.FileMode]::Create)
			Try {
				$buffer = new-object byte[] 10KB
				$count = $responseStream.Read($buffer,0,$buffer.length)
				$downloadedBytes = $count
				while ($count -gt 0)
				{ 
				  $downloaded = [System.Math]::Floor($downloadedBytes/1024)
				  Write-Progress -Activity "Downloading $targetFile ..." -Status "$downloaded K / $totalLength K" -PercentComplete ($downloaded / $totalLength * 100)
				  $targetStream.Write($buffer, 0, $count)
				  $count = $responseStream.Read($buffer,0,$buffer.length)
				  $downloadedBytes = $downloadedBytes + $count
				} 
				"`nFinished Download"
				$targetStream.Flush()
				$targetStream.Close()
			}
			Finally {
				$targetStream.Dispose()
			}
		}
		Finally {
			$responseStream.Dispose()
		}
	}
	Finally {
		$response.Dispose()
	}
}