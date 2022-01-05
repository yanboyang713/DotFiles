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
	$(LN) $(PWD)/profile/.xprofile $(HOME)/.xprofile
	$(LN) $(PWD)/sound/.asoundrc $(HOME)/.asoundrc
	$(LN) $(PWD)/dwmblocks/sb-clock $(HOME)/.local/bin/sb-clock
	$(LN) $(PWD)/dwmblocks/sb-battery $(HOME)/.local/bin/sb-battery
	$(LN) $(PWD)/dwmblocks/sb-cpu $(HOME)/.local/bin/sb-cpu
	$(LN) $(PWD)/dwmblocks/sb-memory $(HOME)/.local/bin/sb-memory
	$(LN) $(PWD)/dwmblocks/sb-volume $(HOME)/.local/bin/sb-volume
	$(LN) $(PWD)/dwmblocks/sb-internet $(HOME)/.local/bin/sb-internet
	$(SLN) $(PWD)/dwmblocks/sb-cpu /usr/local/bin/sb-cpu
	$(LN) $(PWD)/Scripts/screenshot $(HOME)/.local/bin/screenshot

install: ## Install arch linux packages
	$(PKGINSTALL) --needed - < $(BASE)/ArchLinux/pacmanlist
	sudo pkgfile --update

aur: ## Install arch linux AUR packages using yay
	yay -S --needed - < $(BASE)/ArchLinux/aurlist

backup: ## Backup arch linux packages
	$(BASE)/Scripts/backupPackage
