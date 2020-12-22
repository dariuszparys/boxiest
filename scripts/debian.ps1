Invoke-WebRequest -Uri https://aka.ms/wsl-debian-gnulinux -OutFile ~/Debian.appx -UseBasicParsing

Rename-Item .\Debian.appx .\Debian.zip
Expand-Archive .\Debian.zip "${HOME}\Debian"
$userenv = [System.Environment]::GetEnvironmentVariable("Path", "User")
[System.Environment]::SetEnvironmentVariable("PATH", $userenv + ";${HOME}\Debian", "User")

RefreshEnv
Debian install --root
Debian run apt update
Debian run apt upgrade -y