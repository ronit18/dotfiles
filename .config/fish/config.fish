set fish_greeting # Supresses fish's intro message
set TERM xterm-256color
set -U fish_user_paths $HOME/.bin $HOME/.local/bin $HOME/.config/emacs/bin $HOME/Applications /var/lib/flatpak/exports/bin/ $fish_user_paths

# Set PATH
set -x PATH $HOME/bin /usr/local/bin $PATH
set --universal pure_enable_k8s false


# Add custom directories to PATH
if test -d $HOME/.bin
    set -x PATH $HOME/.bin $PATH
end

if test -d $HOME/.dev/flutter/bin
    set -x PATH $HOME/.dev/flutter/bin $PATH
end

if test -d /opt/flutter/bin
    set -x PATH /opt/flutter/bin $PATH
end

if test -d $HOME/.dev/android-studio/bin
    set -x PATH $HOME/.dev/android-studio/bin $PATH
end

if test -d $HOME/.local/bin
    set -x PATH $HOME/.local/bin $PATH
end

if test -d $HOME/.pub-cache/bin
    set -x PATH $HOME/.pub-cache/bin $PATH
end

# Set GOPATH and Go-related variables
set -x GOPATH $HOME/go
set -x PATH /usr/local/go/bin $PATH $GOPATH/bin

# Set editor and visual editor
set -x EDITOR nvim
set -x VISUAL nvim

function fish_user_key_bindings
    # fish_default_key_bindings
    fish_vi_key_bindings
end


### FUNCTIONS ###

# Functions needed for !! and !$
function __history_previous_command
    switch (commandline -t)
        case "!"
            commandline -t $history[1]
            commandline -f repaint
        case "*"
            commandline -i !
    end
end

function __history_previous_command_arguments
    switch (commandline -t)
        case "!"
            commandline -t ""
            commandline -f history-token-search-backward
        case "*"
            commandline -i '$'
    end
end

# The bindings for !! and !$
if [ "$fish_key_bindings" = fish_vi_key_bindings ]
    bind -Minsert ! __history_previous_command
    bind -Minsert '$' __history_previous_command_arguments
else
    bind ! __history_previous_command
    bind '$' __history_previous_command_arguments
end

# Function for creating a backup file
# ex: backup file.txt
# result: copies file as file.txt.bak
function backup --argument filename
    cp $filename $filename.bak
end

# Function for copying files and directories, even recursively.
# ex: copy DIRNAME LOCATIONS
# result: copies the directory and all of its contents.
function copy
    set count (count $argv | tr -d \n)
    if test "$count" = 2; and test -d "$argv[1]"
        set from (echo $argv[1] | trim-right /)
        set to (echo $argv[2])
        command cp -r $from $to
    else
        command cp $argv
    end
end

# Function for printing a column (splits input on whitespace)
# ex: echo 1 2 3 | coln 3
# output: 3
function coln
    while read -l input
        echo $input | awk '{print $'$argv[1]'}'
    end
end

# Function for printing a row
# ex: seq 3 | rown 3
# output: 3
function rown --argument index
    sed -n "$index p"
end

# Function for ignoring the first 'n' lines
# ex: seq 10 | skip 5
# results: prints everything but the first 5 lines
function skip --argument n
    tail +(math 1 + $n)
end

# Function for taking the first 'n' lines
# ex: seq 10 | take 5
# results: prints only the first 5 lines
function take --argument number
    head -$number
end

# Function for org-agenda
function org-search -d "send a search string to org-mode"
    set -l output (/usr/bin/emacsclient -a "" -e "(message \"%s\" (mapconcat #'substring-no-properties \
        (mapcar #'org-link-display-format \
        (org-ql-query \
        :select #'org-get-heading \
        :from  (org-agenda-files) \
        :where (org-ql--query-string-to-sexp \"$argv\"))) \
        \"
    \"))")
    printf $output
end

### END OF FUNCTIONS ###

# ALIASES
alias .. 'cd ..'
alias ... 'cd ../..'
alias .3 'cd ../../..'
alias .4 'cd ../../../..'
alias .5 'cd ../../../../..'

