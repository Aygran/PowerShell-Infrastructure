<#    ------------------------------------------------------------------------------
                            MSI Deployment Script
                            Created by: Aygran
                            Last Updated: 8/3/22

                Used to deploy MSI's to as many servers as needed through
                a list. To configure, set the variables as needed and
                Remove the # before the variables before running.

                Script itself copies an Item you set from the location you
                set, then runs the MSI with appropriate arguments set. After
                which the script will delete the original MSI installer 
                before moving on to the next item in the list.

                            Script MUST be ran as Administrator!

    ------------------------------------------------------------------------------    #>

$Servers = Get-Content #"Put Server List you want to deploy to here (C:\temp\servers.csv) NOTE Server list must be named Servers"
$Item = #"Put Item you want to deploy here (C:\Installer.msi)"
$MSI = #"Put the name of the installer here (Installer.msi)"
$Arguments = #"Arguments go here. (/i c:\installer.msi /l*v installer_log.log /quiet)"

# Foreach will segment the list and perform the operation against every item in the list.
Foreach ($Server in $Servers){

    # Copy-Item will copy the existing $item and place it on the C drive of $Server.
        # I've found that sometimes when doing big lists, it's easier than trying to pull an msi directly from a network location.
    Copy-Item $Item "\\$Server\C$\$Item"

    # This is telling the $Server to run whatever is in -ScriptBlock{} as if it were running on the machine itself.
        # This effect can also be accomplished by using Enter-PSSession -ComputerName $Server, then using the Exit-PSSession
    Invoke-Command -ComputerName $Server -ScriptBlock 
        {
            # MSIExec.exe is the Microsoft executable that runs according to the $Arguments.
                # In $Arguments, declare what the msi is with /i C:\MSI_Name.msi
            Start-Process "MSIExec.exe" -Wait -Argumentlist $Arguments
        }
    # This will always tell you it's successful. If it's surrounded by big red words, it wasn't successful :<
    Write-Host "$Item Install Successful on $Server"

    # Deletes the msi installer that was copied to the $Server
    Invoke-Command -ComputerName $Server -ScriptBlock 
        {
            Remove-Item $Item
        }
}