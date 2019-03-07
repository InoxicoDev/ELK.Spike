. "./scripts/sources_common.ps1"

Create-Folder-If-Missing "elasticsearch\\sources"
Create-Folder-If-Missing "logstash\\sources"
Create-Folder-If-Missing "kibana\\sources"

$openJdkZipPath = $PSScriptRoot + "\\sources\\" + $OpenJDKZipFile
Download-If-Missing $openJdkZipPath $OpenJDKUri
if ((Test-Path -Path "sources\\java*" -Exclude *.zip) -eq $false) {
    Expand-Archive -Path $openJdkZipPath -DestinationPath "sources"
}

$jdkFolder = Get-JDK-App "sources"
if($null -ne $jdkFolder) {
    Copy-App $jdkFolder "sources" "elasticsearch\\sources\\"
    Copy-App $jdkFolder "sources" "logstash\\sources\\"
}

$elasticSearchZipPath = $PSScriptRoot + "\\sources\\" + $ElasticSearchOssZipFile
Download-If-Missing $elasticSearchZipPath $ElasticSearchOssDownloadUri
Copy-File-If-Missing $elasticSearchZipPath "elasticsearch\\sources\\${ElasticSearchOssZipFile}"

$logstashZipPath = $PSScriptRoot + "\\sources\\" + $LogstashOssZipFile
Download-If-Missing $logstashZipPath $LogstashOssDownloadUri
Copy-File-If-Missing $logstashZipPath "logstash\\sources\\${LogstashOssZipFile}"

$kibanaZipPath = $PSScriptRoot + "\\sources\\" + $KibanaOssZipfile
Download-If-Missing $kibanaZipPath $KibanaOssDownloadUri
Copy-File-If-Missing $kibanaZipPath "kibana\\sources\\${KibanaOssZipfile}"