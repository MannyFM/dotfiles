preinstall_darwin() {
    # Install Xcode command line tools
    if xcode-select --install 2> /dev/null; then
        read -p '? Press [Enter] key when Xcode command line tools are installed...' -r
    fi

    # Check for Homebrew and install it if missing
    if test !$(which brew)
    then
        echo "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    fi

    brew install git
}
preinstall_linux_gnu() {
    sudo apt update
    sudo apt install git
}

if [[ "$OSTYPE" == "linux-gnu" ]]; then
    preinstall_linux_gnu
elif [[ "$OSTYPE" == "darwin" ]]; then
    preinstall_darwin
fi

git clone https://github.com/m-nny/dotfiles.git $HOME/.dotfiles

cd .dotfiles;
source install.sh
