$specialDict = @{}
$mainArr = New-Object Collections.Generic.List[String]
function vLookUp
{
    $xl = New-Object -comobject Excel.Application
    $xl.Visible = $showProcess.Checked
    $xl.DisplayAlerts = $False
    $wb = $xl.Workbooks.open($global:specialTempFile)
    $sheet = $wb.Sheets.Item(1)

    $cCount = $sheet.UsedRange.Rows.Count
    populateSpecialArr -usedRangeCount $cCount
    $wb.Save()
    $wb.close()

    $wb = $xl.Workbooks.open($global:mainTempFile)
    $sheet = $wb.Sheets.Item(1)
    $cCount = $sheet.UsedRange.Rows.Count
    populateMainArr -usedRangeCount $cCount
    colorRHD -iteration $cCount
    applyTypeChange
    
}

function populateSpecialArr
{
    param
    (
        $usedRangeCount
    )
    for($i=2;$i -le $usedRangeCount;$i++)
    {
        $key = $sheet.Rows.Item($i).Columns.Item("B").Text
        $val =$sheet.Rows.Item($i).Columns.Item("N").Text
        if (! $specialDict.ContainsKey($key))
        {
            $specialDict.Add($key,$val)
        }
        
    }
}

function populateMainArr
{
    param
    (
        $usedRangeCount
    )
    for($i=2;$i -le $usedRangeCount;$i++)
    {
        $key = $sheet.Rows.Item($i).Columns.Item("B").Text
        $mainArr.Add($key)
    }
}

function applyTypeChange
{
    for($i=1;$i -le $cCount;$i++)
    {
        $exists = $false
        $cg = ""
        foreach ($x in $specialDict.Keys)
        {
            if($mainArr[$i] -eq $x)
            {
                $cg = $specialDict[$x]
                $exists = $true
                break
            }
        }
        if($exists)
        {
            $tempText = $sheet.Rows.Item($i+2).Columns.Item("C").Text
            $append = ""
            switch ($cg)
            {
                "[][][]"
                {
                    $append = "HYB"
                }
                "[][][]"
                {
                    $append = "AMG"
                }
                "[][][]"
                {
                    $append = "HYB"
                }
                "[][][]"
                {
                    $append = "AMG"
                }
                Default 
                {
                    $append = "ERR"
                }
            }
            $sheet.Cells.Item($i+2,3).value = "$tempText $append"
        }
    }
    [void] $sheet.UsedRange.Columns.Autofit()
    $sheet.Columns.item("N").EntireColumn.Delete()
    $wb.saveas("$global:rootPath\src\Temp\MergedTemp", [Microsoft.Office.Interop.Excel.XlFileFormat]::xlOpenXMLWorkbook)
    $wb.save()
    $wb.Close()
    $xl.Quit()
}