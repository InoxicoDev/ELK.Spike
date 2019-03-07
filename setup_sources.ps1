. "./scripts/sources_common.ps1"

Create-Folder-If-Missing "elasticsearch\\sources"
Create-Folder-If-Missing "logstash\\sources"
Create-Folder-If-Missing "kibana\\sources"

$openJdkZipPath = $PSScriptRoot + "\\sources\\" + $OpenJDKZipFile
Download-If-Missing $openJdkZipPath $OpenJDKUri
Copy-File-If-Missing $openJdkZipPath "elasticsearch\\sources\\"
Copy-File-If-Missing $openJdkZipPath "logstash\\sources\\"
Extract-File-If-Missing "elasticsearch\\sources\\$OpenJDKZipFile" "elasticsearch\\sources"
Extract-File-If-Missing "logstash\\sources\\$OpenJDKZipFile" "logstash\\sources"

$elasticSearchZipPath = $PSScriptRoot + "\\sources\\" + $ElasticSearchOssZipFile
Download-If-Missing $elasticSearchZipPath $ElasticSearchOssDownloadUri
Copy-File-If-Missing $elasticSearchZipPath "elasticsearch\\sources"

$logstashZipPath = $PSScriptRoot + "\\sources\\" + $LogstashOssZipFile
Download-If-Missing $logstashZipPath $LogstashOssDownloadUri
Copy-File-If-Missing $logstashZipPath "logstash\\sources"

$kibanaZipPath = $PSScriptRoot + "\\sources\\" + $KibanaOssZipfile
Download-If-Missing $kibanaZipPath $KibanaOssDownloadUri
Copy-File-If-Missing $kibanaZipPath "kibana\\sources"