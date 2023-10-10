<#

    Written by: Aygran
    Last Updated: 10/9/2023
    Version #: 1.0.0

    This script scans the list of provided servers to
    identify if a specific user has an open connection.

    You can adjust this for an array of servers if you'd rather not use a CSV

    Update the $servers to a list. CSV files are easiest.
    Update the $adUser to what user you're looking for who may have an active connection.

    Really useful for admin accounts before you change a password to avoid locking
    yourself out of the domain every 5 seconds trying to auth to a server you forgot
    to log off of... could never be me.

#>

$servers = Get-Content "C:\Server\List\Location.csv"
$adUser = "userAccountName"

Write-Host "Script Started."

forEach ($Server in $Servers) {
    $sessions = Invoke-Command -Computername $Server -ScriptBlock { quser } -ErrorAction SilentlyContinue

    if ($sessions -match $adUser) {
        Write-Host "$adUser is connected to $Server" }
    }