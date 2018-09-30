#!/bin/sh

ZSH="$(which zsh)"

if [ $ZSH = "/usr/bin/zsh" ]; then
    echo "zsh already installed!"
else
    # download and install zsh, src: https://ohmyz.sh/
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

    # download and install powerlevel9k
    GIT=`which git`
    DIR=~/.oh-my-zsh/custom/themes/powerlevel9k
    ${GIT} clone https://github.com/bhilburn/powerlevel9k.git ${DIR}

    # set zsh theme to powerlevel9k
    sed -i '/ZSH_THEME/c\ZSH_THEME="powerlevel9k/powerlevel9k"' /home/mfathirirhas/.zshrc
fi