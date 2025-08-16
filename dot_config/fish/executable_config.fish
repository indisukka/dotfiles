#****************************************************************************************
#   Fish Config 
#****************************************************************************************

# User paths
# /var/lib/flatpak/exports/bin/ for having flatpak exec in path, some flatpak not creating .desktop files
set -U fish_user_paths $HOME/.bin $HOME/.local/bin $HOME/Applications $fish_user_paths
#set -U fish_user_paths $HOME/.spicetify $fish_user_paths

# set various values
set -x EDITOR nvim                                    # set editor as nvim
set -x VISUAL subl                                    # set editor as sublime-text
set fish_greeting                                     # suppress fish greeting
set fish_color_autosuggestion '#7d7d7d'

# set 'bat' as manpager
if type -q bat 
  set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"     
end

# Prevent directories names from being shortened,need to use if starship prompt is not used
# set fish_prompt_pwd_dir_length 0

# Source Various files
# if [-f ~/.config/fish/functions/functions.fish]
#   source ~/.config/fish/functions/functions.fish
# end

#source ~/.config/fish/functions/fish_prompt.fish

# Use fish prompt if starship prompt not installed
if type -q starship
  starship init fish | source
else
  source ~/.config/fish/functions/fish_prompt.fish
end

# Ignore duplicate commands in history
set HISTCONTROL ignoredups

#****************************************************************************************
# Alias
#****************************************************************************************
alias grep='rg'
alias cat='bat'
alias df="df -h"
alias free="free -mt"
alias wget="wget -c"
alias hw="hwinfo --short"
alias cp="cp -i"
alias mv='mv -i'
alias rm='trash'

alias ..='cd ..'
alias ...='cd ../..'


#systeminfo
alias probe="sudo -E hw-probe -all -upload"
alias sysfailed="systemctl list-units --failed"

# arcolinux logout unlock
alias rmlogoutlock="sudo rm /tmp/arcologout.lock"

# userlist
alias userlist="cut -d: -f1 /etc/passwd"

# merge new settings
alias merge="xrdb -merge ~/.Xresources"

# grub update
alias update-grub="sudo grub-mkconfig -o /boot/grub/grub.cfg"
# grub issue 08/2022
alias install-grub-efi="sudo grub-install --target=x86_64-efi --efi-directory=/boot/efi"

# backup contents of /etc/skel to hidden backup folder in home/user
alias bupskel="cp -Rf /etc/skel ~/.skel-backup-(date +%Y.%m.%d-%H.%M.%S)"

# switch between bash, zsh and fish
alias tobash="sudo chsh $USER -s /bin/bash && echo 'Done. Now log out.'"
alias tofish="sudo chsh $USER -s /bin/fish && echo 'Done. Now log out.'"

# check vulnerabilities microcode
alias microcode="grep . /sys/devices/system/cpu/vulnerabilities/*"

# get fastest mirrors in your neighborhood
alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
alias mirrord="sudo reflector --latest 30 --number 10 --sort delay --save /etc/pacman.d/mirrorlist"

# gpg
#verify signature for isos
alias gpg-check="gpg2 --keyserver-options auto-key-retrieve --verify"
alias fix-gpg-check="gpg2 --keyserver-options auto-key-retrieve --verify"
#receive the key of a developer
alias gpg-retrieve="gpg2 --keyserver-options auto-key-retrieve --receive-keys"
alias fix-gpg-retrieve="gpg2 --keyserver-options auto-key-retrieve --receive-keys"
alias fix-keyserver="[ -d ~/.gnupg ] || mkdir ~/.gnupg ; cp /etc/pacman.d/gnupg/gpg.conf ~/.gnupg/ ; echo 'done'"

# fixes
alias fix-permissions="sudo chown -R $USER:$USER ~/.config ~/.local"
alias fixkey="/usr/local/bin/arcolinux-fix-pacman-databases-and-keys"
alias fix-pacman-conf="/usr/local/bin/arcolinux-fix-pacman-conf"
alias fix-pacman-keyserver="/usr/local/bin/arcolinux-fix-pacman-gpg-conf"

#****************************************************************************************
# YOUTUBE-DLP
#****************************************************************************************

# Video Alias
alias yv='yt-dlp'
alias yv-best='yt-dlp --ignore-config -o "$HOME/Videos/%(title)s_%(channel)s.%(ext)s" -f "bv*+ba/b" --remux-video "mkv"'
alias yv2k='yt-dlp --ignore-config -o "$HOME/Videos/%(title)s_%(channel)s.%(ext)s" -f "bv*[height<=1440]+ba" --remux-video "mkv"'
alias yv-batch='yt-dlp -a "$HOME/Videos/yt-batch.txt"'

# Playlist Alias
alias yvp='yt-dlp --config-location "$HOME/.config/yt-dlp/config_playlist"'
alias yvp-batch='yt-dlp -a "$HOME/Videos/ytp-batch.txt" --config-location "$HOME/.config/yt-dlp/config_playlist"'

