<#  
    Made by Aygran

    If you already have the AD Module, you can delete or comment out
    line 12 "import-module ActiveDirectory".

    Replace the location in $Users with the location of your CSV.
    Replace the "Group Name" with the name of your AD Group.
    Run and Done.
#>

import-module ActiveDirectory
$Users = Get-Content "C:\your-users.csv"
$Group = "Group Name"

Foreach ($User in $Users) {
    Add-ADGroupMember -Members $User -Identity $Group
}