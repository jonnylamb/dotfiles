# -*- sh -*-

#
# Completion
#
whoami=$(whoami)
zstyle :compinstall filename "/home/$whoami/.zshrc"

#
# Title
#

title() {
    case $TERM in
	screen*)
            # Use these two for GNU Screen:
            # status line
	    print -nR $'\033k'$*$'\033'\\\

	    # title bar
	    print -nR $'\033]0;'$*$'\a'
	    ;;
	*xterm*|*rxvt*)
	    # Use this one instead for XTerms:
	    print -nR $'\033]0;'$*$'\a'
	    ;;
    esac
}

#
# Prompt
#
autoload colors && colors

precmd() {
    RPROMPT="%(?..%?)"
    if ! stat "$(pwd)" >/dev/null 2>&1; then
	if ! cd "$(pwd)" >/dev/null 2>&1; then
	    echo "W: cwd does not exist anymore"
	    return
	fi
    fi

    ref=""
    ref=$(git symbolic-ref HEAD 2> /dev/null) || return
    ref=${ref#refs/heads/}
    RPROMPT=" %{$reset_color$fg_bold[grey]%}${ref}%{$reset_color%} %(?..%?)"

    title $(print -P '%~')
}

if [ -r "/etc/debian_chroot" ]; then
    local debian_chroot=$(cat /etc/debian_chroot)
    DEBIAN_CHROOT="${debian_chroot:+/%S$debian_chroot%s}"
else
    DEBIAN_CHROOT=""
fi

if [ ! $UID -eq 0 ] && echo $whoami | grep -E "^(jonnylamb|jonny|d71x3w|jdl)$" 2>&1 > /dev/null; then
    PROMPT="%B%M%b${DEBIAN_CHROOT}:%~%# "
else
    PROMPT="$reset_color$fg_bold[red]%}%n@%B%M%b${DEBIAN_CHROOT}:%~%# "
fi

preexec() {
    emulate -L zsh
    local -a cmd; cmd=(${(z)1})
    title $cmd[1]:t "$cmd[2,-1]"
}

#
# Editor: should probably be done early
#
if [ -f "/home/jonny/bin/ec" ]; then
    export EDITOR="/home/jonny/bin/ec"
else
    export EDITOR="emacs -nw"
fi

#
# Command aliases
#

# IRC
alias irc="ssh -v -t byte 'screen -ax'"
alias email="ssh -t -X geminiani 'bin/email'"

# Typos
alias :q="exit"
alias EXIT="exit"
alias sl="ls"
alias no="ls" # ls in qwerty when the keys are dvorak
alias Grep="grep"
alias cd..="cd .."

# Helpers: APT
alias sagi="sudo apt-get install"
alias sagr="sudo apt-get remove"
alias sagu="sudo apt-get update"
alias acs="apt-cache search"
alias acsh="apt-cache show"
alias afs="apt-file search -x"
alias acp="apt-cache policy"

# Helpers: Editors
alias e="$EDITOR"
alias se="sudo emacs -nw"

# Helpers: vcs
alias svn-clean="svn status | grep \"^?\" | cut -c8- | xargs -l1 rm -rf"
alias pc="moap changelog prepare"

# Helpers: git
alias gd="git diff"
alias gis="git --no-pager status"
alias gdc="git diff --cached"
alias gc="git commit -sv"
alias gca="git commit -sva"
alias gco="git checkout"
alias gcb="git checkout -b"
alias gcm="git checkout master"
alias gl="git log"
alias ga="git add"

# Helpers: Misc.
alias mcp="moap changelog prepare"
alias s="sudo"
alias ls="ls --color"
alias l="ls"
alias ll="ls -lh"
alias la="ls -lha"
alias diff="diff -Nruad"
alias tf="tail -f"
alias stf="sudo tail -f"
alias sup="sudo ifup"
alias mutt="PATH=$PATH:/usr/lib/mutt mutt"
alias MAKE="make"
alias m="make"
alias mc="make check"
#alias m="PATH=/usr/bin:$PATH make CC=icecc -j6"
alias j="jobs"
alias d="debcommit"
alias da="debcommit -a"
alias vg='G_SLICE=always-malloc G_DEBUG=gc-friendly valgrind --tool=memcheck --leak-check=full --leak-resolution=high --num-callers=20'
alias fn="find -name"

# Global aliases.
alias -g ...="../.."
alias -g ....="../../.."

#
# Exports
#
export REAL_NAME="Jonny Lamb"
export DEBFULLNAME="Jonny Lamb"
export EMAIL_ADDRESS="jonny@debian.org"
export DEBEMAIL="jonny@debian.org"
export LESS="-cgiFKx4M"
export PATH="$HOME/bin/:$PATH:/usr/local/android/tools"

# Some sucky systems don't have awesome pagers.
if which most 2>&1 > /dev/null; then
    export PAGER="most"
else
    export PAGER="more"
fi

#
# Functions
#

# Telepathy under gdb
g () {
    project=$(basename `pwd`)
    GABBLE_DEBUG=all SALUT_DEBUG=all EMPATHY_DEBUG=all HAZE_DEBUG=all \
	GABBLE_PERSIST=1 SALUT_PERSIST=1 HAZE_PERSIST=1  EMPATHY_SRCDIR=. \
	libtool --mode=execute gdb -q --args ./src/$project --g-fatal-warnings
}

# git
git () {
    if [ ! -z "$GIT_JONNY_EMAIL_BASEDIR" ] && ! echo $(pwd) | grep "$GIT_JONNY_EMAIL_BASEDIR" 2>&1 > /dev/null; then
	export GIT_AUTHOR_EMAIL=
	export GIT_COMMITTER_EMAIL=
	export GIT_JONNY_EMAIL_BASEDIR=
    fi

    if [ -z "$GIT_AUTHOR_EMAIL" ] && echo $1 | grep -E "^(commit|merge|rebase|am)$" 2>&1 > /dev/null; then
	one_email=$DEBEMAIL
	two_email="jonny.lamb@collabora.co.uk"
	three_email="jonnylamb@jonnylamb.com"
	four_email="j.d.lamb@durham.ac.uk"

	echo "Which email address do you want to use?"
	echo " 1. $one_email (default)"
	echo " 2. $two_email"
	echo " 3. $three_email"
	echo " 4. $four_email"
	echo "or enter the address you want to use."
	read number

	case $number in
	    "") email=$one_email;;
	    1) email=$one_email;;
	    2) email=$two_email;;
	    3) email=$three_email;;
	    4) email=$four_email;;
	    *) email=$number;;
	esac

	export GIT_AUTHOR_EMAIL=$email
	export GIT_COMMITTER_EMAIL=$email
	export GIT_JONNY_EMAIL_BASEDIR=$(pwd)
    fi

    /usr/bin/git $@
}

