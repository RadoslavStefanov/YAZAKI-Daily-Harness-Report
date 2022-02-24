function GetColor
{
    $colorHash = 
    @{ 
        Red = "FF0000";
        Yellow = "FFFF00";
        Aqua = "00FFFF";
        Fuchsia = "FF00FF";
        Lime = "BFFF00";
        Teal = "008080";
        Maroon = "800000";
        Green = "00FF00";
        Blue = "0000FF";
        Purple = "E6E6FA";
        Navy = "003366";
        Olive = "808000";
        Gray = "808080";
        Silver = "aaa9ad";
        White = "FFFFFF"
    }

    if($darkmodeSelector.Checked)
    {
        Add-Type -AssemblyName PresentationCore,PresentationFramework
        [void] [System.Windows.MessageBox]::Show( "ColorPicker cannot be used when in DarkMode!", "Attention", "OK", "Asterisk" )
    }
    else 
    {
        $colorDialog = new-object System.Windows.Forms.ColorDialog 
        $colorDialog.AllowFullOpen = $true
        [void]$colorDialog.ShowDialog()
        $pickedColor = $colorDialog.Color.Name

        if($pickedColor -eq "Black"){}
        elseif($colorHash.ContainsKey($pickedColor))
        {changeColorOnRuntime -color $colorHash[$pickedColor]}
        else 
        {changeColorOnRuntime -color $pickedColor}
                     
    }
    
}


function changeColorOnRuntime
{
    param ($color)

    $styleFileArr = Get-Content -Path "$global:rootPath\src\Data\styling.txt"
    $colorCfgLine = $styleFileArr.IndexOf("color-$global:formColor")
    $styleFileArr[$colorCfgLine] = "color-#$color"
    $styleFileArr | Set-Content "$global:rootPath\src\Data\styling.txt"

    $DHRMain.Visible=$false;
    drawUI
}


function GetFormColor
{
    $styleReader = Get-Content -Path "$global:rootPath\src\Data\styling.txt"
    $returnVal = $styleReader -match "color-#?\w*"
    $returnVal = ($returnVal -split "-")[1]
    
    return [System.Drawing.ColorTranslator]::FromHtml("$returnVal")
}