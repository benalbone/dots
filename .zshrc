ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim
# Install missing modules and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZIM_CONFIG_FILE:-${ZDOTDIR:-${HOME}}/.zimrc} ]]; then
  source /opt/homebrew/opt/zimfw/share/zimfw.zsh init
fi

# styling
# zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

# history timestamp layout
HIST_STAMPS="yyyy-mm-dd"

# plugins
plugins=(
    evalcache
    git
    fzf-tab
) 

# Initialize modules. (sourcing zim)
source ${ZIM_HOME}/init.zsh

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

###################################
### Enable natural text editing ###
###################################
# Move to the beginning of the line. `Cmd + Left Arrow`:
bindkey "^[[1;9D" beginning-of-line
# Move to the end of the line. `Cmd + Right Arrow`:
bindkey "^[[1;9C" end-of-line
# Move to the beginning of the previous word. `Option + Left Arrow`:
bindkey "^[[1;3D" backward-word
# Move to the beginning of the next word. `Option + Right Arrow`:
bindkey "^[[1;3C" forward-word
# Delete the word behind the cursor. `Option + Delete`:
bindkey "^[[3;10~" backward-kill-word
# Delete from the cursor to the beginning of the line. 'Command + Delete';
bindkey "^U" backward-kill-line
###########
### end ###
###########

# Shell integration
# eval "$(fzf --zsh)" ---- swapped to using the evalcache plugin for speed
_evalcache fzf --zsh

# Aliases
## Fun Stuff
alias starwars='ssh starwarstel.net'
alias bonsai='cbonsai -l -i'
alias matrix='cmatrix -bs'
alias news='clx -an'
alias pipes='pipes.sh -t 3 -p 3 -f 80 -R'

## Ez functionality
alias ls='ls --color'
alias buuc='brew update && brew upgrade && brew cleanup'
alias cdc='cd ~/.config'
alias cdd='cd ~/Downloads'
alias cat='bat'

## Script-related
alias ipod='~/Developer/scripts/downloadSongs.sh iPod'

## Work Aliases
alias workexp='cd ~/Downloads; echo "Moving into Downloads directory."; sftp TRDP\\workexp@192.168.11.57'
alias db2='cd ~/Downloads; echo "Moving into Downloads directory."; sftp ben@10.25'
alias ssj-old="/Users/ben/Documents/Work/Scripts/tracked/scripts/perl/Login.pl"
alias pinj="/Users/ben/Documents/Work/Scripts/tracked/scripts/perl/Ping.pl"
alias disk='echo "Opening Returned Disk Swap walkthrough: "; nvim ~/Documents/Work/Notes/disk-backup.md'
alias ssj="perl $HOME/Documents/Work/Scripts/tracked/scripts/perl/NewLogin.pl"
alias cdw='cd ~/Documents/Work'

# Pathing
export PATH="/Users/ben/.gem/ruby/3.4.0/bin:$PATH"
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export PATH="$PATH:/Users/ben/.local/bin"

# function to be able to test the startup times of zsh
function timezsh() {
  shell=${1-$SHELL}
  for i in $(seq 1 10); do /usr/bin/time $shell -i -c exit; done
}

# stop brew auto-updating and displaying hints
export HOMEBREW_NO_ENV_HINTS=1
export HOMEBREW_NO_AUTO_UPDATE=1

# Bash prompt
# export PROMPT='%F{green}%n@%m:%F{blue}%~ %(!.#.$)%f '
