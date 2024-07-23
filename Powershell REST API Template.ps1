<# ------------------------------------------------------------------------------------- >

                                      Written by: Aygran
                                     Last Updated: 7/23/24


                        This script is a template for formulating API
                        get / post requests using Powershell. Specifically
                        API's that use Swagger or JSON, and converting it
                        into usable powershell reporting.

                        There are a few optional pieces, so really, take
                        the parts that you need and discard the ones you don't.
                        everything is setup to be easily digestable so you 
                        only have to input for your specific environment
< ------------------------------------------------------------------------------------- #>

# Username and Password for Token
#    If the API you're trying to access requires a sign in to generate a token, this is 
#    a easy way to ask for an input while masking passwords for privacy.

# Prompt for username and password.
$username = Read-Host "Enter your Username"
$password = Read-Host "Enter your Password" -MaskInput

# Establishes token for authentication.
Write-Host "Establishing Authentication..."
$uri = "https://YourAPI.com/v2/auth/"

# You may need to update your headers depending on what the API is asking for.
# This template assumes you're working with JSON data.
$headers = @{
    "accept" = "application/json"
    "Content-Type" = "application/json"
}
$body = @{
    username = "$username"
    password = "$password"
} | ConvertTo-Json

# This is your actual invoke method that we're storing into a variable to use only part of the response.
$response = Invoke-RestMethod -Uri $uri -Method Post -Headers $headers -Body $body

# If the token is called something other than "token" you may have to update the $response.token
$token = $response.token
Write-Host "Authentication Successful..."

# Now the token is stored in the $token variable

# Generates GET request using the $token and saves it to a timestamped folder.
# Modify the URI you're trying to connect to, as well as the header definitions if needed.

Write-Host "Generating API GET request..."
$uri1 = "https://YourAPI.com/v2/change/me
$headers1 = @{
    "accept" = "application/json"
    "Authorization" = "Bearer $token"
}

# This is the actual GET request method.
$GetRequest = Invoke-RestMethod -Uri $uri1 -Method Get -Headers $headers1

# This generates a timestamp like APR-23
$timestamp = Get-Date -Format "MMM-dd"

# Update the $GetRequest.Object to the variable you're trying to grab from the GET request.
$GetRequest.Object | Export-CSV "C:\Temp\MyThing-$timestamp.csv"
Write-Host "Report successfully generated. File location: C:\Temp\MyThing-$timestamp.csv"