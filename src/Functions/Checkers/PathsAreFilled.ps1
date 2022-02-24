.("$global:rootPath.\src\GUI\ErrorHandler.ps1")
function pathsAreFilled
{
    if($mainText.text.length -ne 0)
    {
        if($specialText.text.length -ne 0)
        {

            if($archiveText.text.length -ne 0)
            {
                return $True
            }
        }
    }
    allPathsNotFilled
    return $false
}