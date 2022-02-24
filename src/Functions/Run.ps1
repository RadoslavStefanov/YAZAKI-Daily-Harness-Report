.("$global:rootPath\src\GUI\Finished.ps1")
.("$global:rootPath\src\Functions\Checkers\CheckOutExists.ps1")
function run
{
    startLoading
    $shouldRun = $True    
    if(! $CreateNewMain.Checked)
    {
        if((checkOutExists) -eq $False)
        {
            $shouldRun = $False
            displayError -errorMsg "To override the Output/Main file you first have to have one already existing!"
        }
    }

    if((pathsAreFilled) -eq $True -and $shouldRun-eq $True)
    {
        dataFileExists
        savePaths
        formatMainFile -filePath (getInputFilePath)[0] -isSpecial 0
        formatMainFile -filePath (getInputFilePath)[1] -isSpecial 1
        vLookUp
        if($CreateNewMain.Checked)
        {
            if((checkOutExists) -eq $True)
            {archiveOld}
            styleFile
            
        }
        else
        {
            writeChanges
            styleAfterMerge
        }
        finished
        if($deleteInputRadio.Checked -eq $false)
        {clearInputs}
    }
    clearTemp
    stopLoading
}