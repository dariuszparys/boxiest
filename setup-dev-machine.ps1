# Author: Dariusz Parys
# Common dev settings for Windows Server 2019 with Containers base image

# Common Variables
$boxiest_path = "${env:TEMP}\boxiest"

# Helper Functions
function invokeScript {
    param (
        $script
    )

    powershell -c "${boxiest_path}\scripts\$script"
}

# Install Chocolatey
Set-ExecutionPolicy Bypass -Scope CurrentUser -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
choco feature enable --name allowGlobalConfirmation
RefreshEnv

# Install git so we can clone the repository
choco install git --params="/GitAndUnixToolsOnPath /WindowsTerminal"
git clone https://github.com/dariuszparys/boxiest.git ${boxiest_path}
Set-Location "${boxiest_path}"

#--- Setting up Windows ---
invokeScript "browsers.ps1";
invokeScript "common-devtools.ps1";
invokeScript "wsl.ps1";

write-host "Installing WSL distro..."
invokeScript "debian.ps1";
Debian run apt install python3 python3-pip -y 
write-host "Finished installing WSL distro"

Set-Location "${HOME}"
Remove-Item -Path "${boxiest_path}" -Recurse -Force

write-host "Done"