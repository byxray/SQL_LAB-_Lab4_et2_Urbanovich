<#
.SYNOPSIS
    .
.DESCRIPTION
    RUN THIS SCRIPT ON PC WHERE YOU WANT TO CREATE NEW USERS
.PARAMETER Path
    The path to the .csv file
.PARAMETER LiteralPath
    .
.EXAMPLE
    C:\PS> .\lab4_et2.ps1 -path "C:\usrlist.csv"
.NOTES
    Author: Urbanovich Sergei
    Date:   Nov 21, 2018    
#>

[CmdletBinding()] 

Param ( 

[parameter(Mandatory=$false,HelpMessage="Path for .csv file with users' parameters. Def. - C:\Userlist.csv")] 
[string]$path = "C:\Userlist.csv"

)

$chkPath = Get-Item -Path $path
If ($chkPath) {

    Write-Host "Path" $path "is avalible" -BackgroundColor DarkYellow

} else {

    Write-Host "Path" $path "isn't avalible" -ForegroundColor White -BackgroundColor DarkRed
    Exit

}


$Users = Import-Csv -Delimiter "," -Path "C:\Userlist.csv"            
foreach ($User in $Users)            
{
    try {         
	    NET USER $User.Username $User.Password /ADD /comment:"$($User.Function)"
        #NET LOCALGROUP "group" $_.username  /ADD
        Write-Host "User" $User.Username "was created" -ForegroundColor White -BackgroundColor Green
    } catch [system.exception] {
        Write-Host "User" $User.Username "WASN'T created" -ForegroundColor White -BackgroundColor Red
    }
}