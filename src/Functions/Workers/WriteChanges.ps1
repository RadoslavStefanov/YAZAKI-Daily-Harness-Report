function writeChanges
{
    try 
    {
        $xl = New-Object -comobject Excel.Application
        $xl.Visible = $showProcess.Checked
        $xl.DisplayAlerts = $False
        $wb = $xl.Workbooks.open("$global:rootPath\src\Temp\MergedTemp")
        $sheet = $wb.Sheets.Item(1)

        
        $sheet.Cells.Item(1,1).EntireRow.Delete()
        $c = $sheet.UsedRange.Rows.Count
        $copyRange = $sheet.Range("A1:O$c")
        $copyRange.copy()

        $xl2 = New-Object -comobject Excel.Application
        $xl2.Visible = $showProcess.Checked
        $xl2.DisplayAlerts = $False

        if($valmetSelector.Checked)
        {$wb2 = $xl2.Workbooks.open("$rootPath\Output\[][][]\[][][].xlsx")}
        else{$wb2 = $xl2.Workbooks.open("$rootPath\Output\Output.xlsx")}
        
        $sheet2 = $wb2.Sheets.Item(1)

        $c2 = $sheet2.UsedRange.Rows.Count
        $pasteRange = $sheet2.Range("A$c2")
        $sheet2.Paste($pasteRange)
        
        $wb.Save()
        $wb.Close()
        $xl.Quit()

        $wb2.Save()
        $wb2.Close()
        $xl2.Quit()
    }
    catch 
    {
        displayError -errorMsg $_
    }
    
}