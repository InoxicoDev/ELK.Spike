function Copy-JDK ($jdkFolderName, $sourcePath, $destinationPath) {
    if((Test-Path -Path ($destinationPath + $jdkFolder)) -eq $false) {
        Copy-Item -Recurse -Path ($sourcePath + "\\" + $jdkFolder) -Destination ($destinationPath + $jdkFolder) 
    }
}

Write-Host "This will distribute the JDK where necessary so you don't have to"

$jdkFolder = Get-ChildItem sources\jdk*

if($jdkFolder.length -eq 0) {
    Write-Host "No JDK has been found in 'sources' folder"
} elseif ($jdkFolder.length -gt 1) {
    Write-Host "More than one JDK was found in 'sources' folder"
} else {
    $jdkFolder = $jdkFolder[0].Name

    Copy-JDK $jdkFolder "sources" "elasticsearch\\sources\\"
    Copy-JDK $jdkFolder "sources" "logstash\\sources\\"
}
