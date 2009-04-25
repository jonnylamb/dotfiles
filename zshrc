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
# Command aliases
#

# IRC
alias irc="ssh -v -t jonnylamb@jonnylamb.com 'screen -ax'"
alias email="ssh -t -X jonny@geminiani 'mutt'"

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
#alias v="vim"
#alias sv="sudo vim"
alias v="emacs -nw"
alias e="emacs -nw"
alias sv="sudo emacs -nw"
alias se="sudo emacs -nw"

# Helpers: VCSs
alias svn-clean="svn status | grep \"^?\" | cut -c8- | xargs -l1 rm -rf"
alias gd="git diff"
alias gcsm="git commit -s -m"
alias pc="moap changelog prepare"
alias ddu="darcs diff -u | most"
alias dra="darcs record -a"
alias gis="git --no-pager status"
alias ds="darcs whatsnew -sl"
alias gdc="git diff --cached"
alias gc="git commit -sv"
alias gca="git commit -sva"
alias gco="git checkout"

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
#alias m="PATH=/usr/bin:$PATH make CC=icecc -j6"
alias j="jobs"

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
export EDITOR="emacs -nw"
export LESS="-cgiFKx4M"
export PAGER="most"
export PATH="$HOME/bin/:$PATH"

#
# Functions
#

# empathy
srcempathy () {
    EMPATHY_SRCDIR=. EMPATHY_DEBUG=all libtool --mode=execute gdb --args ./src/empathy --g-fatal-warnings
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

coll () {
	[ -z $1 ] && { echo "E: enter project name"; return 1; }

	case $1 in
		empathy|emp)
			cd ~/src/empathy
			;;
		nautilus-sendto|nautilus)
			cd ~/src/nautilus-sendto
			;;
		*)
			cd ~/src/telepathy-$1
			;;
	esac
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

	cd $(mktemp -p $cdt_dir -td cdt.XXXXXXXX);
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

# pkg-maemo tools
pkg-maemo() {
	[ -z $1 ] && { echo "Usage: pkg-maemo {push|branch|pull|merge} branchname"; return 1; }
	[ -z $2 ] && { echo "Usage: pkg-maemo {push|branch|pull|merge} branchname"; return 1; }

	name=$2
	
	case $1 in
		push)
			bzr push bzr+ssh://jonny@alioth.debian.org/srv/bzr.debian.org/bzr/pkg-maemo/$name/debian/
			;;
		branch)
			bzr branch bzr+ssh://jonny@alioth.debian.org/srv/bzr.debian.org/bzr/pkg-maemo/$name/debian/
			;;

		pull)
			bzr pull bzr+ssh://jonny@alioth.debian.org/srv/bzr.debian.org/bzr/pkg-maemo/$name/debian/
			;;
		merge)
			bzr merge --remember http://bazaar.launchpad.net/~vcs-imports/$name/trunk
			;;
	esac
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
