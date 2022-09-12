<# ------------------------------------------------------------------

                            Get All AD Users

                       Written by: Aygran
                       Created: 9/12/22

                This script will examine all enabled users
                in Active Directory, pull their information
                as well as select information like their
                username, date created, verifying they're
                enabled, current job title, last time the
                AD Account has been modified, their manager,
                their Orgizational Unit, and a description
                if there is any.

------------------------------------------------------------------ #>
        
        # Date generates the exact date and time down to the milisecond.
        $Date = Get-Date

        # FullDate is used for the in-CSV Timestamp by pulling the Date variable into a readable format.
        $FullDate = $Date.ToString('MM-dd-yyyy HH:mm:ss')

        # NameDate is used for the file naming convention.
        $NameDate = $Date.ToString('MM-dd-yyyy')

        # $ADUser will perform a search for all users in AD that are currently enabled. Then filter all properties, lastly, select the requested ones using Select-Object.
        $ADUser = Get-ADUser -Filter "enabled -eq 'true'" -Properties * | Select-Object # SAMAccountname, Created, Enabled, Modified, LastLogonDate, DistinguishedName, employeeType, Description

        # Export-CSV creates headers and formats the data from ADUser into a readable format.
        $ADUser | Export-CSV "C:\temp\AD_Audit_$NameDate.csv" -Verbose -Append -NoTypeInformation -Force

        # Attaching FullDate to the Out-File lets it add the information to the CSV without disrupting the headers originally created by ADUser.
        $FullDate | Out-File "C:\temp\AD_Audit_$NameDate.csv" -Append