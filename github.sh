#!/bin/sh

# Source library
source <(curl -sSL https://is.gd/nhattruongNeoVim_lib)

# Start script
printf "${NOTE} Start script\n\n"

# Configuring SSH directory
SSH_DIR="$HOME/.ssh"
if [ ! -d "$SSH_DIR" ]; then
    mkdir -p "$SSH_DIR"
fi

# Configure GitHub
echo "[user]
    email = nhattruong13112000@gmail.com
    name = nhattruongNeoVim" > "$HOME/.gitconfig" && { echo "${OK} Configured GitHub successfully!"; } || {
    echo "${ERROR} Failed to configure GitHub"
}

# Copying SSH private key
echo "-----BEGIN OPENSSH PRIVATE KEY-----
b3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAAAMwAAAAtzc2gtZW
QyNTUxOQAAACAsW8zCDCisktIgmYVrd6deNvELy5aNlSNfh6lSXaLEogAAAKAa4ZGIGuGR
iAAAAAtzc2gtZWQyNTUxOQAAACAsW8zCDCisktIgmYVrd6deNvELy5aNlSNfh6lSXaLEog
AAAEDKnDF1Sg1sakkJ9v7v9tgjeqABQx+45EMjvLiEHZfCCyxbzMIMKKyS0iCZhWt3p142
8QvLlo2VI1+HqVJdosSiAAAAHG5oYXR0cnVvbmcxMzExMjAwMEBnbWFpbC5jb20B
-----END OPENSSH PRIVATE KEY-----
" > "$SSH_DIR"/id_ed25519 && { echo "${OK} Created private key successfully!"; } || {
    echo "${ERROR} Failed to create private key"
}

# Copying SSH public key
echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICxbzMIMKKyS0iCZhWt3p1428QvLlo2VI1+HqVJdosSi nhattruong13112000@gmail.com" > "$SSH_DIR"/id_ed25519.pub && { echo "${OK} Created public key successfully!"; } || {
    echo "${ERROR} Failed to create public key"
}

# Changing permissions
chmod 600 "$SSH_DIR/id_ed25519" && { echo "${OK} Changed permissions successfully!"; } || {
    echo "${ERROR} Failed to change permissions"
}

# Disable StrictHostKeyChecking
echo "StrictHostKeyChecking=no" > "$SSH_DIR"/config && { echo "${OK} Disabled StrictHostKeyChecking!"; } || {
    echo "${ERROR} Failed to disable StrictHostKeyChecking"
}
