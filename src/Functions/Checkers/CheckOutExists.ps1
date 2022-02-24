function checkOutExists
{
    if($valmetSelector.Checked)
    {return Test-Path -Path "$rootPath\Output\[][][]\[][][].xlsx" -PathType Leaf}
    return Test-Path -Path "$rootPath\Output\Output.xlsx" -PathType Leaf
}