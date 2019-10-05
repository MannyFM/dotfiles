#!/usr/bin/env bash

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished
# while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Install Xcode command line tools
if xcode-select --install 2> /dev/null; then
  read -p '? Press [Enter] key when Xcode command line tools are installed...' -r
fi

# Check for Homebrew and install it if missing
if test ! $(which brew)
then
	echo "Installing Homebrew..."
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew install git

echo "Cloning make dotfiles repo"
if [ ! -d ~/.dotfiles ]; then
	git clone --recursive https://github.com/mannyfm/dotfiles ~/.dotfiles
fi
cd ~/.dotfiles
git pull || exit 1

echo "Installing brew, cask, mas programms"
brew bundle || exit 1

# Remove outdated versions from the cellar
brew cleanup

# Make zsh default shell
# which zsh | sudo tee -a /etc/shells
# chsh -s "$(which zsh)"
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
git clone https://github.com/supercrabtree/k ~/.oh-my-zsh/custom/plugins/k

echo "Linkning dotfiles"
# Synchronize symlinks
rcup -v -d ~/.dotfiles/symlinks -S vim

echo "Copying fonts"
# Copy fonts
rsync -av --no-perms ~/.dotfiles/resources/fonts/ ~/Library/Fonts

echo "Done."
