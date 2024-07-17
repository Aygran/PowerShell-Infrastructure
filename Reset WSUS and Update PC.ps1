<#--------------------------------------------------

Reset WSUS and Update PCs
Written by:     Aygran
Last Modified:  5/28/2024

All information is transcribed into a log.
This script checks PC's from the $PCs = Get-Content -Path "".
It verifies if the the PC is online, then if it can verify a connection, will run 3 important commands.
1st it installs the PS Windows Update module and Imports it.
2nd it reset's the Windows Update Components.
3rd It forces the PC to check in with WSUS and accept all updates, install them, but not reboot.

--------------------------------------------------#>

# Enables Verbose for all activity.
$VerbosePreference = "Continue"

# Log File Path and Name.
$date = Get-Date -Format MM-dd-yyyy
$LogPath = "Change Me"
$LogPathName = Join-Path -Path $LogPath -ChildPath "Updater-$date.log"

# Begin Logging
Start-Transcript $LogPathName -Append

# Modify PC's List before running
$PCs = Get-Content -Path "Add the path to your CSV here"

ForEach ($pc in $PCs) {
    Write-Host " --- Connecting to $pc ---"
    # Tests Connection via ICMP
    $ping = Test-Connection -ComputerName $pc -Count 1 -Quiet
    Write-Host " --- $pc ping is $ping ---"

    # If the Ping is successful, it will continue. Otherwise it will skip to the Else statement
    if ($ping -eq $true) {
        Invoke-Command -ComputerName $pc -ScriptBlock {
            # This installs the PS Windows Update Module
            Install-Module -Name PSWindowsUpdate -Force
            Import-Module PSWindowsUpdate

            # This is a part of the PS Windows Update Module to reset the WUA connection and check in with WSUS.
            Reset-WUComponents -Verbose
            
            # $History grabs the latest results to verify the last time it checked in after the WUA Reset.
            $History = Get-WULastResults | Select-Object LastSearchSuccessDate, LastInstallationSuccessDate
            Write-Host "$pc $History"
        }
        # This invokes the update download and install process as long as $ping is equal to true.
        Invoke-WUJob  -ComputerName $pc -Script { Get-WUInstall -AcceptAll -IgnoreReboot -Install } -Confirm:$false -Verbose -RunNow
    }
    # If the Ping fails, it will tell us it failed to connect and put it in the logfile.
    else {
        Write-Host " --- Failed to connect to $pc ---"
    }
}

# This stops the logging after the script is finished.
Stop-Transcript