# PowerShell-Infrastructure
Powershell Scripts I designed for System Administration and Infrastructure Engineering. Open use for anyone who needs a script.

I'm putting Powershell scripts I make here. 
Both for myself as a secure backup in the event they're deleted or lost somewhere in a file share, 
also for others to use when they run into issues or need a problem solved. I can't count the number
of times someone on the internet's script saved me hours of time and headache!


MSI Deployment Tool -
  Simple tool that will place an MSI installer on a target machine, run the MSI with configured arguments, then remove the installer.
  Batch deployment using ForEach to do the install on a few to a few hundred servers at a time. 
    Requires Admin access to the servers
    Requires Servers share a similar network or fileshare for the msi to be copied from.
    
Exchange Distribution Group Tool -
  A tool that will open a PS Session with an on-prem Exchange server, pull the cmdlets from the Exchange Shell into your shell session,
  then create the desired Distribution group, then run through a list of users specified to add to the distribution group.
