#!/usr/bin/env bash

# oh-my-zsh
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
# k
git clone https://github.com/supercrabtree/k ~/.oh-my-zsh/custom/plugins/k
# spaceship
git clone https://github.com/denysdovhan/spaceship-prompt.git "$HOME/.oh-my-zsh/custom/themes/spaceship-prompt"
ln -s "$HOME/.oh-my-zsh/custom/themes/spaceship-prompt/spaceship.zsh-theme" "$HOME/.oh-my-zsh/custom/themes/spaceship.zsh-theme"
# nvm
git clone https://github.com/lukechilds/zsh-nvm ~/.oh-my-zsh/custom/plugins/zsh-nvm

# Copy fonts
if [ -f ~/Library/Fonts ]; then
    echo "Copying fonts";
    rsync -av --no-perms ~/.dotfiles/resources/fonts/ ~/Library/Fonts;
fi

echo "Done."
