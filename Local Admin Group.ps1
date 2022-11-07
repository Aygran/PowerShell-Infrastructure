<# ---------------------------------------------

Script created by Aygran
Last updated: 11/7/22

Script for determining members of a local group 
on a specific server or adding members to a 
local group on a specific server.
Using CSVs to pull information.

--------------------------------------------- #>

# Update the Get-Content path and delete the #.
# Delete the # before one of the commands, either get local group members, or add.
$Serverlist = Get-Content # "C:\scripts\GISAdminServerList.csv"
ForEach ($Server in $Serverlist){

# Get the local group members inside the 'Administrators' group on a server.
Invoke-Command -ScriptBlock { Get-LocalGroupMember "Administrators"} -ComputerName $Server | Select PSComputerName, Name | Export-CSV "C:\Scripts\AdminGroup.csv" -Append -Verbose

# Add a local group member inside the 'Administrators' group on a server.
# invoke-command -ScriptBlock {Add-LocalGroupMember -Group "Administrators" -Member "ANTERO\Prod App Support"} -ComputerName $Server

}

