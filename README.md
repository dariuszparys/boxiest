# Boxiest - Setup Cloud based Windows Dev Machine

**Work in Progress**

Setup scripts for configuring Windows Server 2019 with Containers to be used as development machine. It will provide the following installations

1. Enable WSL2 and download latest Debian
2. Install software packages defined in `packaged.config`

## Start Setup

Simply execute this on the target machine in Powershell

```powershell
Set-ExecutionPolicy Bypass -Scope CurrentUser -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/dariuszparys/boxiest/main/bootstrap.ps1'))
```

## Boxstarter

I'm currently inspecting the use of [Boxstarter](https://boxstarter.org/)