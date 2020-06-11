sudo add-apt-repository -y ppa:martin-frost/thoughtbot-rcm
sudo apt update

sudo apt install -y aria2 httpie tmux
sudo apt install -y vim wget curl
sudo apt install -y zsh rcm


sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
git clone https://github.com/supercrabtree/k ~/.oh-my-zsh/custom/plugins/k
git clone https://github.com/lukechilds/zsh-nvm ~/.oh-my-zsh/custom/plugins/zsh-nvm