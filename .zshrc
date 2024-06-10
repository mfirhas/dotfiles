### zsh
. "$HOME/.config/zsh/keybindings.conf"

### oh-my-zsh
. "$HOME/.config/oh-my-zsh/oh-my-zsh.conf"

### Rust
export RUSTPATH=$HOME/code/rust

### Go
export PATH=$PATH:/usr/local/bin
export GOPATH=$HOME/code/go
export PATH=$PATH:$GOPATH/bin

### git
export PATH=/usr/local/Cellar/git/2.32.0/bin:$PATH
export GITHUB_SSH_KEYS_ADD=$HOME/code/script/sshadd.sh
export GITHUB=$HOME/code/github.com
export GH=$GITHUB/mfirhas

### VS Code
code () { VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $* ;}

### Latex
export PATH=/usr/local/texlive/2020basic/bin/x86_64-darwin:$PATH
# ### export MANPATH=/usr/local/texlive/2019/texmf-dist/doc/man
# ### export INFOPATH=/usr/local/texlive/2019/texmf-dist/doc/info

### Java
# java 11
export JAVA_HOME=/usr/local/opt/openjdk@11/libexec/openjdk.jdk/Contents/Home
# java 17
# export JAVA_HOME=/usr/local/opt/openjdk@17/libexec/openjdk.jdk/Contents/Home
# java 21
#export JAVA_HOME=/usr/local/opt/openjdk@21/libexec/openjdk.jdk/Contents/Home

### ruby 3
export PATH="/usr/local/opt/ruby/bin:$PATH"

### python 3
export PATH="/usr/local/opt/python@3/bin:$PATH"

### sonarqube
export PATH=$PATH:/usr/local/Cellar/sonar-scanner/4.6.2.2472_1/bin

### fzf
. "$HOME/.config/fzf/fzfrc"

### aichat
export AICHAT_CONFIG_DIR=$HOME/.config/aichat

### homebrew
export HOMEBREW_NO_AUTO_UPDATE=1

### llvm
#export PATH=$(brew --prefix)/opt/llvm/bin:$PATH

. "$HOME/.config/broot/brootrc"
