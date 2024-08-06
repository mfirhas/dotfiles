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

# Setup:

## Scripts:
- Add x permission to scripts inside `bin/` dir: `chmod +x *`

## Helix:
- local build: `cargo install --path helix-term --locked`
- Create symlink to local build binary: `sudo ln -sf $HOME/.cargo/bin/hx /usr/local/bin/hxx`
- Use hxx for local build helix
- use hxs for workspace with helix, gitui, lazydocker, and terminals.

## Rust:
- Install Rust through [rustup](https://rustup.rs/)
- Install rust-analyzer `cargo install rust-analyzer`, it installs inside `$HOME/.cargo/bin`
- For debugging: 
  - Install llvm from homebrew: `brew install llvm`
  - Create symlink lldb-dap: `ln -sf /usr/local/opt/llvm/bin/lldb-dap /usr/local/bin/lldb-dap`
  - Create symlink for script to help debug String data: `ln -s $GH/dotfiles/lldb_vscode_rustc_primer.py  /usr/local/etc/lldb_vscode_rustc_primer.py`

## Go:
- Install Go with homebrew `brew install go`
- Install lsp gopls: `go install golang.org/x/tools/gopls@latest`
- Install dap dlv: `go install github.com/go-delve/delve/cmd/dlv@latest`
- Install lint server [golangci-lint-langserver](https://github.com/nametake/golangci-lint-langserver) : `go install github.com/nametake/golangci-lint-langserver@v0.0.8`

## Javascript/Typescript:
- Install LSP server `npm install -g typescript-language-server typescript`

## Java: 
- Install LSP server `brew install jdtls`
