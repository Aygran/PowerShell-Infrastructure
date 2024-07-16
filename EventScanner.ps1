<# ------------------------------------------------------------------------------------- >

                                      Written by: Aygran
                                     Last Updated: 7/16/24


                        This script pulls all the most recent Error 
                        event logs and dumps them into a readable CSV
                        located at C:\Temp.

                        If you're looking for different event levels
                        like Information or Warning, update the part
                        inside Where-Object: 
                        {$_.LevelDisplayName -eq "EVENT LEVEL"}
< ------------------------------------------------------------------------------------- #>

$application = Get-WinEvent -LogName Application -MaxEvents 100 | Where-Object {$_.LevelDisplayName -eq "Error"} | Select-Object TimeCreated, ID, LevelDisplayName, Message
$security = Get-WinEvent -LogName Security -MaxEvents 100 | Where-Object {$_.LevelDisplayName -eq "Error"} | Select-Object TimeCreated, ID, LevelDisplayName, Message
$system = Get-WinEvent -LogName System -MaxEvents 100 | Where-Object {$_.LevelDisplayName -eq "Error"} | Select-Object TimeCreated, ID, LevelDisplayName, Message
$application | Export-CSV -Path "C:\Temp\ErrorEventLog.csv" -NoTypeInformation -Append -Force
$security | Export-CSV -Path "C:\Temp\ErrorEventLog.csv" -NoTypeInformation -Append
$system | Export-CSV -Path "C:\Temp\ErrorEventLog.csv" -NoTypeInformation -Append