$TargetVersionELK = "6.4.1"

$ElasticSearchOssZipFile = "elasticsearch-oss-${TargetVersionELK}.zip"
$LogstashOssZipFile = "logstash-oss-${TargetVersionELK}.zip"
$KibanaOssZipfile = "kibana-oss-${TargetVersionELK}-windows-x86_64.zip"

$ElasticSearchOssDownloadUri = "https://artifacts.elastic.co/downloads/elasticsearch/${ElasticSearchOssZipFile}"
$LogstashOssDownloadUri = "https://artifacts.elastic.co/downloads/logstash/${LogstashOssZipFile}"
$KibanaOssDownloadUri = "https://artifacts.elastic.co/downloads/kibana/${KibanaOssZipfile}"

function Copy-App ($appFolderName, $sourcePath, $destinationPath) {
    if((Test-Path -Path ($destinationPath + $appFolderName)) -eq $false) {
        Copy-Item -Recurse -Path ($sourcePath + "\\" + $appFolderName) -Destination ($destinationPath + $appFolderName) 
    }
}

function Get-JDK-App ($sourcesFolder) {
    $jdkFolder = Get-ChildItem ($sourcesFolder + "\jdk*")

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