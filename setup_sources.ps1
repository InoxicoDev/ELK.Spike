. "./scripts/sources_common.ps1"

Import-Module BitsTransfer

function DownloadIfMissing ($expectedZipLocation, $downloadUri) {
    if((Test-Path -Path $expectedZipLocation) -eq $false) {
        Start-BitsTransfer -Source $downloadUri -Destination $expectedZipLocation
    }
}

$jdkFolder = Get-JDK-App "sources"
if($null -ne $jdkFolder) {
    Copy-App $jdkFolder "sources" "elasticsearch\\sources\\"
    Copy-App $jdkFolder "sources" "logstash\\sources\\"
}

$elasticSearchZipPath = "sources\\" + $ElasticSearchOssZipFile
DownloadIfMissing $elasticSearchZipPath $ElasticSearchOssDownloadUri
Copy-Item -Path $elasticSearchZipPath -Destination "elasticsearch\\sources\\${ElasticSearchOssZipFile}" -Force

$logstashZipPath = "sources\\" + $LogstashOssZipFile
DownloadIfMissing $logstashZipPath $LogstashOssDownloadUri
Copy-Item -Path $logstashZipPath -Destination "logstash\\sources\\${LogstashOssZipFile}" -Force

$kibanaZipPath = "sources\\" + $KibanaOssZipfile
DownloadIfMissing $kibanaZipPath $KibanaOssDownloadUri
New-Item -ItemType directory -Force "kibana\\sources" > $null
Copy-Item -Path $kibanaZipPath -Destination "kibana\\sources\\${KibanaOssZipfile}" -Force