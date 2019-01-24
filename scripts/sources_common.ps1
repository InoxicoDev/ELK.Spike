$TargetVersionELK = "6.5.4"

$OpenJDKZipFile = "java-1.8.0-openjdk-1.8.0.191-1.b12.ojdkbuild.windows.x86_64.zip"
$ElasticSearchOssZipFile = "elasticsearch-oss-${TargetVersionELK}.zip"
$LogstashOssZipFile = "logstash-oss-${TargetVersionELK}.zip"
$KibanaOssZipfile = "kibana-oss-${TargetVersionELK}-windows-x86_64.zip"

$OpenJDKUri = "https://github.com/ojdkbuild/ojdkbuild/releases/download/1.8.0.191-1/java-1.8.0-openjdk-1.8.0.191-1.b12.ojdkbuild.windows.x86_64.zip"
$ElasticSearchOssDownloadUri = "https://artifacts.elastic.co/downloads/elasticsearch/${ElasticSearchOssZipFile}"
$LogstashOssDownloadUri = "https://artifacts.elastic.co/downloads/logstash/${LogstashOssZipFile}"
$KibanaOssDownloadUri = "https://artifacts.elastic.co/downloads/kibana/${KibanaOssZipfile}"

function Copy-App ($appFolderName, $sourcePath, $destinationPath) {
    if((Test-Path -Path ($destinationPath + $appFolderName) -Exclude *.zip) -eq $false) {
        Copy-Item -Recurse -Path ($sourcePath + "\\" + $appFolderName) -Destination ($destinationPath + "jdk-" + $appFolderName) -Exclude *.zip
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