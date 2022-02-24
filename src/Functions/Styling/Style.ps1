function styleFile
{
    $xl = New-Object -comobject Excel.Application
    $xl.Visible = $showProcess.Checked
    $xl.DisplayAlerts = $False
    $wb = $xl.Workbooks.open("$global:rootPath\src\Temp\MergedTemp")
    $sheet = $wb.Sheets.Item(1)

    function borderUsedRange
    {
        $c = $sheet.UsedRange.Rows.Count
        $c1 = $c+1

        $sheet.Range("A1:N$c1").Borders.item(3).LineStyle = 1
        $sheet.Range("A1:N$c").Borders.item(10).LineStyle = 1
        $sheet.Range("A1:N$c").Borders.item(1).LineStyle = 1
    }

    function centerText
    {
        $sheet.Range("A:N").HorizontalAlignment = -4108
        $sheet.Range("A:N").VerticalAlignment = -4108
    }

    function bigger1StRow
    {
        $cell = $sheet.range('A1')
        $cell.RowHeight = 25
    }

    

    borderUsedRange
    bigger1StRow
    centerText
    $sheet.UsedRange.Columns.Autofit()
    if($valmetSelector.Checked)
    {$wb.saveas("$rootPath\Output\[][][]\[][][]", [Microsoft.Office.Interop.Excel.XlFileFormat]::xlOpenXMLWorkbook)}
    else 
    {$wb.saveas("$rootPath\Output\Output", [Microsoft.Office.Interop.Excel.XlFileFormat]::xlOpenXMLWorkbook)}
    $wb.Close()
    $xl.Quit()
}

function colorRHD
{
    param
    (
        $iteration
    )

    for($i=1;$i -le $iteration;$i++)
    {
        if($sheet.Rows.Item($i).Columns.Item("C").Text -eq "RHD")
        {
            $sheet.Range("A$($i):N$($i)").interior.colorindex = 6
        }
    }
}

function styleAfterMerge
{
    $xl = New-Object -comobject Excel.Application
    $xl.Visible = $showProcess.Checked
    $xl.DisplayAlerts = $False

    if($valmetSelector.Checked)
    {$wb = $xl.Workbooks.open("$rootPath\Output\[][][]\[][][]")}
    else{$wb = $xl.Workbooks.open("$rootPath\Output\Output")}
    
    $sheet = $wb.Sheets.Item(1)


    function borderUsedRange1
    {
        $c = $sheet.UsedRange.Rows.Count
        $c1 = $c+1

        $sheet.Range("A1:N$c1").Borders.item(3).LineStyle = 1
        $sheet.Range("A1:N$c").Borders.item(10).LineStyle = 1
        $sheet.Range("A1:N$c").Borders.item(1).LineStyle = 1
    }

    function centerText1
    {
        $sheet.Range("A:N").HorizontalAlignment = -4108
        $sheet.Range("A:N").VerticalAlignment = -4108
    }

    function bigger1StRow1
    {
        $cell = $sheet.range('A1')
        $cell.RowHeight = 25
    }

    

    borderUsedRange1
    bigger1StRow1
    centerText1

    $sheet.UsedRange.Columns.Autofit()
    if($valmetSelector.Checked)
    {$wb.saveas("$rootPath\Output\[][][]\[][][]", [Microsoft.Office.Interop.Excel.XlFileFormat]::xlOpenXMLWorkbook)}
    else 
    {$wb.saveas("$rootPath\Output\Output", [Microsoft.Office.Interop.Excel.XlFileFormat]::xlOpenXMLWorkbook)}
    
    $wb.Close()
    $xl.Quit()
}

