function populateFields
{
    $local:savedPaths = getInputFilePath
    if($null -ne $local:savedPaths)
    {
        if($local:savedPaths[0].Length -ne 0)
        {
            $mainText.text = $local:savedPaths[0]
            $specialText.text = $local:savedPaths[1]
            $archiveText.text = $local:savedPaths[2]
        }
    }
    
    
}