function  Add-Column
{
    param 
    (
        $columnCount,
        $selectedColumnRange
    )

    $columnsSelected = $sheet.Columns($selectedColumnRange)
    for ($i = 0; $i -lt $columnCount; $i++) 
    {
        [void] $columnsSelected.Insert()
    }
}
function Clear-Rows
{
    for($i=1;$i -lt $count;$i++)
{    
    if($sheet.Cells.Item($i,1).text -eq 'A' -or $sheet.Cells.Item($i,1).text -eq 'X' -or [string]::IsNullOrEmpty($sheet.Cells.Item($i,1).text))
    {
        [void]$sheet.Cells.Item($i,1).EntireRow.Delete()
    }
}
}