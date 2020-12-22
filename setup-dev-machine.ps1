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

function executeCommand {
    param (
        $command
    )

    powershell -c "${command}"
}

# Install Chocolatey
Set-ExecutionPolicy Bypass -Scope CurrentUser -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
choco feature enable --name allowGlobalConfirmation
RefreshEnv

# Install git so we can clone the repository
executeCommand "choco install git --params=""/GitAndUnixToolsOnPath /WindowsTerminal""; refreshenv"
executeCommand "git clone https://github.com/dariuszparys/boxiest.git ${boxiest_path}"

Set-Location "${boxiest_path}"

#--- Setting up Windows ---
invokeScript "browsers.ps1";
invokeScript "common-devtools.ps1";
invokeScript "wsl-feature.ps1";

write-host "Please reboot..."
