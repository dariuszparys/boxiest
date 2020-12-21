$boxiest_path = "${env:TEMP}\boxiest"
$debian_path = "${HOME}\Debian"
$debian_root = $FALSE

function SetupChocolatey() {
    Set-Location ${env:USERPROFILE}
    If ( ! ( Test-Path $PROFILE ) ) { 
        New-Item -Force -ItemType File -Path $PROFILE; Add-Content -Path $PROFILE -Encoding UTF8 -Value "# Powershell Profile"; 
    }
    Set-ExecutionPolicy Bypass -Scope CurrentUser -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

    choco feature enable --name allowGlobalConfirmation

    refreshenv
}

function EnableWsl2() {
    choco install Microsoft-Windows-Subsystem-Linux --source windowsfeatures
}

function InstallDebian() {
    Set-Location "${env:TEMP}"
    Invoke-WebRequest -Uri https://aka.ms/wsl-debian-gnulinux -OutFile Debian.appx -UseBasicParsing

    Rename-Item .\Debian.appx .\Debian.zip
    Expand-Archive .\Debian.zip "${debian_path}"
    $userenv = [System.Environment]::GetEnvironmentVariable("Path", "User")
    [System.Environment]::SetEnvironmentVariable("PATH", $userenv + ";${debian_path}", "User")
}

function ConfigureDebian() {
    if (!(Test-Path ${debian_path})) {
        Write-Error "Debian distribution not installed"
        exit 1
    }

    Set-Location "${debian_path}"
    .\Debian install --root
    wsl -d Debian -e "apt update"
    wsl -d Debian -e "apt upgrade -y"
    if(!${debian_root}) {
        .\Debian run "useradd -m -s /bin/bash -p ${env:WSL_PASSWORD} ${env:WSL_USER}"
        .\Debian config --default-user ${env:WSL_USER}
    }
    wslconfig /setdefault Debian
}

function CloneRepository() {
    choco install git --params="/GitOnlyOnPath /WindowsTerminal /NoShellHereIntegration /SChannel"
    git clone https://github.com/dariuszparys/boxiest.git ${boxiest_path}
}

function InstallSoftwarePackages() {
    if (!(Test-Path ${boxiest_path})) {
        Write-Error "Repository not available"
        exit 1
    }
    Set-Location "${boxiest_path}"
    choco install packages.config
}

function CleanupRepository() {
    Set-Location "${HOME}"
    if(Test-Path ${boxiest_path}) {
        Remove-Item -Path "${boxiest_path}" -Recurse -Force
    }
}

function EnsureVariables() {
    if(!(Test-Path ${env:WSL_USER}) -Or !(Test-Path ${env:WSL_PASSWORD})) {
        Write-Error "WSL_USER and WSL_PASSWORD environment variables not set using root for Debian"
        ${debian_root} = $TRUE
    }
}

function Main() {
    EnsureVariables
    SetupChocolatey
    EnableWsl2
    InstallDebian
    ConfigureDebian
    CloneRepository
    InstallSoftwarePackages
    CleanupRepository
}

Main



