#
# Completion
#
whoami=$(whoami)
zstyle :compinstall filename "/home/$whoami/.zshrc"

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
	ref=$(git-symbolic-ref HEAD 2> /dev/null) || return
	ref=${ref#refs/heads/}
	RPROMPT=" %{$reset_color$fg_bold[grey]%}${ref}%{$reset_color%} %(?..%?)"
}

if [ $UID -eq 0 ]; then
	PROMPT="%{$reset_color$fg_bold[red]%}%n@%B%M%b:%~%# "
elif echo $whoami | grep -E "^(jonnylamb|jonny|d71x3w|jdl)$" 2>&1 > /dev/null; then
	PROMPT="%B%M%b:%~%# "
else
	PROMPT="%{$reset_color$fg_bold[red]%}%n@%B%M%b:%~%# "
fi

#
# Command aliases
#

# IRC
alias irc="ssh -v -t jonnylamb@jonnylamb.com 'screen -ax'"
alias email="ssh -v -t jonny@geminiani 'mutt'"

# Typos
alias :q="exit"
alias EXIT="exit"
alias sl="ls"
alias no="ls" # ls in qwerty when the keys are dvorak
alias Grep="grep"
alias cd..="cd .."
alias v-="vim -"

# Helpers: APT
alias sagi="sudo apt-get install"
alias sagr="sudo apt-get remove"
alias sagu="sudo apt-get update"
alias acs="apt-cache search"
alias acsh="apt-cache show"
alias afs="apt-file search -x"
alias acp="apt-cache policy"

# Helpers: Editors
alias v="vim"
alias sv="sudo vim"

# Helpers: VCSs
alias svn-clean="svn status | grep \"^?\" | cut -c8- | xargs -l1 rm -rf"
alias gd="git diff"
alias gcsm="git commit -s -m"
alias pc="moap changelog prepare"
alias ddu="darcs diff -u | most"
alias dra="darcs record -a"
alias gis="git --no-pager status"
alias ds="darcs whatsnew -sl"

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
alias m="PATH=/usr/bin:$PATH make CC=icecc -j6"
alias j="jobs"

# A bit ugly
alias srcempathy="EMPATHY_SRCDIR=. EMPATHY_DEBUG=all LD_LIBRARY_PATH=$(pwd)/libempathy/.libs:$(pwd)/libempathy-gtk/.libs gdb --args ./src/.libs/empathy --g-fatal-warnings"
alias srcsalut="SALUT_DEBUG=all GIBBER_DEBUG=all SALUT_PERSIST=1 gdb src/telepathy-salut"

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
export EDITOR="vim"
export LESS="-cgiFKx4M"
export PAGER="most"
export PATH="$HOME/bin/:$PATH"

#
# Functions
#

# git
git () {
	if [ -z "$GIT_AUTHOR_EMAIL" ] && [ $1 = "commit" ]; then

		one_email=$DEBEMAIL
		two_email="jonny.lamb@collabora.co.uk"
		three_email="jonnylamb@jonnylamb.com"
		four_email="j.d.lamb@durham.ac.uk"

		echo "Which email address do you want to use?"
		echo " 1. $one_email (default)"
		echo " 2. $two_email"
		echo " 3. $three_email"
		echo " 4. $four_email"
		echo " 5. other"
		read number

		case $number in
			"")
				email=$one_email
				;;
			1)
				email=$one_email
				;;
			2)
				email=$two_email
				;;
			3)
				email=$three_email
				;;
			4)
				email=$four_email
				;;
			5)
				echo "Enter the email address you want to use:"
				read email
				;;
		esac

		export GIT_AUTHOR_EMAIL=$email
		export GIT_COMMITTER_EMAIL=$email
	fi

	/usr/bin/git $@
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
	wget -OCOPYING http://www.gnu.org/licenses/gpl.txt
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
	chmod +x /tmp/$1.git/hooks/post-update
	touch /tmp/$1.git/git-daemon-export-ok
	
	vim /tmp/$1.git/description

	if [ "$2" = "upload" ]; then
		echo "Will upload to jonnylamb.com now.."
		scp -r /tmp/$1.git jonnylamb@jonnylamb.com:git/
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

#
# Package building from git.jonnylamb.com
#

bp() {
	# EPIC HACK
	$HOME/bin/bp $@
	cd $(cat /tmp/.packagedir)
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
