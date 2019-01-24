. "./scripts/sources_common.ps1"

Import-Module BitsTransfer

function DownloadIfMissing ($expectedZipLocation, $downloadUri) {
    if((Test-Path -Path $expectedZipLocation) -eq $false) {
        Start-BitsTransfer -Source $downloadUri -Destination $expectedZipLocation
    }
}

New-Item -ItemType directory -Force "elasticsearch\\sources" > $null
New-Item -ItemType directory -Force "logstash\\sources" > $null
New-Item -ItemType directory -Force "kibana\\sources" > $null

$openJdkZipPath = "sources\\" + $OpenJDKZipFile
DownloadIfMissing $openJdkZipPath $OpenJDKUri
if ((Test-Path -Path "sources\\java*" -Exclude *.zip) -eq $false) {
    Expand-Archive -Path $openJdkZipPath -DestinationPath "sources"
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
DownloadIfMissing $logstashZipPath $LogstashOssDownloadUr
Copy-Item -Path $logstashZipPath -Destination "logstash\\sources\\${LogstashOssZipFile}" -Force

$kibanaZipPath = "sources\\" + $KibanaOssZipfile
DownloadIfMissing $kibanaZipPath $KibanaOssDownloadUri
Copy-Item -Path $kibanaZipPath -Destination "kibana\\sources\\${KibanaOssZipfile}" -Force