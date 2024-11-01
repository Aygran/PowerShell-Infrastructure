<# --------------------------------------------------

    Written By:     Aygran
    Last Updated:   11/1/2024
    Version #:      1.0

    Asks admin for specific information to grab
    recent mail logs for specified sender and 
    recipient from the desired mail server.

    Able to Generate a report or have it list all
    information in the terminal. Will import 
    powershell Excel tools for generating said
    report.

    Requires exchange admin credentials.
    Do not change anything below.

-------------------------------------------------- #>

# Variables.
$timestamp = Get-Date -Format "MM-dd"
$Creds = Get-Credential
$Mailsvr = Read-Host -prompt "Enter Mailserver name - i.e MAIL01"
$MailSender = Read-Host -prompt "Enter senders email address"
$MailRecipient = Read-Host -Prompt "Enter recipient email address"
$Report = Read-Host -Prompt "Would you like a Report Generated? Y or N."

# Establish Mail Connection.
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri http://$Mailsvr/PowerShell -Authentication Default -Credential $Creds
Write-Host "Establishing Exchange Session"
Import-PSSession $Session

# Mail string.
$Mail = Get-MessageTrackingLog -Sender $MailSender -Recipients $MailRecipient -Source SMTP -Server $Mailsvr | Select-Object Timestamp, Sender, Recipients, MessageSubject

# Reporting.
If ($Report -eq "Y"){
    # Checks for Excel module first.
    $Module = Get-Module | ? {$_.name -eq "ImportExcel"}
    If ($Module -eq $Null) {
    Install-Module ImportExcel -Credential $Creds -Force
    Import-Module ImportExcel -Force
    } 
    $Mail | Export-Excel -Path "C:\Temp\MailLog-$timestamp"
    Write-Host "Excel Report generated: C:\Temp\MailLog-$timestamp.xlsx"
} ElseIf ($Report -eq "N"){
    Write-Host "Generating Log in Terminal for Sender $MailSender Recipient $MailRecipient on $timestamp"
    $Mail
}

# Close Exchange Session.
Write-Host "Closing Exchange Session"
Remove-PSSession $Session