#!/usr/bin/env bash

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished
# while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

echo "Cloning make dotfiles repo"
if [ ! -d ~/.dotfiles ]; then
	git clone --recursive https://github.com/mannyfm/dotfiles ~/.dotfiles
fi
cd ~/.dotfiles
# git pull || exit 1

source packages.sh


echo "Linkning dotfiles"
# Synchronize symlinks
rcup -v -d ~/.dotfiles/symlinks -S vim

echo "Done."
