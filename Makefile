all: screen zsh vim git

screen:
	cp -f screenrc ~/.screenrc

zsh:
	cp -f zshrc ~/.zshrc

vim:
	cp -f vimrc ~/.vimrc

git:
	cp -f gitconfig ~/.gitconfig

awesome:
	[ -d ~/.config/awesome ] || mkdir -p ~/.config/awesome
	cp -rf awesome ~/.config

mail:
	cp -f signature ~/.signature

ssh:
	[ -d ~/.ssh ] || mkdir -p ~/.ssh
	cp -f ssh/config ~/.ssh/config

update:
	git pull origin master
