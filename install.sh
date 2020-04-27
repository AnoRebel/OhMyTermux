#!/data/data/com.termux/files/usr/bin/bash

# Use colors, but only if connected to a terminal, and that terminal
# supports them.
if which tput >/dev/null 2>&1; then
    ncolors=$(tput colors)
fi
if [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then
    RED="$(tput setaf 1)"
    GREEN="$(tput setaf 2)"
    YELLOW="$(tput setaf 3)"
    BLUE="$(tput setaf 4)"
    BOLD="$(tput bold)"
    NORMAL="$(tput sgr0)"
else
    RED=""
    GREEN=""
    YELLOW=""
    BLUE=""
    BOLD=""
    NORMAL=""
fi

apt update
apt install ruby -y
gem install lolcat
apt install -y git zsh figlet | lolcat

cd $HOME

clear

git clone https://github.com/anorebel/OhMyTermux.git $HOME/OhMyTermux --depth 1 | lolcat

if [ -d "$HOME/.termux" ]; then
 mv $HOME/.termux $HOME/.termux.bak
fi

cp -R $HOME/OhMyTermux/.termux $HOME/.termux

git clone git://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh --depth 1 | lolcat

printf "${BLUE}Looking for an existing zsh config...${NORMAL}\n"
if [ -f ~/.zshrc ] || [ -h ~/.zshrc ]; then
    printf "${YELLOW}Found ~/.zshrc.${NORMAL} ${GREEN}Backing up to ~/.zshrc.pre-oh-my-zsh${NORMAL}\n";
    mv ~/.zshrc ~/.zshrc.pre-oh-my-zsh;
fi

printf "${BLUE}Using the Oh My Zsh template file and adding it to ~/.zshrc${NORMAL}\n"
cp $HOME/.oh-my-zsh/templates/zshrc.zsh-template $HOME/.zshrc
sed -i '/^ZSH_THEME/d' $HOME/.zshrc
printf "${BLUE}Adding the agnoster theme which you can change later to anything in the ~/.zshrc${NORMAL}\n"
sed -i '1iZSH_THEME="agnoster"' $HOME/.zshrc
printf "${BLUE}Making zsh your default shell using 'chsh'${NORMAL}\n"
chsh -s zsh

termux-setup-storage

figlet -f script -c "Done! " | lolcat

echo "Choose your color scheme now: " | lolcat
$HOME/.termux/colors.sh

echo "Choose your font now: " | lolcat
$HOME/.termux/fonts.sh

printf "${GREEN}"
  echo '         __                         ________                                    '
  echo '  ____  / /_     ____ ___  __  __  /__   __/____  _ ____ ____ ___   __  __      '
  echo ' / __ \/ __ \   / __ `__ \/ / / /     / /  /___ /| |___// __ `__ \ / / / / \\// '
  echo '/ /_/ / / / /  / / / / / / /_/ /     / /  /  __/ / /   / / / / / // /_/ /   \   '
  echo '\____/_/ /_/  /_/ /_/ /_/\__, /     /_/  /___/  / /   /_/ /_/ /_//_____/  //\\  '
  echo '                        /____/                                                  ....is now installed!'
  echo ''
  echo ''
  echo 'Please look over the ~/.zshrc file to select plugins, themes, and options.'
  echo ''
  echo 'Please restart Termux app...'
  echo ''
printf "${NORMAL}"

exit

