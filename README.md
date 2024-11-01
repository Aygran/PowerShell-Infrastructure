# PowerShell-Infrastructure
Powershell Scripts I designed for System Administration and Infrastructure Engineering. Open use for anyone who needs a script.<br><br>

I'm putting Powershell scripts I make here. <br>
Both for myself as a secure backup in the event they're deleted or lost somewhere in a file share,
also for others to use when they run into issues or need a problem solved. I can't count the number
of times someone on the internet's script saved me hours of time and headache!

# Auto Archive -
  This script is setup to be a scheduled task. Set it once, then forget. It will move files from one place to another, and create
  a detailed log of all operations it did. Adjust the $path, $destination, and how old you want the files to be before they're moved.
  Create a scheduled task, tell a service account to run it as admin, and forget about it.

# Exchange Mail Tracking Report -
  Was asked a few times this week about looking up smtp messages traversing our exchange. After about the 6th time of this unusual
  request, I decided to put this together so it can generate reports after some basic information. This does only work with on-premise
  exchange. But a user inputs their admin credentials, the script creates a new exchange PS Session, then the user puts in what sender
  and recipient they're looking for and if they want a report generated. There isn't a timeframe setup since it would have been too 
  weird from a syntax point of view taking that input and having users input it correctly so it just grabs the most recent stuff up
  to whatever you keep on your exchange logs. This script also uses the ImportExcel module, it's really great for generating reports.
  However, the setup here is very basic.

# pwTool -
![image](https://github.com/user-attachments/assets/89df6434-65eb-4bd5-ba60-c0ffb458cd3f)


  Was playing around a bit using .NET classes in powershell. This tool generates a password and lets admins with permissions change
  the password of specified accounts. For it to work right, run powershell as admin, then open the .ps1. If you try to right-click
  "run with Powershell" it could give an execution policy error. This is a beta version as well, there aren't any try/catches or
  error warnings - You have been warned. This is primarily an example of using .NET classes like forms in Powershell.

# Powershell REST API Template
  This is a rough template for accessing REST APIs like Swagger that use JSON data.<br>
  There are 2 main parts to this template, a authorization form to allow user input for username and password to generate a token<br>
  and the second part is a GET request that pulls the data into a variable, and exports specific information from the GET request<br>
  into a usable CSV file.

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

# Event Scanner -
  Scans event log on machine where it's ran, dumping the most recent Error messages into a easily digestable CSV located in C:\Temp\ErrorEventLog.csv
