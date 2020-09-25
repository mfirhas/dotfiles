### Go v1.15.0
export PATH=$PATH:/usr/local/bin
export GOPATH=$HOME/code/go
export PATH=$PATH:$GOPATH/bin

### VS Code
code () { VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $* ;}

### Latex
export PATH=/usr/local/texlive/2020basic/bin/x86_64-darwin:$PATH
### export MANPATH=/usr/local/texlive/2019/texmf-dist/doc/man
### export INFOPATH=/usr/local/texlive/2019/texmf-dist/doc/info

### Java 14.0.1
export JAVA_HOME=$(/usr/libexec/java_home)
export PATH="/usr/local/opt/openjdk/bin:$PATH"