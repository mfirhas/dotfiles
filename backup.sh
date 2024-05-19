##########################################################
### scripts to backup things from system into dotfiles ###
##########################################################

# make sure run as sudo
if [ "$EUID" -ne 0 ]
then
  echo "This script requires root privileges."
  exit $?
fi

# .zshrc
cp $HOME/.zshrc $HOME/code/github.com/mfirhas/dotfiles/.zshrc

# zsh configs
cp -rp $HOME/.config/zsh/ $HOME/code/github.com/mfirhas/dotfiles/.config/zsh/

# oh-my-zsh configs
cp -rp $HOME/.config/oh-my-zsh/ $HOME/code/github.com/mfirhas/dotfiles/.config/oh-my-zsh/

# oh-my-zsh custom theme
cp /usr/local/share/ohmyzsh/themes/custom.zsh-theme $HOME/code/github.com/mfirhas/dotfiles/oh-my-zsh/custom.zsh-theme

# vim configs
cp $HOME/.vimrc $HOME/code/github.com/mfirhas/dotfiles/.vimrc

# nvim configs
# uninstall neovim and nvchad, move to helix
#cp $HOME/.config/nvim/init.vim $HOME/code/github.com/mfirhas/dotfiles/.config/nvim/init.vim

# cargo
# NOTE: DO NOT copy all .cargo contents!!
cp $HOME/.cargo/config.toml $HOME/code/github.com/mfirhas/dotfiles/.cargo/config.toml

# tmux configs
cp $HOME/.tmux.conf $HOME/code/github.com/mfirhas/dotfiles/.tmux.conf

cp -rp $HOME/.config/wezterm/ $HOME/code/github.com/mfirhas/dotfiles/.config/wezterm/
