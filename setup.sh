#!/usr/bin/env bash

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

sudo add-apt-repository -y ppa:martin-frost/thoughtbot-rcm
sudo apt-get update
sudo apt-get install git

echo "Cloning make dotfiles repo"
if [ ! -d ~/.dotfiles ]; then
	git clone --recursive https://github.com/mannyfm/dotfiles ~/.dotfiles
fi
cd ~/.dotfiles
# git pull || exit 1
# git checkout jetson

sudo apt install -y rcm vim zsh tmux aria2 wget

# Remove outdated versions from the cellar
sudo apt-get autoremove -y

# Make zsh default shell
which zsh | sudo tee -a /etc/shells
chsh -s "$(which zsh)"

# oh-my-zsh
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

echo "Linkning dotfiles"
# Synchronize symlinks
rcup -v -d ~/.dotfiles/symlinks -S vim

echo "Done."
