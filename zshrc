export LC_TIME=fr_FR.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en
export LC_ALL=en_US.UTF-8

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="blackheaven"
# ZSH_THEME="fino-time" # intéressant pour le nombre d'infos (2 lignes)
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git mercurial svn tmux tmuxinator cp vi-mode ruby gem zsh-syntax-highlighting)
export ZSH_TMUX_AUTOSTART=true
export ZSH_TMUX_AUTOSTART_ONCE=true
export EDITOR=/usr/bin/vim

# Customize to your needs...
export PATH=/home/black/.stack/snapshots/x86_64-linux/lts-3.11/7.10.2/bin:$HOME/.rbenv/bin:$PATH:/sbin:/usr/local/bin:/usr/local:~/scripts:/usr/local/bin:/usr/bin:/bin:$HOME/bin:/usr/local/sbin:/usr/sbin:/usr/local/lib/erlang16/bin:$HOME/.npm/bin:$HOME/.local/bin

# PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
# [[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # This loads RVM into a shell session.
eval "$(rbenv init -)"
export PATH=$HOME/.rbenv/versions/$(ruby -v | cut -d ' ' -f 2 | sed -e s/p/-p/)/bin:$PATH

source $ZSH/oh-my-zsh.sh

npm_chpwd_hook() {
    if [ -n "${PRENPMPATH+x}" ]; then
        PATH=$PRENPMPATH
        unset PRENPMPATH
    fi
    if [ -f package.json ]; then
        PRENPMPATH=$PATH
        PATH=$(npm bin):$PATH
    fi
}

add-zsh-hook preexec npm_chpwd_hook

fpath=(~/.zsh $fpath)
zstyle ':completion:*:*:git:*' user-commands fixup:'Create a fixup commit'
autoload +X _git-fixup

# The following lines were added by compinstall

#zstyle ':completion:*' completer _list _oldlist _expand _complete _ignored _match _correct _approximate _prefix
#zstyle ':completion:*' list-colors ''
# zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
# zstyle ':completion:*' match-original both
# zstyle ':completion:*' max-errors 4 numeric
# zstyle ':completion:*' old-list always
# zstyle ':completion:*' word true
# zstyle :compinstall filename '$HOME/.zshrc'
# 
# autoload -Uz compinit
# compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=5000
bindkey -v
# End of lines configured by zsh-newuser-install

autoload -U zmv
unsetopt correctall
setopt autocd correct
alias vi=vim

bindkey "\e[H" beginning-of-line # Dét
bindkey "\e[F" end-of-line # Fin
bindkey '\e[1~' beginning-of-line
bindkey '\e[4~' end-of-line
bindkey "\e[3~" delete-char
bindkey "^R" history-incremental-search-backward # Rechercher"]]]"
bindkey "4~" "~"
bindkey "^v" edit-command-line

alias irssi='TERM=tmux irssi'
alias tmux='tmux -u'
alias zip='zip -r'
alias du='du -hs'
alias mail_disable="sudo iptables -A OUTPUT -p tcp --dport 465 -j REJECT"
function mail_enable {
    sudo iptables -D OUTPUT $(sudo iptables -nvL OUTPUT --line-numbers | grep dpt:465 | grep  REJECT | cut -f1 -d' ')
}
function mkcd {
    mkdir "$1" && cd "$1"
}

. ~/.local/lib/python3.6/site-packages/powerline/bindings/zsh/powerline.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
