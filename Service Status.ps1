<# 

Created by: Aygran
Last Updated: 1/31/23

Simple one liner that pulls all services on a server, filters out the service name, who is assigned to the service, and it's current status.

Change the Export-CSV location in the quotation marks.

#>

Get-CIMInstance -Class Win32_Service | 
    Select Name, StartName, State | 
        Export-CSV "Change Me" -NoTypeInformation -Append
