Set-ExecutionPolicy Bypass -Scope CurrentUser -Force; . { iwr -useb https://boxstarter.org/bootstrapper.ps1 } | iex; Get-Boxstarter -Force

Install-BoxstarterPackage -PackageName https://raw.githubusercontent.com/dariuszparys/boxiest/main/03-box-install-software.ps1
