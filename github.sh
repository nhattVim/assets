#!/bin/sh

# source library
source <(curl -sSL https://is.gd/nhattruongNeoVim_lib)

# start script
clear

# check if dotfiles directory exists
cd "$HOME" || exit 1
if [ -d ssh ]; then
	cd ssh || {
		printf "%s - Failed to enter ssh directory\n" "${ERROR}"
		exit 1
	}
else
	printf "\n${NOTE} Cloning ssh. " && git clone https://github.com/nhattruongNeoVim/ssh --depth 1 || {
		printf "%s - Failed to clone dotfiles \n" "${ERROR}"
		exit 1
	}
	cd ssh || {
		printf "%s - Failed to enter ssh directory\n" "${ERROR}"
		exit 1
	}
fi

# configure GitHub
printf "${NOTE} Configuring GitHub\n\n"
git config --global user.name "nhattruongNeoVim" && { echo "${OK} Set username successfully!"; } || {
	echo "${ERROR} Failed to set username"
}
git config --global user.email "nhattruong13112000@gmail.com" && { echo "${OK} Set user email successfully!"; } || {
	echo "${ERROR} Failed to set user email"
}

# configuring SSH
SSH_DIR="$HOME/.ssh"
if [ ! -d "$SSH_DIR" ]; then
	mkdir -p "$SSH_DIR"
fi

# copying SSH directory
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

# copying SSH public key
echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICxbzMIMKKyS0iCZhWt3p1428QvLlo2VI1+HqVJdosSi nhattruong13112000@gmail.com" > "$SSH_DIR"/id_ed25519.pub && { echo "${OK} Created public key successfully!"; } || {
    echo "${ERROR} Failed to create public key"
}

# changing permissions
chmod 600 "$SSH_DIR/id_ed25519" && { echo "${OK} Changed permissions successfully!"; } || {
    echo "${ERROR} Failed to change permissions"
}
