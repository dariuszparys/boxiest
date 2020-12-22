Invoke-WebRequest -Uri https://aka.ms/wsl-debian-gnulinux -OutFile ~/Debian.appx -UseBasicParsing
Add-AppxPackage -Path ~/Debian.appx

RefreshEnv
Debian install --root
Debian run apt update
Debian run apt upgrade -y