# Author: Dariusz Parys
# Common dev settings for Windows Server 2019 with Containers base image

installScript(
    Param ([string] $script) {
    Install-BoxstarterPackage -PackageName "scripts\$script"
}

# Common Variables
$boxiest_path = "${env:TEMP}\boxiest"

# Install Chocolatey
Set-ExecutionPolicy Bypass -Scope CurrentUser -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
choco feature enable --name allowGlobalConfirmation
RefreshEnv

# Install Boxstarter
. { iwr -useb https://boxstarter.org/bootstrapper.ps1 } | iex; Get-Boxstarter -Force

# Install git so we can clone the repository
choco install git --params="/GitAndUnixToolsOnPath /WindowsTerminal"
git clone https://github.com/dariuszparys/boxiest.git ${boxiest_path}
Set-Location "${boxiest_path}"

#--- Setting up Windows ---
installScript "browsers.ps1";
installScript "common-devtools.ps1";
installScript "wsl.ps1";

write-host "Installing WSL distro..."
Set-Location "${HOME}"
installScript "debian.ps1";

Debian run apt install python3 python3-pip -y 

write-host "Finished installing WSL distro"