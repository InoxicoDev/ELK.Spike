$TargetVersionELK = "6.7.0"

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

function Copy-File-If-Missing ($sourceFilePath, $destDirPath) {
    $destFilePath = [System.IO.Path]::Combine($destDirPath, [System.IO.Path]::GetFileName($sourceFilePath))

    if ((Test-Path -Path $destFilePath) -eq $false) {
        Copy-Item -Path $sourceFilePath -Destination $destFilePath -Force
    }
}

function Extract-File-If-Missing ($zipFilePath, $destDirPath) {
    $destFilePath = [System.IO.Path]::Combine($destDirPath, [System.IO.Path]::GetFileName($zipFilePath))

    if ((Test-Path -Path $destFilePath) -eq $false) {
        Expand-Archive -Path $zipFilePath -DestinationPath $destDirPath
    }
}

function DownloadFile {
	# Courtesy of Jason Niver / https://blogs.msdn.microsoft.com/jasonn/2008/06/13/downloading-files-from-the-internet-in-powershell-with-progress/
    # However I have made lots of changes in the mean time
	param([string]$url, [string]$targetFile)

	"Downloading $url ..."
	$uri = New-Object "System.Uri" "$url"
	$request = [System.Net.HttpWebRequest]::Create($uri)
	$request.ServicePoint.Expect100Continue = $false;
	$request.ProtocolVersion = [System.Net.HttpVersion]::Version11;
	$request.set_Timeout(15000) # 15 second timeout
    $tempDownloadFile = $targetFile + ".download"

    if ((Test-Path -Path $tempDownloadFile) -eq $true) {
        Remove-Item $tempDownloadFile
    }

    $finished = $false
	$response = $request.GetResponse()
	Try {
		$totalLength = [System.Math]::Floor($response.get_ContentLength() / 1024)
		
		$responseStream = $response.GetResponseStream()
		Try {
			$targetStream = [System.IO.FileStream]::new($tempDownloadFile, [System.IO.FileMode]::Create)
			Try {
				$buffer = new-object byte[] 10KB
				$count = $responseStream.Read($buffer,0,$buffer.length)
				$downloadedBytes = $count
				$prevTime = [System.DateTime]::Now
				while ($count -gt 0)
				{
					$curtime = [System.DateTime]::Now
					$span = $curtime - $prevTime
					if ($span.TotalMilliseconds -ge 1000) {
						$downloaded = [System.Math]::Floor($downloadedBytes/1024)
						Write-Progress -Activity "Downloading $url ..." -Status "$downloaded K / $totalLength K" -PercentComplete ($downloaded / $totalLength * 100)
						$prevTime = [System.DateTime]::Now  
					}

				  	$targetStream.Write($buffer, 0, $count)
				  	$count = $responseStream.Read($buffer,0,$buffer.length)
				  	$downloadedBytes = $downloadedBytes + $count
				} 
				"`nFinished Download"
				$targetStream.Flush()
				$targetStream.Close()
                $finished = $true
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

    if ($finished) {
        Rename-Item -Path ($targetFile + ".download") -NewName $targetFile
    }
}