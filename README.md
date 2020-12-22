# Boxiest - Setup Cloud based Windows Dev Machine

Simple script to setup Common DevTools, WSL2 and Docker for Linux on Windows Server 2019 with Containers

## Execute Installation Script

```powershell
Set-ExecutionPolicy Bypass -Scope CurrentUser -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/dariuszparys/boxiest/main/setup-dev-machine.ps1'))
```

At the end you have to reboot your machine. I haven't provided any autologon and autostart scripts. Therefore you've to navigate to `c:\boxiest\` and execute `after-reboot.ps`

## Additional Manual Steps

After installation completes, don't forget to add a user to the WSL distribution, for this script it is Debian.

```powershell
.\Debian run "useradd -m -s /bin/bash -p ${env:WSL_PASSWORD} ${env:WSL_USER}"
.\Debian config --default-user ${env:WSL_USER}
wslconfig /setdefault Debian
```