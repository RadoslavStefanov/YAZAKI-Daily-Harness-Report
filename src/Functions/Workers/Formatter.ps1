.("$rootPath\src\Functions\Workers\ExcelHelper.ps1")
function formatMainFile
{
    param 
    (
        $filePath,
        $isSpecial
    )
    try 
    {
        $fileName = Split-Path $filePath -leaf

        #[The columns for deletion]
        $delColArr = @('AH:BZ','AA:AF','W','F:U','C:D','A')

        #[Function that clear AXE rows]

        #[Opens excel process]
        $xl = New-Object -comobject Excel.Application
        $xl.Visible=$showProcess.Checked

        #[Ignores the trust alert]
        $xl.DisplayAlerts = $False

        #[Opens the file and selects the 1st sheet]
        $wb = $xl.Workbooks.open("$filePath")

        $wb.saveas("$global:rootPath\src\Temp\$fileName", [Microsoft.Office.Interop.Excel.XlFileFormat]::xlOpenXMLWorkbook)
        
        $sheet = $wb.Sheets.Item(1)

        #[Save the delivery notes]
        if($valmetSelector.Checked)
        {
            $valTransfer = $sheet.Columns.Item(35).value2
            $sheet.Columns.Item("CA")= $valTransfer
        }


        #[Deletes the columns from the array]
        for($i=0;$i -lt $delColArr.Length;$i++)
        {    
            $sheet.Columns.item($delColArr[$i]).EntireColumn.Delete()
        }

        #[Aligns table banners]
        $sheet.Cells.item(1,2).Delete();
        $sheet.Cells.item(1,3).Delete();
        $sheet.Cells.item(1,4).Delete();
        $sheet.Cells.item(1,6).Delete();
        $sheet.Cells.item(1,7).Delete();

        #[Remove empty rows -> A/X]
        $count = $sheet.UsedRange.Rows.Count
        Clear-Rows
        $count = $sheet.UsedRange.Rows.Count
        Clear-Rows

        #[Adds 000 to the JIT numbers]
        $count = $sheet.UsedRange.Rows.Count
        for($i=2;$i -le $count;$i++)
        {    
            $tempVal = $sheet.Cells.Item($i,1).text
            $sheet.Cells.Item($i,1).value = "'000$tempVal"
        }

        #[Adds the A and C column]
        Add-Column -columnCount 1 -selectedColumnRange "B:B"
        Add-Column -columnCount 1 -selectedColumnRange "A:A"

        #[Adds names to the newly added columns]
        $sheet.Cells.Item(1,1).value = "'Class"
        $sheet.Cells.Item(1,3).value = "'Type:"

        #[Check for TYPE/Class and populates the cells]
        $count = $sheet.UsedRange.Rows.Count
        for($i=2;$i -le $count;$i++)
        {    
            $compMaterial = $sheet.Cells.Item($i,9).text

            $classFiller = ""
            $typeFiller = ""

            switch ($compMaterial) 
            {
                "CG00001201" 
                { 
                    $classFiller = "'[][][]"
                    $typeFiller = "'[][][]"
                }
                "CG00001026" 
                { 
                    $classFiller = "'[][][]"
                    $typeFiller = "'[][][]"
                }
                ......................................................
                Default 
                {
                    $classFiller = "'Unknown CG"
                    $typeFiller = "'Unknown CG"
                }
            }

            $sheet.Cells.Item($i,1).value = $classFiller
            $sheet.Cells.Item($i,3).value = $typeFiller
        }

        #[Take CGs]
        $CGs = $sheet.Columns.Item("I").value2

        #[Adds columns]
        Add-Column -columnCount 2 -selectedColumnRange "D:D"

        #[Moves the time columns afte the TYPE]
        $colTransfer1 = $sheet.Columns.Item(8).value2
        $colTransfer2 = $sheet.Columns.Item(10).value2
        $sheet.Columns.Item("J").EntireColumn.Delete()
        $sheet.Columns.Item("H").EntireColumn.Delete()
        $sheet.Columns.Item(4)= $colTransfer1
        $sheet.Columns.Item("E").NumberFormat = "h:mm:ss"
        $sheet.Columns.Item("E")= $colTransfer2

        #[Adds the A and C column]
        Add-Column -columnCount 3 -selectedColumnRange "F:F"

        #[Populates Daimler/Valmet]
        $sheet.Cells.Item(1,8).value = "'Customer"

        $customerFiller = "'[][][]"
        if($[]Selector.Checked)
        {$customerFiller="'[][][]"}

        for($i=2;$i -le $count;$i++)
        {$sheet.Cells.Item($i,8).value = $customerFiller}

        $sheet.Columns.item("L").EntireColumn.Delete()
        $sheet.Columns.item("I").EntireColumn.Delete()

        #[Adds columns]
        Add-Column -columnCount 2 -selectedColumnRange "D:D"

        $colTransfer1 = $sheet.Columns.Item("L:L").value2
        $sheet.Columns.item("L").EntireColumn.Delete()
        $sheet.Columns.Item("O")= $colTransfer1

        $sheet.Columns.item("D").EntireColumn.Delete()
        $sheet.Columns.item("D").EntireColumn.Delete()
        Add-Column -columnCount 2 -selectedColumnRange "K:K"

        #[Replaces dates for Valmet]
        if($valmetSelector.Checked)
        {
            $dateTransfer = $sheet.Columns.Item(9).value2
            $sheet.Columns.Item("D")= $dateTransfer
            $sheet.Cells.Item(1,4).value = "'PldReqDate"
        }

        #[Names the ValmetDeliveryNote Cell ]
        if($valmetSelector.Checked)
        {$sheet.Cells.Item(1,10).value = "'DeliveryNote"}
       

        #[Auto-fits the cells]
        $sheet.UsedRange.Columns.Autofit()


        $sheet.Columns.Item("N")= $CGs
        
        $wb.saveas("$global:rootPath\src\Temp\$fileName", [Microsoft.Office.Interop.Excel.XlFileFormat]::xlOpenXMLWorkbook)

        if($isSpecial -eq 0){$global:mainTempFile = "$global:rootPath\src\Temp\$fileName"}
        else{$global:specialTempFile = "$global:rootPath\src\Temp\$fileName"}   
        #[Terminates the excel process]
        $wb.Close($true)
        $xl.Quit()
    }
    catch
    {
        displayError -errorMsg $_
    }
    
}