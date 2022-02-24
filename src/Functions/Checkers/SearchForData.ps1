function dataFileExists 
{
    if(!(Test-Path $("$rootPath\src\Data\paths.txt")))
    {
        $y = New-Item "$rootPath\src\Data\" -Name "paths.txt" -ItemType "file"
        if($y.Length -ge 1){Write-Output "Something in the file is wrong!"}
    }

    $pathsFile = Get-Content -Path "$rootPath\src\Data\paths.txt"
    if($pathsFile.Length -lt 2)
    {
        return $False
    }
    else 
    {
        return $True   
    }
}
