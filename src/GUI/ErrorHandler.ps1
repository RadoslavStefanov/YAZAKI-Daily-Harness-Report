function allPathsNotFilled
{
    Add-Type -AssemblyName PresentationFramework
    [void] [System.Windows.MessageBox]::Show( "Please fill all file paths! ", "Script completed", "OK", "Information" )
}

function displayError
{
    param 
    (
        $errorMsg
    )
    Add-Type -AssemblyName PresentationFramework
    [void] [System.Windows.MessageBox]::Show( $errorMsg, "Error", "OK", "Error" )
}
