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

# From https://stackoverflow.com/questions/46758437/how-to-refresh-the-environment-of-a-powershell-session-after-a-chocolatey-instal

# Make `refreshenv` available right away, by defining the $env:ChocolateyInstall
# variable and importing the Chocolatey profile module.
# Note: Using `. $PROFILE` instead *may* work, but isn't guaranteed to.
$env:ChocolateyInstall = Convert-Path "$((Get-Command choco).Path)\..\.."   
Import-Module "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"

# refreshenv is now an alias for Update-SessionEnvironment
# (rather than invoking refreshenv.cmd, the *batch file* for use with cmd.exe)
# This should make git.exe accessible via the refreshed $env:PATH, so that it
# can be called by name only.
refreshenv

# Install git so we can clone the repository
executeCommand "choco install git --params=""'/GitAndUnixToolsOnPath /WindowsTerminal'"""
refreshenv
executeCommand "git clone https://github.com/dariuszparys/boxiest.git ${boxiest_path}"

Set-Location "${boxiest_path}"

#--- Setting up Windows ---
invokeScript "browsers.ps1";
invokeScript "common-devtools.ps1";
invokeScript "wsl-feature.ps1";

write-host "Please reboot..."
