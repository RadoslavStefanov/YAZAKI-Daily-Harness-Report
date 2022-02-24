function getInputFilePath 
{
    $data = Get-Content -Path "$rootPath\src\Data\paths.txt"
    return $data
}