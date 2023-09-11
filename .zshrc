###ZSH PROMPT
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
typeset -g POWERLEVEL9K_INSTANT_PROMPT=off

###ZSH###
export PATH=$HOME/bin:/usr/local/bin:$PATH
export ZSH=$HOME/.oh-my-zsh/

ZSH_THEME="powerlevel10k/powerlevel10k"

##ZSH plugin config
typeset -g VI_MODE_SET_CURSOR=false
typeset -g ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#808080"
typeset -g ZVM_VI_INSERT_ESCAPE_BINDKEY=jk
typeset -g ZVM_CURSOR_STYLE_ENABLED=false

plugins=(
    git
    kubectl
    z
    aws
    fast-syntax-highlighting
    zsh-autosuggestions
    zsh-vi-mode
)

#PATH
if [ -f $ZSH/oh-my-zsh.sh ]; then
    source $ZSH/oh-my-zsh.sh
fi

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

if [ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

if [ -d "$HOME/.bin" ] ;
then PATH="$HOME/.bin:$PATH"
fi

if [ -d "$HOME/.dev/flutter/bin" ] ;
then PATH="$HOME/.dev/flutter/bin:$PATH"
fi

if [ -d "/opt/flutter/bin" ] ;
then PATH="/opt/flutter/bin:$PATH"
fi

if [ -d "$HOME/.dev/android-studio/bin" ] ;
then PATH="$HOME/.dev/android-studio/bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ;
then PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/.pub-cache/bin" ] ;
then PATH="$HOME/.pub-cache/bin:$PATH"
fi

#GO
export GOPATH=$HOME/go
export PATH=/usr/local/go/bin:$PATH:$GOPATH/bin

# Change directory using fzf
fcd() {
    cd $(find -type d 2> /dev/null | fzf --preview 'ls -la {}' --bind 'ctrl-o:execute(cd {})')
}
# Open a folder in Visual Studio Code using fzf
fzfcode() {
    local folder=$(fd --type d | fzf --preview 'ls -al {}' --query "$argv" --select-1 --exit-0)
    if [ -n "$folder" ]; then
        code --folder-uri=file://$folder
    fi
}

export PAGER='most'

setopt GLOB_DOTS
#share commands between terminal instances or not
unsetopt SHARE_HISTORY
#setopt SHARE_HISTORY

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export HISTCONTROL=ignoreboth:erasedups

# Make nano the default editor

export EDITOR='nvim'
export VISUAL='nvim'

#PS1='[\u@\h \W]\$ '

### ALIASES ###
alias vim='nvim '
alias rmgit='rm -rf .git'
alias doc='cd ~/Documents/'
alias docs='cd ~/Documents/'
alias desk='cd ~/Desktop/'
alias dl='cd ~/Downloads/'
alias yt='cd ~/yt/'
alias tmp='cd ~/tmp/'
alias mvwal='mv *.png ~/pix/'
alias clean='sudo apt autoremove && sudo apt autoclean && sudo apt clean;sudo snaprm;flatpak uninstall --unused'
alias cat='bat'
alias fs='sudo fstrim -av'
alias v='nvim'
alias yarn='yarn --emoji true '
alias rmgitcache="rm -r ~/.cache/git"
alias rmcontainer="docker container rm -f $(docker container ls -aq)"
alias data='/media/ronitgandhi/Windows/Data'

#git
alias gs='git status'
alias gm='git commit -m '
alias ga='git add '
alias gpa='git add -p '
alias ga.='git add -A '
alias lz='lazygit'

#list
alias ls='exa -a --icons --color=always --group-directories-first'
alias la='exa --icons --color=always'
alias ll='exa -S --git -lag --icons --color=always --group-directories-first --octal-permissions'
alias l='ls'
alias lt='exa --level=2 --git -aT --color=always --group-directories-first' # tree listing
alias l.='exa --git -a | egrep "^\."'


#fix obvious typo's
alias cd..='cd ..'
alias pdw='pwd'
alias update='sudo apt update && sudo apt upgrade; sudo snap refresh;flatpak update'

#Kubernetes
alias k='kubectl'
alias kg='kubectl get'
alias kd='kubectl delete'

## Colorize the grep command output for ease of use (good for log files)##
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

#readable output
alias df='df -h'

#pacman unlock
alias unlock="sudo rm /var/lib/pacman/db.lck"

#free
alias free="free -mt"

#continue download
alias wget="wget -c"

#merge new settings
alias merge="xrdb -merge ~/.Xresources"

#ps
alias psa="ps auxf"
alias psgrep="ps aux | grep -v grep | grep -i -e VSZ -e"

#grub update
alias update-grub="sudo grub-mkconfig -o /boot/grub/grub.cfg"
#grub issue 08/2022
alias install-grub-efi="sudo grub-install --target=x86_64-efi --efi-directory=/boot/efi"

#add new fonts
alias update-fc='sudo fc-cache -fv'

#audio check pulseaudio or pipewire
alias audio="pactl info | grep 'Server Name'"

#youtube download
alias yta-aac="yt-dlp --extract-audio --audio-format aac "
alias yta-best="yt-dlp --extract-audio --audio-format best "
alias yta-flac="yt-dlp --extract-audio --audio-format flac "
alias yta-m4a="yt-dlp --extract-audio --audio-format m4a "
alias yta-mp3="yt-dlp --extract-audio --audio-format mp3 "
alias yta-opus="yt-dlp --extract-audio --audio-format opus "
alias yta-vorbis="yt-dlp --extract-audio --audio-format vorbis "
alias yta-wav="yt-dlp --extract-audio --audio-format wav "
alias ytv-best="yt-dlp -f bestvideo+bestaudio "

#Recent Installed Packages
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"
alias riplong="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -3000 | nl"

#search content with ripgrep
alias rg="rg --sort path"

#maintenance
alias big="expac -H M '%m\t%n' | sort -h | nl"

alias tobash="sudo chsh $USER -s /bin/bash && echo 'Now log out.'"
alias tozsh="sudo chsh $USER -s /bin/zsh && echo 'Now log out.'"
alias tofish="sudo chsh $USER -s /bin/fish && echo 'Now log out.'"

#shutdown or reboot
alias ssn="sudo shutdown now"
alias sr="reboot"

# # ex = EXtractor for all kinds of archives
# # usage: ex <file>
ex ()
{
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xjf $1   ;;
            *.tar.gz)    tar xzf $1   ;;
            *.bz2)       bunzip2 $1   ;;
            *.rar)       unrar x $1   ;;
            *.gz)        gunzip $1    ;;
            *.tar)       tar xf $1    ;;
            *.tbz2)      tar xjf $1   ;;
            *.tgz)       tar xzf $1   ;;
            *.zip)       unzip $1     ;;
            *.Z)         uncompress $1 ;;
            *.7z)        7z x $1      ;;
            *.deb)       ar x $1      ;;
            *.tar.xz)    tar xf $1    ;;
            *.tar.zst)   tar xf $1    ;;
            *)           echo "'$1' cannot be extracted via ex()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

