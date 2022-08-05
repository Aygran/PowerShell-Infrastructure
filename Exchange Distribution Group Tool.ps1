<# ------------------------------------------------------------------------------------- >

                                      Written by: Aygran
                                     Last Updated: 8/5/22


                        This script will follow an order of operations to
                        pull the Exchange shell specific commands to your
                        powershell, then create a distribution group, then
                        add the list of users to said distribution group.

                        To use the script, fill out the variables beginning
                        with the $, then delete the # in front of the = sign.

                        You'll need a few things:

                        1. On-Prem or Hybrid Exchange Server
                        2. Admin permissions to said exchange server.
                        3. A user list. Create a text file, put the usernames
                        in the list. Use Save As for the text file, and save
                        it as a CSV.
< ------------------------------------------------------------------------------------- #>




$MailServer = #"Mailserver Host Name"
$UserCredential = Get-Credential
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri "http://$MailServer/PowerShell/" -Authentication Kerberos -Credential $UserCredential
$users = Get-Content #"Create a users.csv and place it wherever (I recommend on the C drive) then put the path here (C:\users.csv)"
$Note = #"Service Request / Ticket #, Your name, etc"
$DistroGroup = #"Name of Distribution Group"

Import-PSSession $Session -DisableNameChecking

   New-DistributionGroup -Name "$DistroGroup" -Notes $Note

    ForEach ($user in $users){
        Add-DistributionGroupMember -Identity "$DistroGroup" -Member $user
        }
