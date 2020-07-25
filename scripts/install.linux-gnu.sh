
PACKAGES="aria2 git httpie jq rcm tmux vim wget zsh"

printf "Installing following packages: %s\n" "$PACKAGES"

sudo apt update
sudo apt install $PACKAGES -y 

sudo apt install python3-dev python3-pip python3-setuptools
sudo pip3 install thefuck