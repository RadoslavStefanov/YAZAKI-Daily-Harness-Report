function archiveOld
{
    $archiveName = Get-Date -Format "MM.dd.yyyy_HH.mm"
    $archiveName = $archiveName.ToString()
    $DestinationPath = (getInputFilePath)[2]
    Compress-Archive -LiteralPath "$rootPath\Output\Output.xlsx" -DestinationPath "$DestinationPath\$archiveName.zip"
    

    if($calmetSelector.Checked)
    {
        Get-ChildItem -Path "$global:rootPath\Output\[][][]" -Include *.* -File -Recurse | ForEach-Object { $_.Delete()}
        archiveValmet
    }
    else
    {Get-ChildItem -Path "$global:rootPath\Output\[][][]" -Include *.* -File | ForEach-Object { $_.Delete()}}
    
}

function archiveValmet
{
    if(Test-Path -LiteralPath "$rootPath\Output\[][][]\[][][].xlsx")
    {
        Compress-Archive -LiteralPath "$rootPath\Output\[][][]\[][][].xlsx" -DestinationPath "$DestinationPath\$archiveName-[][][].zip"
    }
}