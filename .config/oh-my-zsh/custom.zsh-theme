# CUSTOM THEME
# /usr/local/share/ohmyzsh/themes/custom.zsh-theme
# $HOME/.oh-my-zsh/themes/custom.zsh-theme
## based on afowler

NEWLINE=$'\n%F{green}$ %{$reset_color%}'
### left prompt statement: username::hostname::<dirpath>(git branch)
# PROMPT='%n%F{blue}::%{$reset_color%}%m%F{blue}::%F{blue}<%b%F{green}%3~%F{blue}>($(hg_prompt_info)$(git_prompt_info)%B%(!.%F{red}.%F{blue})%b%F{blue})'
PROMPT='%B%(!.%F{red}.%F{blue})»%f%b %~ $(hg_prompt_info)$(git_prompt_info) '
PROMPT="$PROMPT$NEWLINE"
PS1=$'${(r:$COLUMNS::_:)}'$PS1
### right prompt statement
# RPS1='<%D{%f/%m/%y}>::<%F{green}%D{%H:%M:%S}%{$reset_color%}>'
# RPS1='%(?..%F{red}%? ↵%f)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"

ZSH_THEME_HG_PROMPT_PREFIX="%{$fg[magenta]%}hg:‹%{$fg[yellow]%}"
ZSH_THEME_HG_PROMPT_SUFFIX="%{$fg[magenta]%}› %{$reset_color%}"
ZSH_THEME_HG_PROMPT_DIRTY=" %{$fg[red]%}✗"
ZSH_THEME_HG_PROMPT_CLEAN=""
