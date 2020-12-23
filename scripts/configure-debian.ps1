# setting explicit path as refreshing env doesn't work

$debian_path = "${HOME}\Debian"
powershell -c ${debian_path}\debian install --root
powershell -c ${debian_path}\debian run apt update
powershell -c ${debian_path}\debian run apt upgrade -y