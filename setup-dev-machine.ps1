# Author: Dariusz Parys
# Common dev settings for Windows Server 2019 with Containers base image

# Common Variables
$boxiest_path = "c:\boxiest"

# Helper Functions
function invokeScript {
    param (
        $script
    )

    powershell -c "${boxiest_path}\scripts\$script"
}

Set-Location "${env:USERPROFILE}"
If ( ! ( Test-Path "${PROFILE}" ) ) { 
    New-Item -Force -ItemType File -Path "${PROFILE}"
    Add-Content -Path "${PROFILE}" -Encoding UTF8 -Value "# Powershell Profile"; 
}

Set-ExecutionPolicy Bypass -Scope CurrentUser -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
choco feature enable --name allowGlobalConfirmation

refreshenv

choco install git --params="/GitOnlyOnPath /WindowsTerminal /NoShellHereIntegration /SChannel"
git clone https://github.com/dariuszparys/boxiest.git ${boxiest_path}
Set-Location "${boxiest_path}"

invokeScript "browsers.ps1"
invokeScript "common-devtools.ps1"
invokeScript "wsl-feature.ps1"

write-host "Please reboot..."
