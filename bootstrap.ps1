$boxiest_path = "${env:TEMP}\boxiest"

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

function Main() {
    SetupChocolatey
    EnableWsl2
    CloneRepository
    InstallSoftwarePackages
    CleanupRepository
}

Main



