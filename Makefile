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
execs:

install: ## Install arch linux packages
	$(PKGINSTALL) --needed - < $(BASE)/ArchLinux/pacmanlist
	sudo pkgfile --update

aur: ## Install arch linux AUR packages using yay
	yay -S --needed - < $(BASE)/ArchLinux/aurlist

backup: ## Backup arch linux packages
	$(BASE)/Scripts/backupPackage
