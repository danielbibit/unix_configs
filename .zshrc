## RUN SSH ADD
ssh-add 2> /dev/null

# Default Editor VIM
export VISUAL=vim
export EDITOR="$VISUAL"

# Fix lazygit not loading config from ~/.config
export XDG_CONFIG_HOME="$HOME/.config"

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [[ -z "$TMUX" ]]; then
  case "$TERM_PROGRAM" in
    WezTerm)
      tmux new-session -A -s WezDefault && exit
      ;;
    ghostty)
      tmux new-session -A -s GhosttyDefault && exit
      ;;
  esac
fi

# EMACS keybinding on shell
bindkey -e

# Disable the "bell of death"
unsetopt beep

# --- HISTORY SETTINGS ---
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000

setopt HIST_IGNORE_DUPS      # ignoreboth part 1: Don't record duplicates
setopt HIST_IGNORE_SPACE     # ignoreboth part 2: Don't record lines starting with space
setopt APPEND_HISTORY        # histappend equivalent
setopt SHARE_HISTORY         # Share history between all open terminal windows

# make less more friendly for non-text input files
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

ex () {
    if [ -f "$1" ] ; then
        case $1 in
            *.tar.bz2)   tar xjf "$1"   ;;
            *.tar.gz)    tar xzf "$1"   ;;
            *.bz2)       bunzip2 "$1"   ;;
            *.rar)       unrar x "$1"    ;;
            *.gz)        gunzip "$1"    ;;
            *.tar)       tar xf "$1"    ;;
            *.tbz2)      tar xjf "$1"   ;;
            *.tgz)       tar xzf "$1"   ;;
            *.zip)       unzip "$1"     ;;
            *.Z)         uncompress "$1";;
            *.7z)        7z x "$1"      ;;
            *)           echo "'$1' cannot be extracted via ex()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

setopt PROMPT_SUBST # Required to run functions inside the prompt

function parse_git_dirty() {
    local g_out=$(git status 2>&1)
    local bits=''

    [[ "$g_out" =~ "renamed:" ]] && bits=">$bits"
    [[ "$g_out" =~ "ahead of" ]] && bits="*$bits"
    [[ "$g_out" =~ "new file:" ]] && bits="+$bits"
    [[ "$g_out" =~ "Untracked files" ]] && bits="?$bits"
    [[ "$g_out" =~ "deleted:" ]] && bits="x$bits"
    [[ "$g_out" =~ "modified:" ]] && bits="!$bits"

    if [[ -n $bits ]]; then
        echo " $bits"
    else
        echo ""
    fi
}

function parse_git_branch() {
    local branch=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
    if [[ -n $branch ]]; then
        # Append the symbols directly to the branch name
        echo "(${branch}$(parse_git_dirty))"
    fi
}
# %F{15} = White, %F{10} = Green, %F{33} = Blue, %F{226} = Yellow
PROMPT='%F{15}[%F{10}%n%F{15}@%F{10}%m%F{15}]%F{15}{%F{33}%~%F{15}}
%F{226}$(parse_git_branch)$ %f'

# Set terminal title
case "$TERM" in
    xterm*|rxvt*)
        precmd() { print -Pn "\e]0;${debian_chroot:+($debian_chroot)}%n@%m: %~\a" }
        ;;
esac

# enable color support of ls and also add handy aliases
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    alias ls='ls --color=auto --classify'
elif [[ "$OSTYPE" == "darwin"* ]]; then
    alias ls='ls -G -F' # macOS version of colored ls
fi


alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'


autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z confirmation-Z}={A-Z confirmation-a}' # Case insensitive
zstyle ':completion:*' menu select # Visual menu for Tab
zstyle ':completion:*' list-colors '' # Colorize the completion list


alias h='history 1'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias uvr='uv run'

# FZF (using the zsh version)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Load extensions if they exist
if [ -f "$HOME/zsh_extension.sh" ]; then
    source "$HOME/zsh_extension.sh"
fi
