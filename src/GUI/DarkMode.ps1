function  darkModeCheck
{
    if(readConfigFile -eq $true)
    {
        $global:textColor = [System.Drawing.ColorTranslator]::FromHtml("#ded3c7")
        $global:formColor = [System.Drawing.ColorTranslator]::FromHtml("#1f2531")
        return $true
    }
    return $false
}

function readConfigFile
{
    $styleReader = Get-Content -Path "$global:rootPath\src\Data\styling.txt"
    $returnVal = $styleReader -match "darkmode-[0-1]"

    if($returnVal.Length -gt 0 -and ($returnVal[0] -split "-") -eq "1")
    {return $true}
    else 
    {return $false}
}


function changeDarkOnRuntime
{
    $styleFileArr = Get-Content -Path "$global:rootPath\src\Data\styling.txt"
    if($darkmodeSelector.Checked)
    {
        $darkModePropLine = $styleFileArr.IndexOf("darkmode-0")
        $styleFileArr[$darkModePropLine] = "darkmode-1"
        $styleFileArr | Set-Content "$global:rootPath\src\Data\styling.txt"
    }
    else 
    {
        $darkModePropLine = $styleFileArr.IndexOf("darkmode-1")
        $styleFileArr[$darkModePropLine] = "darkmode-0"
        $styleFileArr | Set-Content "$global:rootPath\src\Data\styling.txt"
    }
    $DHRMain.Visible=$false;
    drawUI
}