function browse
{
    Add-Type -AssemblyName System.Windows.Forms
    $initialDirectory = $global:rootPath
    $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $OpenFileDialog.InitialDirectory = $initialDirectory
    $OpenFileDialog.Multiselect = $false
    $response = $OpenFileDialog.ShowDialog( ) # $response can return OK or Cancel
    if ( $response -eq 'OK' ) { return $OpenFileDialog.FileName }
}

function browseFolder
{
    Add-Type -AssemblyName System.Windows.Forms
    $FolderBrowser = New-Object System.Windows.Forms.FolderBrowserDialog
    $response = $FolderBrowser.ShowDialog( ) # $response can return OK or Cancel
    if ( $response -eq 'OK' ) { return $FolderBrowser.SelectedPath}
}