# Boxiest - Setup Cloud based Windows Dev Machine

Now based completely on Boxstarter and leveraging click once installer

## Click Once Installer

[Setup Dev Machine](http://boxstarter.org/package/url?https://raw.githubusercontent.com/dariuszparys/boxiest/main/setup-dev-machine.ps1)

## Boxstarter

I'm currently inspecting the use of [Boxstarter](https://boxstarter.org/)

```powershell
Set-ExecutionPolicy Bypass -Scope CurrentUser -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/dariuszparys/boxiest/main/boxstarter-bootstrap.ps1'))
```

## Manual Steps

After installation completes, don't forget to add a user to the WSL distribution, for this scripts it is Debian.

```powershell
.\Debian run "useradd -m -s /bin/bash -p ${env:WSL_PASSWORD} ${env:WSL_USER}"
.\Debian config --default-user ${env:WSL_USER}
wslconfig /setdefault Debian
```