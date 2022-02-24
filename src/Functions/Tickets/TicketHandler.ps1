function OpenTicketForm
{
        Add-Type -AssemblyName System.Windows.Forms
        Add-Type -AssemblyName System.Drawing

        $form = New-Object System.Windows.Forms.Form
        $form.Text = 'Ticket Creation'
        $form.Size = New-Object System.Drawing.Size(600,400)
        $form.StartPosition = 'CenterScreen'
        $form.BackColor = $formColor

        $okButton = New-Object System.Windows.Forms.Button
        $okButton.Location = New-Object System.Drawing.Point(150,300)
        $okButton.Size = New-Object System.Drawing.Size(75,23)
        $okButton.Text = 'Send'
        $okButton.Font = New-Object System.Drawing.Font($textFont,10)
        $okButton.ForeColor = $textColor
        $okButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
        $form.Controls.Add($okButton)
        $okButton.Add_Click({SendMail})

        $cancelButton = New-Object System.Windows.Forms.Button
        $cancelButton.Location = New-Object System.Drawing.Point(350,300)
        $cancelButton.Size = New-Object System.Drawing.Size(75,23)
        $cancelButton.Text = 'Cancel'
        $cancelButton.Font = New-Object System.Drawing.Font($textFont,10)
        $cancelButton.ForeColor = $textColor
        $cancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
        $form.CancelButton = $cancelButton
        $form.Controls.Add($cancelButton)

        $label = New-Object System.Windows.Forms.Label
        $label.Location = New-Object System.Drawing.Point(10,20)
        $label.Size = New-Object System.Drawing.Size(280,20)
        $label.Text = 'Ticket Name:'
        $label.Font = New-Object System.Drawing.Font($textFont,10)
        $label.ForeColor = $textColor
        $form.Controls.Add($label)

        $ticketName = New-Object Windows.Forms.TextBox
        $ticketName.Location = New-Object System.Drawing.Point(10,40)
        $ticketName.Size = New-Object System.Drawing.Size(260,20)
        $form.Controls.Add($ticketName)

        $label2 = New-Object System.Windows.Forms.Label
        $label2.Location = New-Object System.Drawing.Point(10,100)
        $label2.Size = New-Object System.Drawing.Size(280,20)
        $label2.Text = 'Ticket Description:'
        $label2.Font = New-Object System.Drawing.Font($textFont,10)
        $label2.ForeColor = $textColor
        $form.Controls.Add($label2)

        $ticketDesc = New-Object Windows.Forms.TextBox
        $ticketDesc.Location = New-Object System.Drawing.Point(10,120)        
        $ticketDesc.Size = New-Object System.Drawing.Size(560,170)
        $ticketDesc.Multiline = $True
        $form.Controls.Add($ticketDesc)

        $form.Topmost = $true

        $form.Add_Shown({$ticketName.Select()})
        $form.ShowDialog()
} 

function SendMail 
{
    if($ticketName.Text.Length -gt 5 -and $ticketDesc.Text.Length -gt 15)
    {
        $tName = $ticketName.Text
        $tDesc = $ticketDesc.Text
        Send-MailMessage -From 'DHR Ticket <DHR@[][][].com>' -To 'Radoslav <[][][]' -Subject "$tName" -SmtpServer [][][] -Body "$tDesc"
    }
    else 
    {
        displayError -errorMsg "Please user a Name longer than 5 characters and a Description over 15!"
    }
}