#Docker and Kubernetes autocomplete
if [ -f /usr/share/zsh/vendor-completions/_docker ]; then
    source /usr/share/zsh/vendor-completions/_docker
fi

if [ -f ~/.kube/kubectl.zsh ]; then
    source ~/.kube/kubectl.zsh
fi

if [ -f ~/.oh-my-zsh/custom/completions/_stern.zsh ]; then
    source ~/.oh-my-zsh/custom/completions/_stern.zsh
fi

if [ -f ~/.oh-my-zsh/custom/completions/_eksctl.zsh ]; then
    source ~/.oh-my-zsh/custom/completions/_eksctl.zsh
fi

if [ -f ~/.oh-my-zsh/custom/completions/_minikube.zsh ]; then
    source ~/.oh-my-zsh/custom/completions/_minikube.zsh
fi

if [ -f ~/.oh-my-zsh/custom/completions/_helm.zsh ]; then
    source ~/.oh-my-zsh/custom/completions/_helm.zsh
fi

[[ -f ~/.zshrc-personal ]] && . ~/.zshrc-personal

pokemon-colorscripts -r

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# pnpm
export PNPM_HOME="/home/ronitgandhi/.local/share/pnpm"
case ":$PATH:" in
    *":$PNPM_HOME:"*) ;;
    *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# AWS autocomplete
autoload bashcompinit
bashcompinit
complete -C aws_completer aws

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
