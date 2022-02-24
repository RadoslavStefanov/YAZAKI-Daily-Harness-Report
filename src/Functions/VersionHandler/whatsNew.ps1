function showWhatsNew 
{
        Add-Type -AssemblyName System.Windows.Forms
        Add-Type -AssemblyName System.Drawing

        $form = New-Object System.Windows.Forms.Form
        $form.Text = 'Whats new'
        $form.Size = New-Object System.Drawing.Size(600,400)
        $form.StartPosition = 'CenterScreen'
        $form.BackColor = $formColor
        $form.FormBorderStyle = 'Fixed3D'
        $form.MaximizeBox = $false


        $label = New-Object System.Windows.Forms.Label
        $label.Location = New-Object System.Drawing.Point(10,20)
        $label.Size = New-Object System.Drawing.Size(600,280)
        $label.Text = 'The color and coms UPDATE 1.2
        -This update adds a few quality of life features.
        -DHR is now centralized and will get server based updates.
            This would mean that users will get a prompt as soon as DHR discovers
            a new version is avaylable.
        -Separated (work buttons) from (debug buttons). Users will find that (Keep input)
            and (Valmet) buttons are grouped on the left side. Not the daily used buttons will
            be easily accessible.
        -Added admin panel
        -New personalized feature is the ColorPicker. On the top-rigth corner of the
            DHR logo users will find a colorfull icon. On-click this icon will display a ColorPick
            interface, where users can choose a custom color for their own DHR instance.
        -Ticket system. On the DHR GUI there is a new button called (HELP), this button
            leads users to a Ticket Form, where after being filled it will send an email to
            the responsible maintenance personel.
        -Fixed the resizing issue.
        -DHR is always starting in the center of the screen. No more chasing.'
        $label.Font = New-Object System.Drawing.Font($textFont,10)
        $label.ForeColor = $textColor
        $form.Controls.Add($label)


        $okButton = New-Object System.Windows.Forms.Button
        $okButton.Location = New-Object System.Drawing.Point(250,300)
        $okButton.Size = New-Object System.Drawing.Size(75,23)
        $okButton.Text = 'OK'
        $okButton.Font = New-Object System.Drawing.Font($textFont,10)
        $okButton.ForeColor = $textColor
        $okButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
        $form.Controls.Add($okButton)     

        $form.Topmost = $true

        $form.Add_Shown({$label.Select()})
        $form.ShowDialog()
}