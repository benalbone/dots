# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# fzf colorscheme (oxocarbon)
# export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS' --color=fg:#ffffff,bg:#161616,hl:#08bdba --color=fg+:#f2f4f8,bg+:#262626,hl+:#3ddbd9 --color=info:#78a9ff,prompt:#33b1ff,pointer:#42be65 --color=marker:#ee5396,spinner:#ff7eb6,header:#be95ff'

# omzsh theme
ZSH_THEME="robbyrussell"

# styling
zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

# history timestamp layout
HIST_STAMPS="yyyy-mm-dd"

# Source the zsh-syntax-highlighting catppuccin theme
# source ~/.catppuccin_mocha-zsh-syntax-highlighting.zsh

# plugins
plugins=(zsh-syntax-highlighting git fzf-tab) # zsh-autosuggestions

# sourcing omzsh
source "$ZSH/oh-my-zsh.sh"

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
eval "$(fzf --zsh)"

# Personal Aliases
alias ls='ls --color'

alias starwars='ssh starwarstel.net'
alias bonsai='cbonsai -l -i'
alias matrix='cmatrix -bs'
alias news='clx -an'
alias pipes='pipes.sh -t 3 -p 3 -f 80 -R'

alias buuc='brew update && brew upgrade && brew cleanup'
alias cdc='cd ~/.config'
alias cdd='cd ~/Downloads'

alias ipod='~/Developer/scripts/downloadSongs.sh iPod'

# Work Aliases
alias workexp='cd ~/Downloads; echo "Moving into Downloads directory."; sftp TRDP\\workexp@192.168.11.57'
alias db2='cd ~/Downloads; echo "Moving into Downloads directory."; sftp ben@10.25'
alias ssj-old="/Users/ben/Documents/Work/Scripts/tracked/scripts/Login.pl"
alias pinj="/Users/ben/Documents/Work/Scripts/tracked/scripts/Ping.pl"
alias disk='echo "Opening Returned Disk Swap walkthrough: "; nvim ~/Documents/Work/Notes/disk-backup.md'
alias ssj="perl $HOME/Documents/Work/Scripts/tracked/scripts/NewLogin.pl"
alias cdw='cd ~/Documents/Work'

export PATH="/Users/ben/.gem/ruby/3.4.0/bin$PATH"
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"

# Created by `pipx` on 2025-06-23 08:21:13
export PATH="$PATH:/Users/ben/.local/bin"

# Starship
# export STARSHIP_CONFIG=~/.config/starship/starship.toml
# eval "$(starship init zsh)"
