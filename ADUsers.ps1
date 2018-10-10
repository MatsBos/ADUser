#otherwise AD doesn't work in PowerShell
Import-Module ActiveDirectory

$givenName = Read-Host "First name "
$lastName = Read-Host "Last name "
$password = Read-Host "give password " -AsSecureString

#makes the full name (so you don't have to input it)
$Name = $givenName +(" ")+ $lastName

#makes login name
$loginName = $givenName[0] + $lastName


#verify if you wan't to commit or not
$title = 'Create User?'
$prompt = 'Have you validated your input and are you sure you want to create the user?'
$no = New-Object System.Management.Automation.Host.ChoiceDescription '&No','No, Script ends.'
$yes = New-Object System.Management.Automation.Host.ChoiceDescription '&Yes','Yes, The user is created with the entered values.'
$options = [System.Management.Automation.Host.ChoiceDescription[]] ($no,$yes)
 
$choice = $host.ui.PromptForChoice($title,$prompt,$options,0)

switch ($choice)
{
    0 { Write-Host("cancelled")}
    1 { New-ADUser -Name $Name -GivenName $givenName -Surname $lastName -SamAccountName $loginName -AccountPassword $password -PassThru | Enable-ADAccount
    Get-ADUser -Filter {name -like $givenName}
    Write-Host("successfully created user")
    }
    default { break; }
}