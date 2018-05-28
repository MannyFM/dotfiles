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

# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew tap homebrew/versions
brew upgrade

apps=(
	coreutils
	dockutil
	git
	heroku
	imagemagick
	mas
	python@2
	python3
	ruby
	thefuck
	tmux
	vim
	wget
	zsh
)
brew install "${apps[@]}"

# Make zsh default shell
which zsh | sudo tee -a /etc/shells
chsh -s "$(which zsh)"

# Install rcm
brew install thoughtbot/formulae/rcm

# Install Caskroom
brew tap homebrew/cask

apps=(
	atom
	avast-secureline-vpn
	flux
	gitkraken
	java
	vlc
	xld
)
brew cask install "${apps[@]}"

apps=(
	747648890		# Telegram
	1039633667	# Irvue
)
mas install "${storeapps[@]}"

# Remove outdated versions from the cellar
brew cleanup

# Set Dock items
OLDIFS=$IFS
IFS=''

apps=(
	'Safari'
	'iTunes'
	'Telegram'
	'Utilites/Terminal'
	'GitKraken'
	'Calculator'
)

dockutil --no-restart --remove all $HOME
for app in "${apps[@]}"
do
	echo "Keeping $app in Dock"
	dockutil --no-restart --add /Applications/$app.app $HOME
done
killall Dock

# restore $IFS
IFS=$OLDIFS

git clone --recursive https://github.com/mannyfm/dotfiles ~/.dotfiles

# Synchronize symlinks
rcup -v -d ~/.dotfiles/symlinks -S vim

# Copy fonts
rsync -av --no-perms ~/.dotfiles/resources/fonts/ ~/Library/Fonts

# Copy templates
mkdir -p ~/work/template
rsync -av --no-perms ~/.dotfiles/resources/template ~/work/template

