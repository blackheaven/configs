#!/usr/bin/env zsh

# Set required options.
setopt promptsubst

# Load required modules.
autoload -U add-zsh-hook
autoload -Uz vcs_info

# Add hook for calling vcs_info before each command.
add-zsh-hook precmd vcs_info

# Set vcs_info parameters.
zstyle ':vcs_info:*' enable hg bzr git svn fossil
zstyle ':vcs_info:*:*' check-for-changes true # Can be slow on big repos.
zstyle ':vcs_info:*:*' unstagedstr "%B%{$fg[blue]%} *"
zstyle ':vcs_info:*:*' stagedstr "%B%{$fg[green]%} ✚"
zstyle ':vcs_info:*:*' actionformats "%S" "%r/%s/%b %u%c (%a)%f%{$reset_color%}"
zstyle ':vcs_info:*:*' formats "%B%c %{$fg[yellow]%}%i %{$fg[blue]%}%s:%{$fg[red]%}%b%f%{$reset_color%}"
zstyle ':vcs_info:*:*' nvcsformats "" ""
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b'

PROMPT='%{$fg_bold[green]%}%* %{$fg[blue]%}%c %{$fg_bold[red]%}➜ %f%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="git:%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%f%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}%f%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

RPROMPT='${vcs_info_msg_0_}${return_status}%f%{$reset_color%}'

#ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%} ✚"
#ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[blue]%} ✹"
#ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%} ✖"
#ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[magenta]%} ➜"
#ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[yellow]%} ═"
#ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[cyan]%} ✭"
#
## Colors vary depending on time lapsed.
#ZSH_THEME_GIT_TIME_SINCE_COMMIT_SHORT="%{$fg[green]%}"
#ZSH_THEME_GIT_TIME_SHORT_COMMIT_MEDIUM="%{$fg[yellow]%}"
#ZSH_THEME_GIT_TIME_SINCE_COMMIT_LONG="%{$fg[red]%}"
#ZSH_THEME_GIT_TIME_SINCE_COMMIT_NEUTRAL="%{$fg[cyan]%}"
#
## Determine the time since last commit. If branch is clean,
## use a neutral color, otherwise colors will vary according to time.
#function git_time_since_commit() {
#    if git rev-parse --git-dir > /dev/null 2>&1; then
#        # Only proceed if there is actually a commit.
#        if [[ $(git log 2>&1 > /dev/null | grep -c "^fatal: bad default revision") == 0 ]]; then
#            # Get the last commit.
#            last_commit=`git log --pretty=format:'%at' -1 2> /dev/null`
#            now=`date +%s`
#            seconds_since_last_commit=$((now-last_commit))
#
#            # Totals
#            MINUTES=$((seconds_since_last_commit / 60))
#            HOURS=$((seconds_since_last_commit/3600))
#
#            # Sub-hours and sub-minutes
#            DAYS=$((seconds_since_last_commit / 86400))
#            SUB_HOURS=$((HOURS % 24))
#            SUB_MINUTES=$((MINUTES % 60))
#
#            if [[ -n $(git status -s 2> /dev/null) ]]; then
#                if [ "$MINUTES" -gt 30 ]; then
#                    COLOR="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_LONG"
#                elif [ "$MINUTES" -gt 10 ]; then
#                    COLOR="$ZSH_THEME_GIT_TIME_SHORT_COMMIT_MEDIUM"
#                else
#                    COLOR="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_SHORT"
#                fi
#            else
#                COLOR="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_NEUTRAL"
#            fi
#
#            START_LAST="%f%{$reset_color%}["
#            END_LAST="%f%{$reset_color%}|$COLOR$(git_prompt_short_sha)%f%{$reset_color%}]"
#            if [ "$HOURS" -gt 24 ]; then
#                echo "$START_LAST$COLOR${DAYS}d${SUB_HOURS}h${SUB_MINUTES}m%f%{$reset_color%}$END_LAST"
#            elif [ "$MINUTES" -gt 60 ]; then
#                echo "$START_LAST$COLOR${HOURS}h${SUB_MINUTES}m%f%{$reset_color%}$END_LAST"
#            else
#                echo "$START_LAST$COLOR${MINUTES}m%f%{$reset_color%}$END_LAST"
#            fi
#        else
#            COLOR="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_NEUTRAL"
#            echo "$COLOR~"
#        fi
#    fi
#}
