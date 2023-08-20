# CUSTOM THEME
## based on afowler

NEWLINE=$'\n%B%F{green}$ '
PROMPT='%n%B%F{red}@%{$reset_color%}%m %B%F{blue}:: %b%F{green}%3~ $(hg_prompt_info)$(git_prompt_info)%B%(!.%F{red}.%F{blue})»%f%b '
PROMPT="$PROMPT$NEWLINE"
PS1=$'${(r:$COLUMNS::_:)}'$PS1
RPS1='(%D{%H:%M:%S})'
# RPS1='%(?..%F{red}%? ↵%f)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="› %{$reset_color%}"

ZSH_THEME_HG_PROMPT_PREFIX="%{$fg[magenta]%}hg:‹%{$fg[yellow]%}"
ZSH_THEME_HG_PROMPT_SUFFIX="%{$fg[magenta]%}› %{$reset_color%}"
ZSH_THEME_HG_PROMPT_DIRTY=" %{$fg[red]%}✗"
ZSH_THEME_HG_PROMPT_CLEAN=""
