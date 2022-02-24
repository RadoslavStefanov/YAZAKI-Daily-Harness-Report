
function startLoading
{
    if($darkmodeSelector.Checked -eq $true)
    {$loadingImage = [System.Drawing.Image]::Fromfile(".\src\GUI\images\workingDark.png");}
    else 
    {$loadingImage = [System.Drawing.Image]::Fromfile(".\src\GUI\images\working.jpg");}
    
    $Ticket.Visible=$False;
    $loader.Image=$loadingImage
    $loader.Visible = $True
}

function stopLoading
{
    $loader.Visible = $False
    $Ticket.Visible=$True;
}