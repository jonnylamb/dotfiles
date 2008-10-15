all:
	cp -f screenrc ~/.screenrc
	cp -f zshrc ~/.zshrc
	cp -f vimrc ~/.vimrc
	cp -f gitconfig ~/.gitconfig
	[ -d ~/.config/awesome ] || mkdir -p ~/.config/awesome
	cp -rf awesome ~/.config
	cp -f signature ~/.signature

update:
	git pull origin master
