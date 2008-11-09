none:
	echo "temporarily disabled as symlinks are muuuch nicer"

all: screen zsh vim git ssh
mail: signature mutt offlineimap mailplate

screen:
	cp -f screenrc ~/.screenrc

zsh:
	cp -f zshrc ~/.zshrc

vim:
	cp -f vimrc ~/.vimrc

git:
	cp -f gitconfig ~/.gitconfig

awesome:
	if [ -d ~/.config/awesome ]; then
	    cp -rf awesome/* ~/.config/awesome/
	else
	    mkdir -p ~/.config/awesome
	fi

signature:
	cp -f signature ~/.signature

mutt:
	mkdir -p ~/.var/mutt/header_cache
	if [ -d ~/.mutt ]; then
	    cp -rf mutt/* ~/.mutt/
	else
	   cp -rf mutt ~/.mutt
	fi

offlineimap:
	mkdir -p ~/.var/offlineimap
	cp -f offlineimaprc ~/.offlineimaprc
	if [ -d ~/.offlineimap ]; then
	    cp -rf offlineimap/* ~/.offlineimap/
	else
	    cp -rf offlineimap ~/.offlineimap
	fi

mailplate:
	if [ -d ~/.mailplate ]; then
	     cp -f mailplate/config ~/.mailplate/config
	     if [ -d ~/.mailplate/templates ]; then
	         cp -rf mailplate/templates/* ~/.mailplate/templates/
	     else
	         cp -rf mailplate/templates ~/.mailplate/
	     fi
	else
	    cp -rf mailplate ~/.mailplate
	fi

ssh:
	[ -d ~/.ssh ] || mkdir -p ~/.ssh
	cp -f ssh/config ~/.ssh/config

update:
	git pull origin master
