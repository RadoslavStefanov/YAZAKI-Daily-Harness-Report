function VersionCheck
{   
    $versionFileData = Get-Content "[][][]"
    if($versionFileData -gt $global:version)
    {
        Add-Type -AssemblyName PresentationCore,PresentationFramework
        $answer = [System.Windows.MessageBox]::Show( "DHR has a new version $versionFileData! Would you like to update?", "Attention", "OKCancel", "Asterisk" )

        if($answer -eq "OK")
        {
            Update
            Add-Type -AssemblyName PresentationCore,PresentationFramework
            [System.Windows.MessageBox]::Show( "DHR Has been updated! Please run the application again!", "Attention", "OK", "Asterisk" )
            return $True;
        }
        else
        {return $False}
    }
}
function Update 
{
    $source1 = "[][][]"
    robocopy $source1 $global:rootPath /E
}

function PushUpdate
{
    $srcPath = "$global:rootPath\src"
    $guiPath = "$global:rootPath\GUI.ps1"
    $source1 = "[][][]"
    $source2 = "[][][]"

    robocopy $srcPath $source1 /E /MIR 
    Copy-Item $guiPath -Destination $source2

    $fileKeeperTXT = Get-Content -Path "\[][][]"
    $fileKeeperTXT = $global:version
    $fileKeeperTXT | Set-Content "[][][]"

    Get-ChildItem -Path "[][][]" -Include *.* -File -Recurse | ForEach-Object { $_.Delete()}
    
    Add-Type -AssemblyName PresentationCore,PresentationFramework
    [System.Windows.MessageBox]::Show( "DHR update has been pushed!", "Attention", "OK", "Asterisk" )
}