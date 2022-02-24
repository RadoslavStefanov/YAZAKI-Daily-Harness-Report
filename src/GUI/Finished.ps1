function finished
{
    Add-Type -AssemblyName PresentationFramework
    [void] [System.Windows.MessageBox]::Show( "DHR has successfuly finished!", "Done", "OK", "Information" )
}