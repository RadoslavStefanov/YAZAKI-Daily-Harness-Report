function clearTemp
{
    Get-ChildItem -Path "$global:rootPath\src\Temp" -Include *.* -File -Recurse | ForEach-Object { $_.Delete()}
}