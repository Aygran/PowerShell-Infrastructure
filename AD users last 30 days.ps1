<# 

Created by: Aygran
Last Updated: 8/8/22

Super simple script that will get all AD users created within the last 30 days, then export that list to a CSV.
To use, delete the # after Export-CSV and change it to wherever you'd like the report to go.

You can also change the properties if you're looking for other information.
You can also adjust the time period from 30 days to further back. Remember to use a negative number 
since we're technically adding a negative.

#>

$When = ((Get-Date).AddDays(-30)).Date
Get-ADUser -filter {whenCreated -ge $When} -Properties SamAccountName, Name, Enabled, Title | Export-CSV #"C:\temp\csv.csv"