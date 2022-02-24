function savePaths 
{
    $local:pathsTXTPath = "$global:rootPath\src\Data\paths.txt"

    Clear-Content $local:pathsTXTPath
    Add-Content -Path $local:pathsTXTPath -value $mainText.text
    Add-Content -Path $local:pathsTXTPath -value $specialText.text
    Add-Content -Path $local:pathsTXTPath -value $archiveText.text
}