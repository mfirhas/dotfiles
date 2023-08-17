### run ssh-agent to handle passwords for ssh private keys
# sample usecase: connecting to multiple github accounts with ssh keys attached

eval "$(ssh-agent -s)"
ssh-add -K $HOME/.ssh/id_tiket
