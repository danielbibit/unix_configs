# If not running interactively, don't do anything (keep at the top)
[[ $- != *i* ]] && return

ssh-add 2> /dev/null

export VISUAL=nvim
export EDITOR="$VISUAL"

# Fix lazygit not loading config from ~/.config
export XDG_CONFIG_HOME="$HOME/.config"

export PATH="/usr/local/opt/gnu-tar/libexec/gnubin:$PATH"

# Load extensions if they exist
if [ -f "$HOME/zsh_extension.sh" ]; then
    source "$HOME/zsh_extension.sh"
fi

# FZF ^R search (using the zsh version)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Launch main terminals with tmux.
if [[ -z "$TMUX" ]]; then
  case "$TERM_PROGRAM" in
    WezTerm)
      # Always a new session for wezterm. Use exec to exit on dettach
      exec tmux new-session -s "temp-$(date +%s)"\; set-option destroy-unattached on
      ;;
    ghostty)
      # One instance of ghostty
      exec tmux new-session -A -s GhosttyDefault
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

# Helper function to extract files
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

# Write .iso files toa  flashdrive
iso2sd() {
  if [ $# -ne 2 ]; then
    echo "Usage: iso2sd <input_file> <output_device>"
    echo "Example: iso2sd ~/Downloads/ubuntu-25.04-desktop-amd64.iso /dev/sda"
    echo -e "\nAvailable SD cards:"
    lsblk -d -o NAME | grep -E '^sd[a-z]' | awk '{print "/dev/"$1}'
  else
    sudo dd bs=4M status=progress oflag=sync if="$1" of="$2"
    sudo eject $2
  fi
}

# Create a filename.ext.bkp copy on the same directory
mkbkp() {
  if [[ -e "$1" ]]; then
    cp -r "$1" "$1.bkp"
    echo "Copied '$1' to '$1.bkp'"
  else
    echo "Error: '$1' not found."
  fi
}

# Rename the file to [filename].deleteme
deleteme() {
  if [[ -e "$1" ]]; then
    mv "$1" "$1.deleteme"
    echo "Renamed '$1' to '$1.deleteme'"
  else
    echo "Error: '$1' not found."
  fi
}

function parse_git_dirty() {
  command git diff --quiet --ignore-submodules HEAD 2>/dev/null || echo " !"
}

function parse_git_branch() {
  local branch=$(git symbolic-ref --short HEAD 2>/dev/null)
  if [[ -n $branch ]]; then
    echo "($branch$(parse_git_dirty)) "
  fi
}

setopt PROMPT_SUBST # Required to run functions inside the prompt

# %F{15} = White, %F{10} = Green, %F{33} = Blue, %F{226} = Yellow
PROMPT='%F{15}%F{10}%n%F{15}@%F{10}%m%F{15}%F{15} %F{33}%~%F{15}
%F{226}$(parse_git_branch)%# %f'

# Minimal prompt
#PS1='%F{blue}%~ %(?.%F{green}.%F{red})%#%f '

# Set terminal title
case "$TERM" in
    xterm*|rxvt*)
        precmd() { print -Pn "\e]0;${debian_chroot:+($debian_chroot)}%n@%m: %~\a" }
        ;;
esac


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

# better ls
if command -v eza &> /dev/null; then
  alias ls='eza -lg --group-directories-first --classify --icons=auto'
  alias ogls='command ls'

  alias lsa='ls -a'
  alias lt='eza --tree --level=2 --long --icons --git'
  alias lta='lt -a'
fi

# better cat
if command -v bat &> /dev/null; then
    alias cat='bat --paging=never'
    alias ogcat='command cat'
fi

# better cd
if command -v zoxide &> /dev/null; then
  eval "$(zoxide init zsh)"
  alias cd="zd"
  alias ogcd="command cd"

  zd() {
    if [ $# -eq 0 ]; then
      builtin cd ~ && return
    elif [ -d "$1" ]; then
      builtin cd "$1"
    else
      z "$@" && printf "\U000F17A9 " && pwd || echo "Error: Directory not found"
    fi
  }
fi

# cd into the current directory when exiting yazi
function yz() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

function mkcd() {
  mkdir -p "$1" && cd "$1"
}

# load uv binary
[ -f "$HOME/.local/bin/env" ] && . "$HOME/.local/bin/env"
