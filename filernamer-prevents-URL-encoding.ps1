# Define the target folder
$folderPath = "C:\xampp\htdocs\myweb\"

# Get all files in the folder
Get-ChildItem -Path $folderPath -File | ForEach-Object {
    $oldName = $_.Name
    $oldPath = $_.FullName

    # Match filenames like "something (number).extension"
    if ($oldName -match "^(.*) \((\d+)\)\.(\w+)$") {
        $baseName = $matches[1] -replace " ", "-"
        $number = [int]$matches[2] # Convert to integer to format as 2 digits
        $extension = $matches[3]
        
        # Construct new filename
        $newName = "{0}-{1:D2}.{2}" -f $baseName, $number, $extension
        $newPath = Join-Path -Path $folderPath -ChildPath $newName
        
        # Rename the file
        Rename-Item -Path $oldPath -NewName $newName
        Write-Host "Renamed: $oldName -> $newName"
    } else {
        Write-Host "Skipped: $oldName (format not recognized)"
    }
}
