###############################################################
## AUTHOR Name: Boyang Yan                                   ##
## KEYWORDs: DotFiles Management                             ##
## PURPOSE: Management package and Dot configureation        ##
## ENVIRONment: mac, Linux                                   ##
## COMMENTs:                                                 ##
## Last Modified Date: 25.09.2021                            ##
###############################################################

# Automatic configuration setup
# Inspired by Gavin Freeborn's example:
# https://www.youtube.com/watch?v=aP8eggU2CaU

BASE = $(PWD)
MKDIR = mkdir -p
LN = ln -vsf
SLN = sudo ln -vsf
LNDIR = ln -vs
PKGINSTALL = sudo pacman --noconfirm -S

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
	| sort \
	| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

init: ## deploy dotfiles
	$(BASE)/Scripts/init
	$(SLN) $(PWD)/profile/profile /etc/profile

execs:
	$(MKDIR) $(HOME)/.local/bin/
	$(LN) $(PWD)/Scripts/welcomemessage $(HOME)/.local/bin/welcomemessage
	$(LN) $(PWD)/xorg/.xprofile $(HOME)/.xprofile
	$(LN) $(PWD)/xorg/.xinitrc $(HOME)/.xinitrc
	$(LN) $(PWD)/sound/.asoundrc $(HOME)/.asoundrc
	$(LN) $(PWD)/dwmblocks/sb-clock $(HOME)/.local/bin/sb-clock
	$(LN) $(PWD)/dwmblocks/sb-battery $(HOME)/.local/bin/sb-battery
	$(LN) $(PWD)/dwmblocks/sb-cpu $(HOME)/.local/bin/sb-cpu
	$(LN) $(PWD)/dwmblocks/sb-memory $(HOME)/.local/bin/sb-memory
	$(LN) $(PWD)/dwmblocks/sb-volume $(HOME)/.local/bin/sb-volume
	$(LN) $(PWD)/dwmblocks/sb-internet $(HOME)/.local/bin/sb-internet
	$(SLN) $(PWD)/dwmblocks/sb-cpu /usr/local/bin/sb-cpu
	$(LN) $(PWD)/Scripts/screenshot $(HOME)/.local/bin/screenshot
	$(LN) $(PWD)/alacritty/alacritty.yml $(HOME)/.alacritty.yml

basePackages: ## Install Arch Linux base packages
	$(PKGINSTALL) --needed - < $(BASE)/ArchLinux/base/basePacmanList
	sudo pkgfile --update
	yay -S --needed - < $(BASE)/ArchLinux/base/baseAurList

emacsPackages: ## Install Emacs with dependents
	$(PKGINSTALL) --needed - < $(BASE)/ArchLinux/emacs/emacsPacmanlist
	sudo pkgfile --update
	yay -S --needed - < $(BASE)/ArchLinux/emacs/emacsAurlist

pythonPackages: ## Install Python
	sudo pkgfile --update
	yay -S --needed - < $(BASE)/ArchLinux/python/pythonAurlist
	
multimediaPackages: ## Install multimedia Packages
	$(PKGINSTALL) --needed - < $(BASE)/ArchLinux/multimedia/pacmanList
	sudo pkgfile --update
	yay -S --needed - < $(BASE)/ArchLinux/multimedia/aurList

cloudVirtualPackages: ## Install cloud and virtual environment related packages
	$(PKGINSTALL) --needed - < $(BASE)/ArchLinux/cloudVirtual/pacmanList
	sudo pkgfile --update

backupPackages: ## Backup arch linux packages
	$(BASE)/Scripts/backupPackage
