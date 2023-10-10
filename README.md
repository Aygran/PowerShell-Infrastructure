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

# All AD User Audit -
  An auditing script that pulls all desired information from all enabled users in Active Directory. Easily editable to provide exact objects for your scope, also exports   contents as a time-stamped CSV, and includes an additional time-stamp at the bottom of the CSV after user data.

# Local Admin Groups -
  A little script that's come in handy a few times for myself. This will pull the list of users in a local group and display it in a csv. You can edit the said CSV and
  reuse it to add members to a local group as well.

# Service Status -
  Script that pulls all the current services on a server, showing who is assigned to run them, and their current status.

# Copy-Item with Logs - 
  This script is designed to be used with scheduled tasks for windows servers. Once you configure the source path, destination path, and log path, it will copy the files from the source to the destination, and tell you what was copied with the log file.

# Get Active Sessions for AD Users -
  This will check against a list of servers (preferably CSV format) and tell you if that username has an active rdp connection.