function clearInputs
{
    Get-ChildItem -Path "$global:rootPath\input\Main" -Include *.* -File -Recurse | ForEach-Object { $_.Delete()}
    Get-ChildItem -Path "$global:rootPath\input\Special" -Include *.* -File -Recurse | ForEach-Object { $_.Delete()}
}