CODE="$(which code)"
if [ $CODE="/usr/bin/code" ]; then
    # code --list-extensions | xargs -L 1 echo code --install-extension
    # [createInstance] extensionManagementService depends on downloadService which is NOT registered.
    code --install-extension alefragnani.delphi-themes
    code --install-extension bungcip.better-toml
    code --install-extension eamodio.gitlens
    code --install-extension GitHub.vscode-pull-request-github
    code --install-extension liximomo.sftp
    code --install-extension mkloubert.vscode-remote-workspace
    code --install-extension ms-vscode.Go
    code --install-extension PeterJausovec.vscode-docker
    code --install-extension PKief.material-icon-theme
    code --install-extension robertohuertasm.vscode-icons
    code --install-extension zxh404.vscode-proto3
else
    echo "vscode not installed!"
fi