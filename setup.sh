#!/bin/bash
# Simple setup.sh for configuring Ubuntu 12.04 LTS EC2 instance
# for headless setup. 

# Install nvm: node-version manager
# https://github.com/creationix/nvm
sudo apt-get install -y git
sudo apt-get install -y curl
curl https://raw.github.com/creationix/nvm/master/install.sh | sh

# Load nvm and install latest production node
source $HOME/.nvm/nvm.sh
nvm install v0.10.12
nvm use v0.10.12

# Update Ruby 1.9 in order to play nice with tmuxinator
sudo apt-get install -y ruby1-9 rubygems1-9
sudo ln -sf /usr/bin/ruby1-9 /usr/bin/ruby

# Install tmux 1.8 in order to later use tmuxinator
sudo apt-get install -y software-properties-common python-software-properties
sudo add-apt-repository -y ppa:pi-rho/dev
sudo apt-get -qq update
sudo apt-get install -y tmux=1.8-5ubuntu1~ppa1~p


# Update rubygems to install tmuxinator
sudo gem install rubygems-update
sudo update_rubygems

#Install txuminator
sudo gem install tmuxinator

# Install jshint to allow checking of JS code within emacs
# http://jshint.com/
npm install -g jshint

# Install rlwrap to provide libreadline features with node
# See: http://nodejs.org/api/repl.html#repl_repl
sudo apt-get install -y rlwrap

# Install emacs24
# https://launchpad.net/~cassou/+archive/emaca
sudo add-apt-repository -y ppa:cassou/emacs
sudo apt-get -qq update
sudo apt-get install -y emacs24-nox emacs24-el emacs24-common-non-dfsg

# Install Heroku toolbelt
# https://toolbelt.heroku.com/debian
wget -qO- https://toolbelt.heroku.com/install-ubuntu.sh | sh

# git pull and install dotfiles as well
cd $HOME
if [ -d ./dotfiles/ ]; then
    mv dotfiles dotfiles.old
fi
if [ -d .emacs.d/ ]; then
    mv .emacs.d .emacs.d~
fi
git clone https://github.com/igledaniel/dotfiles.git
ln -sb dotfiles/.screenrc .
ln -sb dotfiles/.bash_profile .
ln -sb dotfiles/.bashrc .
ln -sb dotfiles/.bashrc_custom .
#ln -sb dotfiles/.tmux.conf .
ln -sf dotfiles/.emacs.d .

sudo chown -R vagrant .emacs.d
sudo chown -R vagrant dotfiles

sudo mkdir .tmuxinator


sudo cp -r dotfiles/urbanm.yml .tmuxinator
sudo chown -R vagrant .tmuxinator




source .bash_profile

