# To anyone reading this from GitHub !
# [][][] - this means censored information!


#Globals
$global:rootPath = $PSScriptRoot
$global:outputName = "DHR YBED"
$global:createNewFile = $False
$global:specialTempFile = ""
$global:mainTempFile = ""
$global:version = 1.21

#Load External Scripts
.("$PSScriptRoot\src\Functions\Getters\GetInputFilePath.ps1")
.("$PSScriptRoot\src\Functions\Checkers\SearchForData.ps1")
.("$PSScriptRoot\src\Functions\Checkers\PathsAreFilled.ps1")
.("$PSScriptRoot\src\Functions\Workers\Formatter.ps1")
.("$PSScriptRoot\src\Functions\Workers\FileBrowser.ps1")
.("$PSScriptRoot\src\Functions\Workers\PopulateFields.ps1")
.("$PSScriptRoot\src\Functions\Workers\SavePaths.ps1")
.("$PSScriptRoot\src\Functions\Workers\ClearTemp.ps1")
.("$PSScriptRoot\src\Functions\Workers\VLookUp.ps1")
.("$PSScriptRoot\src\Functions\Administration\Administer.ps1")
.("$PSScriptRoot\src\Functions\Workers\WriteChanges.ps1")
.("$PSScriptRoot\src\Functions\Workers\ArchiveOld.ps1")
.("$PSScriptRoot\src\Functions\Tickets\TicketHandler.ps1")
.("$PSScriptRoot\src\Functions\Workers\ClearInputs.ps1")
.("$PSScriptRoot\src\Functions\Workers\ValmetHandler.ps1")
.("$PSScriptRoot\src\Functions\Run.ps1")
.("$PSScriptRoot\src\GUI\Status.ps1")
.("$PSScriptRoot\src\GUI\ColorSelect.ps1")
.("$PSScriptRoot\src\GUI\DarkMode.ps1")
.("$PSScriptRoot\src\GUI\ErrorHandler.ps1")
.("$PSScriptRoot\src\Functions\Styling\Style.ps1")
.("$PSScriptRoot\src\Functions\VersionHandler\versionHandler.ps1")
.("$PSScriptRoot\src\Functions\VersionHandler\whatsNew.ps1")

if(VersionCheck -eq $True){exit;}

