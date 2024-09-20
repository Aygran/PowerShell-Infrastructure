<# --------------------------------------------------

                Written by: Aygran
               Last Updated: 9/20/24

        This is a work in progress. More of
        testing importing .NET components
        into Powershell. This uses the form
        component to create a simple GUI 
        when ran. The form lets you fill out
        fields, generate a complex password,
        and change the password of the
        account that you provide. However,
        you still need AD permissions in
        order to change the password.

        Running form components through
        powershell is a little janky, but it
        was a neat little project.


-------------------------------------------------- #>

#region .NET Forms
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
Import-Module -Name ActiveDirectory

# Form
$form = New-Object System.Windows.Forms.Form
$form.Text = "Password Generator"
$form.Size = New-Object System.Drawing.Size(350, 375)

# Password Length
$labelLength = New-Object System.Windows.Forms.Label
$labelLength.Text = "Password Length:"
$labelLength.Location = New-Object System.Drawing.Point(10, 28)
$labelLength.Size = New-Object System.Drawing.Size(100, 20)
$form.Controls.Add($labelLength)

$textboxLength = New-Object System.Windows.Forms.NumericUpDown
$textboxLength.Minimum = 12
$textboxLength.Maximum = 32
$textboxLength.Value = 16
$textboxLength.Location = New-Object System.Drawing.Point(120, 28)
$textboxLength.Size = New-Object System.Drawing.Size(60, 10)
$form.Controls.Add($textboxLength)

# Service Account Name
$labelSvcAcc = New-Object System.Windows.Forms.Label
$labelSvcAcc.Text = "Account"
$labelSvcAcc.Location = New-Object System.Drawing.Point(10, 60)
$labelSvcAcc.Size = New-Object System.Drawing.Size(100, 30)
$form.Controls.Add($labelSvcAcc)

$textboxSVC = New-Object System.Windows.Forms.TextBox
$textboxSVC.Location = New-Object System.Drawing.Point(120, 60)
$textboxSVC.Size = New-Object System.Drawing.Size(150, 20)
$textboxSVC.ReadOnly = $false
$form.Controls.Add($textboxSVC)

# Old Password
$labelOldPW = New-Object System.Windows.Forms.Label
$labelOldPW.Text = "Old Password:"
$labelOldPW.Location = New-Object System.Drawing.Point(10, 90)
$labelOldPW.Size = New-Object System.Drawing.Size(100, 30)
$form.Controls.Add($labelOldPW)

$textboxOldPW = New-Object System.Windows.Forms.TextBox
$textboxOldPW.Location = New-Object System.Drawing.Point(120, 90)
$textboxOldPW.Size = New-Object System.Drawing.Size(150, 20)
$textboxOldPW.ReadOnly = $false
$form.Controls.Add($textboxOldPW)

# New Password
$labelNewPW = New-Object System.Windows.Forms.Label
$labelNewPW.Text = "New Password:"
$labelNewPW.Location = New-Object System.Drawing.Point(10, 120)
$labelNewPW.Size = New-Object System.Drawing.Size(100, 30)
$form.Controls.Add($labelNewPW)

$textboxPassword = New-Object System.Windows.Forms.TextBox
$textboxPassword.Location = New-Object System.Drawing.Point(120, 120)
$textboxPassword.Size = New-Object System.Drawing.Size(150, 30)
$textboxPassword.ReadOnly = $true
$form.Controls.Add($textboxPassword)

# Buttons
$passGenButton = New-Object System.Windows.Forms.Button
$passGenButton.Text = "Generate Password"
$passGenButton.Location = New-Object System.Drawing.Point(10, 160)
$passGenButton.Size = New-Object System.Drawing.Size(150, 30)
$form.Controls.Add($passGenButton)

$passChangeButton = New-Object System.Windows.Forms.Button
$passChangeButton.Text = "Change Password"
$passChangeButton.Location = New-Object System.Drawing.Point(180, 160)
$passChangeButton.Size = New-Object System.Drawing.Size(150, 30)
$form.Controls.Add($passChangeButton)

# HowTo Label
$labelHowTo = New-Object System.Windows.Forms.Label
$labelHowTo.Text = "Input a username and password in the fields. Hit Generate, then change password."
$labelHowTo.Location = New-Object System.Drawing.Point(10, 200)
$labelHowTo.Size = New-Object System.Drawing.Size(300, 80)
$form.Controls.Add($labelHowTo)

# Misc Label
$labelMisc = New-Object System.Windows.Forms.Label
$labelMisc.Text = "https://github.com/Aygran/PowerShell-Infrastructure"
$labelMisc.Location = New-Object System.Drawing.Point(10, 300)
$labelMisc.Size = New-Object System.Drawing.Size(300, 100)
$form.Controls.Add($labelMisc)

#endRegion .NET Forms

#region Powershell Script
$passGenButton.Add_Click({
    $uppercase = "ABCDEFGHJKLMNPQRSTUVWXYZ".ToCharArray()
    $lowercase = "abcdefghjkmnpqrstuvwxyz".ToCharArray()
    $numbers = "23456789".ToCharArray()
    $specialCharacters = "!@#$%^&*()_+".ToCharArray()

    $all = $upperCase + $lowerCase + $numbers + $specialCharacters

    $passwordLength = [int]$textboxLength.Value
    $passwordChars = @()

    $passwordChars += ($uppercase | Get-Random -Count 1)
    $passwordChars += ($lowercase | Get-Random -Count 1)
    $passwordChars += ($numbers | Get-Random -Count 1)
    $passwordChars += ($specialCharacters | Get-Random -Count 1)

    $remainingLength = $passwordLength - $passwordChars.Count
    if ($remainingLength -gt 0){
        $passwordChars += ($all | Get-Random -Count $remainingLength)
    }

    $passwordChars = $passwordChars | Sort-Object {Get-Random}

    $password = -join $passwordChars

    $textboxPassword.Text = $password
})

$passChangeButton.Add_Click({
    $svcacc = $textboxSVC.Text
    $svcpw = $textboxPassword.Text
    $svcold = $textboxOldPW.Text
    Set-ADAccountPassword -Identity $svcacc -OldPassword (ConvertTo-SecureString -AsPlainText $svcold -Force) -NewPassword (ConvertTo-SecureString -AsPlainText $svcpw -Force)
    
})

#endRegion Powershell Script

[void]$form.ShowDialog()