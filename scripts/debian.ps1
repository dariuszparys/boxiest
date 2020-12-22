Invoke-WebRequest -Uri https://aka.ms/wsl-debian-gnulinux -OutFile "${HOME}\Debian.appx" -UseBasicParsing

Rename-Item "${HOME}\Debian.appx" "${HOME}\Debian.zip"
Expand-Archive "${HOME}\Debian.zip" "${HOME}\Debian"
$userenv = [System.Environment]::GetEnvironmentVariable("Path", "User")
[System.Environment]::SetEnvironmentVariable("PATH", $userenv + ";${HOME}\Debian", "User")

RefreshEnv

Debian install --root
Debian run apt update
Debian run apt upgrade -y