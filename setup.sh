#!/usr/bin/env bash

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

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
git clone --recursive https://github.com/mannyfm/dotfiles ~/.dotfiles
cd ~/.dotfiles

echo "Installing brew, cask, mas programms"
brew bundle

# Remove outdated versions from the cellar
brew cleanup

# Make zsh default shell
which zsh | sudo tee -a /etc/shells
chsh -s "$(which zsh)"

# Set Dock items
OLDIFS=$IFS
IFS=''

apps=(
	'Safari'
	'iTunes'
	'Telegram'
	'Utilities/Terminal'
	'GitKraken'
	'Calculator'
)

echo "Changing dock"
dockutil --no-restart --remove all $HOME

for app in "${apps[@]}"
do
	echo "Keeping $app in Dock"
	dockutil --no-restart --add /Applications/$app.app $HOME
done

dockutil --no-restart --add "~/Documents" --display folder $HOME
dockutil --no-restart --add "~/Downloads" --display stack $HOME

killall Dock

# restore $IFS
IFS=$OLDIFS

echo "Linkning dotfiles"
# Synchronize symlinks
rcup -v -d ~/.dotfiles/symlinks -S vim

echo "Copying fonts"
# Copy fonts
rsync -av --no-perms ~/.dotfiles/resources/fonts/ ~/Library/Fonts

echo "Copying templates"
# Copy templates
mkdir -p ~/work/template
rsync -av --no-perms ~/.dotfiles/resources/template ~/work/template

echo "Done."