src () {
    [ -z $1 ] && { echo "E: enter project name"; return 1; }

    [ "$1" = "emp" ] && { 1=empathy; }

    if [ -d ~/src/telepathy-$1 ]; then
	dir=~/src/telepathy-$1
    else
	dir=~/src/$1
    fi

    if [ -d $dir ]; then
	cd $dir
    else
	echo "E: No directory: $dir"
    fi
}

b () {
    ref=$1
    if [ -z $1 ]; then
        ref=$(git symbolic-ref HEAD 2> /dev/null) || { echo "E: couldn't detect branch"; return 1; }
        ref=${ref#refs/heads/}
    fi

    repo=$(basename `pwd`)
    echo "http://git.collabora.co.uk/?p=user/jonny/$repo.git;a=shortlog;h=refs/heads/$ref"
    gnome-open "http://git.collabora.co.uk/?p=user/jonny/$repo.git;a=shortlog;h=refs/heads/$ref"
}

# offlineimap wrapper
oi () {
    if [ "$HOST" = "geminiani" ]; then
	offlineimap $@
    else
	ssh geminiani offlineimap $@
    fi
}

# Move to new temp dir
cdt () {
    cdt_dir=/tmp/
    if [ -n "$CDT_PATH" ]; then
	cdt_dir=$CDT_PATH
    fi

    cd $(mktemp -p $cdt_dir -td cdt.XXXXXX);
    echo "Moved to $(pwd)"
}

# Create a new project including nice files and a Git repo.
newproject() {
    git init
    cp /usr/share/common-licenses/LGPL-2.1 COPYING
    for FILE in ChangeLog README TODO HACKING; do touch $FILE; done
    # We can use GIT_AUTHOR_EMAIL because the email address will be asked on git init.
    echo "$DEBFULLNAME <$GIT_AUTHOR_EMAIL>" > AUTHORS
    git add *
    git commit -s -m "Initial project creation."
    echo "Start coding now!"
}

# Create a new bare Git repo, and perhaps upload it to git.jonnylamb.com
git-bare() {
    [ -d .git ] || { echo "$0: Use inside a current Git repository"; return 1; }
    [ -z $1 ] && { echo "$0: Specify a git repo name"; return 1; }
    [ -e /tmp/$1.git ] && { echo "$0: /tmp/$1.git already exists"; return 1; }
	
    git clone --bare . /tmp/$1.git
    git --bare --git-dir=/tmp/$1.git update-server-info
    git --bare --git-dir=/tmp/$1.git gc
    mv /tmp/$1.git/hooks/post-update{.sample,}
    chmod +x /tmp/$1.git/hooks/post-update
    touch /tmp/$1.git/git-daemon-export-ok
	
    sensible-editor /tmp/$1.git/description

    if [ "$2" = "upload" ]; then
	echo "Will upload to jonnylamb.com now.."

	if grep -i "packag" /tmp/$1.git/description; then
	    scp -r /tmp/$1.git jonnylamb@jonnylamb.com:git/packaging/
	else
	    scp -r /tmp/$1.git jonnylamb@jonnylamb.com:git/
	fi
	rm -rf /tmp/$1.git
    else
	echo "Repository is at /tmp/$1.git"
    fi
}

# Upload a file to my toast public_html/misc/
stoast() {
    scp -C $@ jdl@compsoc.dur.ac.uk:public_html/misc/ && echo "\nhttp://jdl.ducs.org.uk/misc/$(basename $1)"
}

sdhansak() {
    scp -C $@ jonny@dhansak.collabora.co.uk:public_html/ && echo "\nhttp://people.collabora.co.uk/~jonny/$(basename $1)"
}

# Remove a file from my toast public_html/misc/
rmtoast() {
    ssh jdl@compsoc.dur.ac.uk "rm public_html/misc/$1" && echo "jdl@compsoc.dur.ac.uk:public_html/misc/$1 deleted."
}

# Generate Packages and Sources
genpackages() {
    dpkg-scanpackages . /dev/null | tee Packages | gzip -9 > Packages.gz
    dpkg-scansources . /dev/null | tee Sources | gzip -9 > Sources.gz
}

re() {
    source ~/.zshrc
}

cmk() {
    [ -z "$1" ] && { echo "fatal: select directory name"; exit 1 }
    mkdir $1 && cd $1
}

fne() {
    if [ -z "$1" ]; then
        find
    else
        find -name "*.$1"
    fi
}

tfn() {
    [ -z "$1" ] && { echo "fatal: select file name"; exit 1 }
    prevwd="$(pwd)"
    cd /tmp/
    ans=$(find -name "$1")
    l=$(echo $ans | wc -l)

    # sigh
    [ "$ans" = "" ] && l=0

    case $l in
        0)
            echo "No matches found."
            cd "$prevwd"
            ;;
        1)
            cd `dirname $ans`
            ;;
        *)
            echo $ans
            cd $prevwd
            ;;
    esac
}

