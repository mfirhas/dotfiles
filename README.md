my humble dot files

contains configurations and scripts.

most things installed and manage through homebrew, some manually installed through script or some kind of installer.

dir `.config`: resides inside $HOME/ dir, some configured from .zshrc, some read directly.
dir `.cargo` : resides inside $HOME/ dir, DO NOT move all of its contents as some might contain secrets.

flow: 
- In a new device(mac), configs need to be placed in its place manually. E.g. .config placed inside $HOME dir.
- System should be the main source, whenever edits made in system configs, backup them with backup.sh script.
- Whenever there's new or movements of configs locations, make sure to adjust the backup.sh so that changes reflected in new configs or their new places.

Brewfile:
All things managed by Homebrew are inside this file, install them by running:
```sh
brew bundle install
```

Rust:
Managed by Rustup and Cargo for some binaries installations.

