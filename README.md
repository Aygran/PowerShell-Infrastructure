# PowerShell-Infrastructure
Powershell Scripts I designed for System Administration and Infrastructure Engineering. Open use for anyone who needs a script.<br><br>

I'm putting Powershell scripts I make here. <br>
Both for myself as a secure backup in the event they're deleted or lost somewhere in a file share,
also for others to use when they run into issues or need a problem solved. I can't count the number
of times someone on the internet's script saved me hours of time and headache!


# MSI Deployment Tool -
  Simple tool that will place an MSI installer on a target machine, run the MSI with configured arguments, then remove the installer.<br>
  Batch deployment using ForEach to do the install on a few to a few hundred servers at a time. <br>
    Requires Admin access to the servers <br>
    Requires Servers share a similar network or fileshare for the msi to be copied from. <br>
    
# Exchange Distribution Group Tool -
  A tool that will open a PS Session with an on-prem Exchange server, pull the cmdlets from the Exchange Shell into your shell session,
  then create the desired Distribution group, then run through a list of users specified to add to the distribution group.

# AD Users Last 30 Days -
  A very simple script that will generate a report of the most recent AD users created over the last 30 days. You can edit the script for a larger time frame, more or
  less properties, or even adjust the Export-CSV to HTML if you'd like.

# Delete After X Days -
  A script designed to do exactly as intended. This one-liner will delete anything in the desired folder path that's older than the amount of days set. Easy to setup as 
  an automated task as well to automate you're cleaning duties.