# lazy
x() {
    [ -z "$1" ] && { echo "fatal: specify file name"; exit 1 }
    [ -r "$1" ] || { echo "fatal: not a regular file"; exit 1 }

    case $1 in
        *.tar.bz2) tar jxf $1 ;;
        *.tar.gz) tar zxf $1 ;;
        *.rar) unrar e $1 ;;
        *.bz2) bzip2 -d $1 ;;
        *.gz) gunzip -d $1 ;;
        *.zip) unzip $1 ;;
        *) echo "fatal: unknown file type" ;;
    esac
}


#
# Misc.
#

# Disable mail notification
unset mailpath MAILCHECK

setopt appendhistory autocd extendedglob nomatch notify

autoload -Uz compinit
unsetopt beep

echo $HOST | grep -E "^vega[0-9]$" 2>&1 > /dev/null || compinit;

zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*:(all-|)files' ignored-patterns '(|*/)*.(pyc|o|lo|egg-info|class)'

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

#
# Machine-specific stuff
#
case $HOST in
    vega*)
	export http_proxy="http://wwwcache.dur.ac.uk:8080"
	;;
    compsoc*)
	export http_proxy="http://wwwcache.dur.ac.uk:8080"
	# This is just silly. sudo reports are there for a reason.
	alias sudo="/usr/bin/sudo"
	;;
esac