function drawUI 
{
    Add-Type -AssemblyName System.Windows.Forms
    [System.Windows.Forms.Application]::EnableVisualStyles()

    $global:textColor = [System.Drawing.ColorTranslator]::FromHtml("#171717")
    $global:textFont = 'Microsoft Sans Serif'
    $global:formColor = GetFormColor
    

    $isDarkEnabled = darkModeCheck

    $DHRMain                         = New-Object system.Windows.Forms.Form
    $DHRMain.ClientSize              = New-Object System.Drawing.Point(0,0)
    $DHRMain.text                    = "DHR Main"
    $DHRMain.icon                    = ".\src\GUI\images\icon.ico"
    $DHRMain.BackColor               = $formColor
    $DHRMain.AutoSize                = $true
    $DHRMain.StartPosition           = 'CenterScreen'
    $DHRMain.FormBorderStyle = 'Fixed3D'
    $DHRMain.MaximizeBox = $false

    $showProcess                     = New-Object system.Windows.Forms.CheckBox
    $showProcess.text                = "Display"
    $showProcess.AutoSize            = $false
    $showProcess.width               = 95
    $showProcess.height              = 20
    $showProcess.location            = New-Object System.Drawing.Point(712,55)
    $showProcess.Font                = New-Object System.Drawing.Font($textFont,10)
    $showProcess.ForeColor           = $textColor

    $deleteInputRadio                = New-Object system.Windows.Forms.CheckBox
    $deleteInputRadio.text           = "Keep input"
    $deleteInputRadio.AutoSize       = $false
    $deleteInputRadio.width          = 95
    $deleteInputRadio.height         = 20
    $deleteInputRadio.location       = New-Object System.Drawing.Point(16,35)
    $deleteInputRadio.Font           = New-Object System.Drawing.Font($textFont,10)
    $deleteInputRadio.ForeColor      = $textColor
    
    $adminPanel                      = New-Object system.Windows.Forms.CheckBox
    $adminPanel.text                 = "Admin"
    $adminPanel.AutoSize             = $false
    $adminPanel.width                = 95
    $adminPanel.height               = 20
    $adminPanel.location             = New-Object System.Drawing.Point(712,75)
    $adminPanel.Font                 = New-Object System.Drawing.Font($textFont,10)
    $adminPanel.ForeColor            = $textColor

    $CreateNewMain                   = New-Object system.Windows.Forms.CheckBox
    $CreateNewMain.text              = "Create a new main file"
    $CreateNewMain.AutoSize          = $true
    $CreateNewMain.width             = 250
    $CreateNewMain.height            = 25
    $CreateNewMain.location          = New-Object System.Drawing.Point(21,264)
    $CreateNewMain.Font              = New-Object System.Drawing.Font($textFont,14,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
    $CreateNewMain.ForeColor           = $textColor

    $PictureBox1                     = New-Object system.Windows.Forms.PictureBox
    $PictureBox1.width               = 403
    $PictureBox1.height              = 157
    $PictureBox1.location            = New-Object System.Drawing.Point(196,59)
    $PictureBox1.imageLocation       = ".\src\GUI\images\smallbanner.png"
    $PictureBox1.SizeMode            = [System.Windows.Forms.PictureBoxSizeMode]::zoom
    $MainFileTip                     = New-Object system.Windows.Forms.ToolTip
    $MainFileTip.ToolTipTitle        = "?"
    $MainFileTip.isBalloon           = $true

    $version                         = New-Object system.Windows.Forms.Label
    $version.text                    = "DHR v$global:version" 
    $version.AutoSize                = $true
    $version.width                   = 25
    $version.height                  = 10
    $version.location                = New-Object System.Drawing.Point(14,15)
    $version.Font                    = New-Object System.Drawing.Font($textFont,10)
    $version.ForeColor               = $textColor

    $creator                         = New-Object system.Windows.Forms.Label
    $creator.text                    = "Created by RS"
    $creator.AutoSize                = $true
    $creator.width                   = 25
    $creator.height                  = 10
    $creator.location                = New-Object System.Drawing.Point(712,15)
    $creator.Font                    = New-Object System.Drawing.Font($textFont,10)
    $creator.ForeColor               = $textColor

    $darkmodeSelector                = New-Object system.Windows.Forms.CheckBox
    $darkmodeSelector.text           = "DarkMode"
    $darkmodeSelector.AutoSize       = $false
    $darkmodeSelector.width          = 95
    $darkmodeSelector.height         = 20
    $darkmodeSelector.location       = New-Object System.Drawing.Point(712,35)
    $darkmodeSelector.Font           = New-Object System.Drawing.Font($textFont,10)
    $darkmodeSelector.ForeColor      = $textColor

    $valmetSelector                  = New-Object system.Windows.Forms.CheckBox
    $valmetSelector.text             = "Valmet"
    $valmetSelector.AutoSize         = $false
    $valmetSelector.width            = 95
    $valmetSelector.height           = 20
    $valmetSelector.location         = New-Object System.Drawing.Point(16,55)
    $valmetSelector.Font             = New-Object System.Drawing.Font($textFont,10)
    $valmetSelector.ForeColor        = $textColor

    $Start                           = New-Object system.Windows.Forms.Button
    $Start.text                      = "START"
    $Start.width                     = 80
    $Start.height                    = 35
    $Start.location                  = New-Object System.Drawing.Point(691,401)
    $Start.Font                      = New-Object System.Drawing.Font('Sitka Small',14)
    $Start.BackColor                 = [System.Drawing.ColorTranslator]::FromHtml("#7ed321")

    $Upload                          = New-Object system.Windows.Forms.Button
    $Upload.text                     = "PUSH"
    $Upload.width                    = 80
    $Upload.height                   = 35
    $Upload.location                 = New-Object System.Drawing.Point(691,361)
    $Upload.Font                     = New-Object System.Drawing.Font('Sitka Small',14)
    $Upload.BackColor                = [System.Drawing.ColorTranslator]::FromHtml("#4263f5")
    $Upload.Visible                  = $False

    $Ticket                           = New-Object system.Windows.Forms.Button
    $Ticket.text                      = "HELP"
    $Ticket.width                     = 80
    $Ticket.height                    = 35
    $Ticket.location                  = New-Object System.Drawing.Point(601,401)
    $Ticket.Font                      = New-Object System.Drawing.Font('Sitka Small',14)
    $Ticket.BackColor                 = [System.Drawing.ColorTranslator]::FromHtml("#F3AA17")


    $archiveLabel                    = New-Object system.Windows.Forms.Label
    $archiveLabel.text               = "Archive file path:"
    $archiveLabel.AutoSize           = $true
    $archiveLabel.width              = 25
    $archiveLabel.height             = 10
    $archiveLabel.location           = New-Object System.Drawing.Point(27,392)
    $archiveLabel.Font               = New-Object System.Drawing.Font($textFont,10)
    $archiveLabel.ForeColor          = $textColor

    $archiveText                     = New-Object system.Windows.Forms.TextBox
    $archiveText.multiline           = $false
    $archiveText.width               = 323
    $archiveText.height              = 20
    $archiveText.location            = New-Object System.Drawing.Point(27,413)
    $archiveText.Font                = New-Object System.Drawing.Font($textFont,10)

    $specialLabel                    = New-Object system.Windows.Forms.Label
    $specialLabel.text               = "Special file path:"
    $specialLabel.AutoSize           = $true
    $specialLabel.width              = 25
    $specialLabel.height             = 10
    $specialLabel.location           = New-Object System.Drawing.Point(27,345)
    $specialLabel.Font               = New-Object System.Drawing.Font($textFont,10)
    $specialLabel.ForeColor          = $textColor

    $specialText                     = New-Object system.Windows.Forms.TextBox
    $specialText.multiline           = $false
    $specialText.width               = 323
    $specialText.height              = 20
    $specialText.location            = New-Object System.Drawing.Point(27,365)
    $specialText.Font                = New-Object System.Drawing.Font($textFont,10)

    $mainLabel                       = New-Object system.Windows.Forms.Label
    $mainLabel.text                  = "Main file path:"
    $mainLabel.AutoSize              = $true
    $mainLabel.width                 = 25
    $mainLabel.height                = 10
    $mainLabel.location              = New-Object System.Drawing.Point(27,295)
    $mainLabel.Font                  = New-Object System.Drawing.Font($textFont,10)
    $mainLabel.ForeColor             = $textColor

    $mainText                        = New-Object system.Windows.Forms.TextBox
    $mainText.multiline              = $false
    $mainText.width                  = 323
    $mainText.height                 = 20
    $mainText.location               = New-Object System.Drawing.Point(27,318)
    $mainText.Font                   = New-Object System.Drawing.Font($textFont,10)

    $browse0                         = New-Object system.Windows.Forms.Button
    $browse0.text                    = "Browse"
    $browse0.width                   = 65
    $browse0.height                  = 25
    $browse0.location                = New-Object System.Drawing.Point(365,317)
    $browse0.Font                    = New-Object System.Drawing.Font($textFont,10)
    $browse0.ForeColor               = $textColor

    $browse1                         = New-Object system.Windows.Forms.Button
    $browse1.text                    = "Browse"
    $browse1.width                   = 65
    $browse1.height                  = 25
    $browse1.location                = New-Object System.Drawing.Point(365,363)
    $browse1.Font                    = New-Object System.Drawing.Font($textFont,10)
    $browse1.ForeColor               = $textColor

    $browse2                         = New-Object system.Windows.Forms.Button
    $browse2.text                    = "Browse"
    $browse2.width                   = 65
    $browse2.height                  = 25
    $browse2.location                = New-Object System.Drawing.Point(365,412)
    $browse2.Font                    = New-Object System.Drawing.Font($textFont,10)
    $browse2.ForeColor               = $textColor

    $loader                          = New-Object system.Windows.Forms.PictureBox
    $loader.width                    = 60
    $loader.height                   = 30
    $loader.location                 = New-Object System.Drawing.Point(630,402)
    $loader.SizeMode                 = [System.Windows.Forms.PictureBoxSizeMode]::zoom
    $loader.Visible                  = $False

    $colorPicker                     = New-Object system.Windows.Forms.PictureBox
    $colorPicker.width               = 60
    $colorPicker.height              = 30
    $colorPicker.location            = New-Object System.Drawing.Point(495,60)
    $colorPicker.ImageLocation       = ".\src\GUI\images\colorpick.png"
    $colorPicker.SizeMode            = [System.Windows.Forms.PictureBoxSizeMode]::zoom
    $colorPicker.Visible             = $True

    $DHRMain.controls.AddRange(@($loader,$Upload,$colorPicker,$adminPanel,$Ticket,$valmetSelector,$CreateNewMain,$deleteInputRadio,$showProcess,$mainLabel,$mainText,$browse0,$PictureBox1,$version,$creator,$Start,$archiveLabel,$archiveText,$browse1,$specialLabel,$specialText,$browse2,$darkmodeSelector))
    
    #Event Handlers
    $Start.Add_Click({ run })
    $browse0.Add_Click({ $mainText.text = browse })
    $colorPicker.Add_Click({GetColor})
    $browse1.Add_Click({ $specialText.text = browse })
    $browse2.Add_Click({ $archiveText.text = browseFolder })
    $darkmodeSelector.Add_Click({changeDarkOnRuntime})
    $adminPanel.Add_Click({Administer})
    $Upload.Add_Click({PushUpdate})
    $Ticket.Add_Click({OpenTicketForm})
    $PictureBox1.Add_Click({showWhatsNew})
    

    $DHRMain.Add_ResizeEnd({$DHRMain.ClientSize = New-Object System.Drawing.Point(800,450)})
    populateFields
    if($isDarkEnabled -eq $true) 
    {
        $darkmodeSelector.Checked = $true
        $PictureBox1.imageLocation = ".\src\GUI\images\smallbannerWhite.png"
    }
    [void]$DHRMain.ShowDialog()
}

drawUI