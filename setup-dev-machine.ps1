# Description: Boxstarter Script
# Author: Dariusz Parys
# Common dev settings for Windows Server 2019 with Containers base image

Disable-UAC

# Get the base URI path from the ScriptToCall value
$bstrappackage = "-bootstrapPackage"
$helperUri = $Boxstarter['ScriptToCall']
$strpos = $helperUri.IndexOf($bstrappackage)
$helperUri = $helperUri.Substring($strpos + $bstrappackage.Length)
$helperUri = $helperUri.TrimStart("'", " ")
$helperUri = $helperUri.TrimEnd("'", " ")
$helperUri = $helperUri.Substring(0, $helperUri.LastIndexOf("/"))
$helperUri += "/scripts"
write-host "helper script base URI is $helperUri"

function executeScript {
    Param ([string]$script)
    write-host "executing $helperUri/$script ..."
	iex ((new-object net.webclient).DownloadString("$helperUri/$script"))
}

#--- Setting up Windows ---
executeScript "fileexplorersettings.ps1";
executeScript "browsers.ps1";
executeScript "common-devtools.ps1";
executeScript "visualstudio-2019.ps1";
executeScript "wsl.ps1";

write-host "Installing tools inside the WSL distro..."
# Debian run apt install python2.7 python-pip -y 
# Debian run apt install python-numpy python-scipy -y
# Debian run pip install pandas

write-host "Finished installing tools inside the WSL distro"

Enable-UAC
Enable-MicrosoftUpdate
Install-WindowsUpdate -acceptEula