# setting explicit path as refreshing env doesn't work

$debian_path = "${HOME}\Debian"
${debian_path}\debian install --root
${debian_path}\debian run apt update
${debian_path}\debian run apt upgrade -y