
PACKAGES="aria2 git httpie jq tmux vim wget zsh"

printf "Installing following packages: %s\n" "$PACKAGES"

pamac install $PACKAGES

pamac build rcm
