##########################################################
### scripts to backup things from system into dotfiles ###
##########################################################

# make sure run as sudo
if [ "$EUID" -ne 0 ]
then
  echo "This script requires root privileges."
  exit $?
fi

# zsh configs
cp -rp $HOME/.config/zsh/ $HOME/code/dotfiles/.config/zsh/

# oh-my-zsh configs
cp -rp $HOME/.config/oh-my-zsh/ $HOME/code/dotfiles/.config/oh-my-zsh/

# vim configs
cp $HOME/.vimrc $HOME/code/dotfiles/.vimrc

# nvim configs
cp $HOME/.config/nvim/init.vim $HOME/code/dotfiles/.config/nvim/init.vim

# oh-my-zsh custom theme
cp /usr/local/share/ohmyzsh/themes/custom.zsh-theme $HOME/code/dotfiles/oh-my-zsh/custom.zsh-theme

# .zshrc
cp $HOME/.zshrc $HOME/code/dotfiles/.zshrc
