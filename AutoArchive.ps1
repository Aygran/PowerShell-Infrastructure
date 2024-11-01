<# --------------------------------------------------

    Written By:     Aygran
    Last Updated:   11/1/2024
    Version #:      1.0

    A script for setting up an archive scheduled
    task. This takes files from one place that 
    are over X amount of days old, and moves
    them into another location. Use it to save
    space, cleanup readability, whatever else 
    you want.

    The script also creates a verbose logfile 
    in the destination for tracking changes.

    Change the following variables to the path
    you want. 
    $path = Where the current files/folders are.
    $destination = Where you want them to go.
    $days = how many days old. If you want to move
            stuff over 90 days old, set it to -90.

-------------------------------------------------- #>

$path = "C:\Your\Path\Here"
$destination = "C:\Your\Other\Path\Here"
$days = (Get-Date).AddDays(-90)

# - Prod
$VerbosePreference = "Continue"

Get-ChildItem "$destination\*.log" | Where-Object LastWriteTime -LT (Get-Date).AddDays(-15) | Remove-Item -Confirm:$false
$LogPathName = Join-Path -Path $LogPath -ChildPath "ArchiveLog-$(Get-Date -Format 'MM-dd-yyyy').log"

Start-Transcript $LogPathName -Append

$objs = Get-ChildItem -Path $path | Where-Object { $_.LastWriteTime -le $days } | Select-Object Name, LastWriteTime, FullName
Foreach ($obj in $objs) {
    $filepath = $obj.FullName
    $destinationPath = Join-Path -Path $destination -ChildPath $obj.Name
    Move-Item -Path $filepath -Destination $destinationPath -Verbose
}

Stop-Transcript