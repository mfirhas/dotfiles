### Go v1.18.1
export PATH=$PATH:/usr/local/bin
export GOPATH=$HOME/code/go
export PATH=$PATH:$GOPATH/bin

# ### Nodejs v14.12.0
export PATH=$PATH:/usr/local/Cellar/node/14.12.0/bin

# ### VS Code
code () { VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $* ;}

# ### Latex
export PATH=/usr/local/texlive/2020basic/bin/x86_64-darwin:$PATH
# ### export MANPATH=/usr/local/texlive/2019/texmf-dist/doc/man
# ### export INFOPATH=/usr/local/texlive/2019/texmf-dist/doc/info

# ### Java
# java 11
export JAVA_HOME=/usr/local/opt/openjdk@11/libexec/openjdk.jdk/Contents/Home
# java 17
#export JAVA_HOME=/usr/local/opt/openjdk@17/libexec/openjdk.jdk/Contents/Home

# ### git
export PATH=/usr/local/Cellar/git/2.32.0/bin:$PATH
export GITHUB_SSH_KEYS_ADD=$HOME/code/script/sshadd.sh

# ### sonarqube
export PATH=$PATH:/usr/local/Cellar/sonar-scanner/4.6.2.2472_1/bin

### rust
export PATH=$HOME/.cargo/bin:$PATH
