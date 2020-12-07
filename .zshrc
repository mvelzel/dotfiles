# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/mvelzel/.oh-my-zsh"

alias i3-msg="i3-msg -s \$(i3 --get-socketpath)"
alias i3bar="i3bar -s \$(i3 --get-socketpath)"
alias nightcore="mpv --audio-pitch-correction=no --speed=1.24"
alias lofi="figlet -t -c LoFi Hip Hop Beats ; 
    mpv -ytdl-format 95 \"https://www.youtube.com/watch?v=5qap5aO4i9A\" --no-video --really-quiet 2> /dev/null"

alias drop_cache="sudo sh -c \"echo 3 >'/proc/sys/vm/drop_caches' && swapoff -a && swapon -a && printf '\n%s\n' 'Ram-cache and Swap Cleared'\""
alias chromium="chromium-browser --no-sandbox"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
    vi-mode
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

export DISPLAY=$(grep nameserver /etc/resolv.conf | awk '{print $2}'):0

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
# 
autoload -U colors && colors

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

bindkey -v
export KEYTIMEOUT=1

bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

#function zle-keymap-select {
#    if [[ ${KEYMAP} == vicmd ]] ||
#        [[ $1 = 'block' ]]; then
#            echo -ne '\e[1 q'
#        elif [[ ${KEYMAP} == main ]] ||
#            [[ ${KEYMAP} == viins ]] ||
#            [[ ${KEYMAP} = '' ]] ||
#            [[ $1 = 'beam' ]]; then
#                    echo -ne '\e[5 q'
#    fi
#}
#zle -N zle-keymap-select
#zle-line-init() {
#zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
#echo -ne "\e[5 q"
#}
#zle -N zle-line-init
#echo -ne '\e[5 q' # Use beam shape cursor on startup.
#preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.
#
export PULSE_SERVER=tcp:$(grep nameserver /etc/resolv.conf | awk '{print $2}');

export PATH=~/.local/bin:$PATH

export PATH=~/bin:$PATH

export PATH=~/.local/bin/i3cmds:$PATH

export PATH=~/qtchan/build:$PATH

export PATH=~/.nvm/versions/node/v12.11.0/bin:$PATH

export CTF_ROOT="/home/mvelzel/sec-tools" # DO NOT EDIT This is added by sec-tools
export PATH="/home/mvelzel/sec-tools/bin:/home/mvelzel/sec-tools:$PATH" # DO NOT EDIT This is added by sec-tools

nvm() {
    unset -f nvm
    export NVM_DIR=~/.nvm
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
    nvm "$@"
}
 
node() {
    unset -f node
    export NVM_DIR=~/.nvm
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
    node "$@"
}
 
npm() {
    unset -f npm
    export NVM_DIR=~/.nvm
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
    npm "$@"
}

unsetopt BEEP

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
#
#
eval `dircolors ~/.dir_colors`

zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"

autoload -Uz compinit
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi

POWERLEVEL9K_CONTEXT_TEMPLATE="%n"
POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(vi_mode)
export PATH=$HOME/cmus/bin:$PATH

export FZF_DEFAULT_COMMAND='rg --files --hidden'

export LD_LIBRARY_PATH=/usr/local/lib

unsetopt AUTO_CD
