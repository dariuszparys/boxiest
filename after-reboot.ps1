$boxiest_path = "c:\boxiest"

function invokeScript {
    param (
        $script
    )

    powershell -c "${boxiest_path}\scripts\$script"
}

write-host "Installing WSL distro..."
invokeScript "install-debian.ps1"
invokeScript "configure-debian.ps1"
write-host "Finished installing WSL distro"

write-host "Configuring Linux Containers On Windows"
invokeScript "lcow.ps1"
write-host "Finished LCOW configuration"

Set-Location "${HOME}"
Remove-Item -Path "${boxiest_path}" -Recurse -Force

write-host "Done"