alias vim 'nvim '
alias rmgit 'rm -rf .git'
alias doc 'cd ~/Documents/'
alias docs 'cd ~/Documents/'
alias desk 'cd ~/Desktop/'
alias dl 'cd ~/Downloads/'
alias yt 'cd ~/yt/'
alias tmp 'cd ~/tmp/'
alias mvwal 'mv *.png ~/pix/'
alias clean 'sudo apt autoremove && sudo apt autoclean && sudo apt clean;sudo snaprm;flatpak uninstall --unused'
alias cat bat
alias fs 'sudo fstrim -av'
alias v nvim
alias yarn 'yarn --emoji true '
alias rmgitcache 'rm -r ~/.cache/git'
alias rmcontainer 'docker container rm -f (docker container ls -aq)'
alias data 'cd /media/ronitgandhi/Windows/Data'

# Git aliases
alias gs 'git status'
alias gpa 'git add -p '
alias ga. 'git add -A '
alias lz lazygit
alias gz lazygit
alias gs="git status"
alias ga="git add"
alias gb="git branch"
alias gco="git checkout"
alias gc="git commit"
alias gcm="git commit -m"
alias gd="git diff"
alias gl="git log"
alias gpl="git pull"
alias gpu="git push"
alias grm="git rm"
alias gcl="git clone"

# All-in-One Alias (ggp - Git Pull and Push)
function ggp
    git pull origin (git symbolic-ref --short HEAD)
    git push origin (git symbolic-ref --short HEAD)
end
# list
alias ls 'exa -a --icons --color=always --group-directories-first'
alias la 'exa --icons --color=always'
alias ll 'exa -S --git -lag --icons --color=always --group-directories-first --octal-permissions'
alias l ls
alias lt 'exa --level=2 --git -aT --color=always --group-directories-first' # tree listing
alias l. 'exa --git -a | egrep "^\."'

# fix obvious typos
alias cd.. 'cd ..'
alias pdw pwd
alias update 'sudo apt update && sudo apt upgrade; sudo snap refresh;flatpak update'

# Kubernetes
alias k kubectl
alias kg 'kubectl get'
alias kd 'kubectl delete'

# Colorize the grep command output for ease of use (good for log files)
alias grep 'grep --color=auto'
alias egrep 'egrep --color=auto'
alias fgrep 'fgrep --color=auto'

# readable output
alias df 'df -h'

# pacman unlock
alias unlock 'sudo rm /var/lib/pacman/db.lck'

# free
alias free 'free -mt'

# continue download
alias wget 'wget -c'

# merge new settings
alias merge 'xrdb -merge ~/.Xresources'

# ps
alias psa 'ps auxf'
alias psgrep 'ps aux | grep -v grep | grep -i -e VSZ -e'

# grub update
alias update-grub 'sudo grub-mkconfig -o /boot/grub/grub.cfg'
# grub issue 08/2022
alias install-grub-efi 'sudo grub-install --target=x86_64-efi --efi-directory=/boot/efi'

# add new fonts
alias update-fc 'sudo fc-cache -fv'

# audio check pulseaudio or pipewire
alias audio 'pactl info | grep "Server Name"'

# youtube download
alias yta-aac 'yt-dlp --extract-audio --audio-format aac '
alias yta-best 'yt-dlp --extract-audio --audio-format best '
alias yta-flac 'yt-dlp --extract-audio --audio-format flac '
alias yta-m4a 'yt-dlp --extract-audio --audio-format m4a '
alias yta-mp3 'yt-dlp --extract-audio --audio-format mp3 '
alias yta-opus 'yt-dlp --extract-audio --audio-format opus '
alias yta-vorbis 'yt-dlp --extract-audio --audio-format vorbis '
alias yta-wav 'yt-dlp --extract-audio --audio-format wav '
alias ytv-best 'yt-dlp -f bestvideo+bestaudio '

# Recent Installed Packages
alias rip 'expac --timefmt="%Y-%m-%d %T" "%l\t%n %v" | sort | tail -200 | nl'
alias riplong 'expac --timefmt="%Y-%m-%d %T" "%l\t%n %v" | sort | tail -3000 | nl'

# search content with ripgrep
alias rg 'rg --sort path'

# maintenance
alias big 'expac -H M "%m\t%n" | sort -h | nl'

alias tobash 'sudo chsh $USER -s /bin/bash && echo "Now log out."'
alias tozsh 'sudo chsh $USER -s /bin/zsh && echo "Now log out."'
alias tofish 'sudo chsh $USER -s /bin/fish && echo "Now log out."'

# shutdown or reboot
alias ssn 'sudo shutdown now'
alias sr reboot

pokemon-colorscripts -r
