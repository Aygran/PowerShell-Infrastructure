<#
    Written by: Aygran
    Version: 1.0
    Last Updated: 9/14/23

    This script copies the content from the source path to the destination path.
    It overwrites data with the latest changes.

    It uses the -verbose tag to generate a log, then out-file will copy the text
    from the verbose to generate a log of what's been copied.

    Replace the $sourcePath, $destinationPath, and $logFilePath to your desired
    locations. Source is what you want to copy, destination is where you want it
    copied, and logFilePath is where the log will live.
#>


$sourcePath = #"C:\Folder\Folder1"
$destinationPath = #"C:\Folder\Folder2"
$logFilePath = #"C:\Folder\backup-log.txt"

Copy-Item -Path $sourcePath -Destination $destinationPath -Force -Verbose |
    Out-File -Append -FilePath $logFilePath