# Audio Alias
alias ya='yt-dlp --ignore-config -o "$HOME/Downloads/yt_audio/%(title)s_%(channel)s.%(ext)s" -x --audio-format "vorbis" --audio-quality "best"'
alias yap='yt-dlp --ignore-config -o "$HOME/Downloads/yt_audio/%(playlist_title)s/%(playlist_index)s_%(title)s.%(ext)s" -x --audio-format "best" --audio-quality "best" '

# eza as ls alias
alias l='eza -la --group-directories-first'
alias ls='eza -a --icons --group-directories-first'
alias ll='eza -lah --icons --group-directories-first'
alias lr='eza -TlR -s name --group-directories-first --icons -L 2'

# g alias
# alias l='g -l --icon'
# alias ls='g -A --icon'
# alias la='g -l -A --icon --header'
alias lta='g -l -A --icon --table --table-style=unicode --header'
alias lt='g -l --icon --table --table-style=unicode'
# alias ltr='g -l -A -T --depth=2'

#****************************************************************************************
# Abbreviations 
#****************************************************************************************
abbr att archlinux-tweak-tool
abbr . 'cd ~'
abbr cr 'cd ~/repos'
abbr upall 'paru -Syu --noconfirm'
abbr fc 'sudo fc-cache -f'
abbr qq exit

# Editor abbreviations
abbr vb '$EDITOR .bashrc'
abbr vbp '$EDITOR .bashrc-personal'
abbr vf '$EDITOR ~/.config/fish/config.fish'
abbr va '$EDITOR ~/.config/alacritty/alacritty.yml'

# pacman abbreviations
abbr install 'sudo pacman -S'
abbr update 'sudo pacman -Syyu'
abbr remove 'sudo pacman -Rns'
abbr uninstall 'sudo pacman -Rs'
abbr rmorphans 'sudo pacman -Rs $(pacman -Qqtd)'

# git abbreviations
abbr gi 'git init'
abbr ga 'git add'
abbr gc 'git clone --depth=1'
abbr gcm 'git commit -m'
abbr gp 'git push'
abbr gb 'git branch'
abbr gpl 'git pull'
abbr gf 'git fetch'
abbr gchk 'git checkout'

# Chezmoi
abbr ca 'chezmoi add'
abbr ce 'chezmoi edit ~/.config/'
abbr ccd 'chezmoi cd'
abbr cva 'chezmoi -v apply'
abbr cdif 'chezmoi diff'

# Weather
abbr weather 'curl wttr.in'
abbr wmang 'curl wttr.in/mangaluru'
abbr wbang 'curl wttr.in/bengaluru'

# Mirrors
abbr mirl 'sudo reflector --latest 10 --sort rate --age 24 --country India,HongKong,Japan,Singapore,Sweden --verbose --save /etc/pacman.d/mirrorlist'
abbr mir 'sudo reflector --latest 10 --sort rate --age 24 --verbose --save /etc/pacman.d/mirrorlist'

#****************************************************************************************
#FUNCTIONS 
#****************************************************************************************

# Fish command history
function history
    builtin history --show-time='%F %T ' | sort
end

# recently installed packages
function ripp --argument length -d "List the last n (100) packages installed"
    if test -z $length
        set length 50
    end
    expac --timefmt='%Y-%m-%d %T' '%l\t%n' | sort | tail -n $length | nl
end

# Function to extracts a compressed file
function ex --description "Extract bundled & compressed files"
    if test -f "$argv[1]"
        switch $argv[1]
            case '*.tar.bz2'
                tar xjfv $argv[1]
            case '*.tar.gz'
                tar xzfv $argv[1]
            case '*.bz2'
                bunzip2 $argv[1]
            case '*.rar'
                unrar $argv[1]
            case '*.gz'
                gunzip $argv[1]
            case '*.tar'
                tar xfv $argv[1]
            case '*.tbz2'
                tar xjfv $argv[1]
            case '*.tgz'
                tar xzfv $argv[1]
            case '*.zip'
                unzip $argv[1]
            case '*.Z'
                uncompress $argv[1]
            case '*.7z'
                7z $argv[1]
            case '*.deb'
                ar $argv[1]
            case '*.tar.xz'
                tar xfv $argv[1]
            case '*.tar.zst'
                tar xfv $argv[1]
            case '*'
                echo "'$argv[1]' cannot be extracted via ex"
        end
   else
       echo "'$argv[1]' is not a valid file"
   end
end

## To use !! and !$ in fish shell
# Functions needed for !! and !$
function __history_previous_command
  switch (commandline -t)
  case "!"
    commandline -t $history[1]; commandline -f repaint
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
if [ "$fish_key_bindings" = "fish_vi_key_bindings" ];
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

# Set the terminal title
function fish_title
    printf 'Fish Shell'
end

# function less
#     command less -R $argv
# end

# Move the given directory and ls the contents
function cd
 builtin cd $argv; and ll
end


# Run a fetch tool on startup
# paleofetch
 pfetch