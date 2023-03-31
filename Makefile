#------------------------------------------------------------------------------#
#                        Makefile for Cometsong rcfiles!                       #
#------------------------------------------------------------------------------#

# Vars for customization
SRCDIR := $(PWD)
DESTDIR := $(HOME)
MYALIAS = '../my_aliases'

# OS check for file link locations:
uname_S := $(shell sh -c 'uname -s 2>/dev/null || echo not')
ifeq ($(uname_S),Darwin)
	# TODO: for future use of diff config file locations on osx
	DESTCFG := $(HOME)/Library/
endif


all: init normals configs gits hg
normals: rcfiles bins myaliases
gits: git-init submodules
hg: mercurials 

RCFILES = rcprofile $(BASHFILES) $(LANGFILES) $(OTHERFILES)
BASHFILES = bash_profile bashrc bash_completion bash_completion.d bashit.sh
LANGFILES = inputrc perltidyrc pythonrc.py pylintrc Rprofile
OTHERFILES = toprc inputrc screenrc tmux.conf osx ctags npmrc my.cnf starship.toml
CONFIGFILES = yamllint pip.conf

GITFILES = gitconfig gitignore_global git_template_global
HGFILES = hgrc hgignore
BINFILES=$(shell ls -1 $(SRCDIR)/bin)


# Usage: links,file-dir-names,filepath,linkpath,dot
#	1=file-dir-names, 2=srcpath, 3=destpath, 4=dot-or-not
define links
	$(foreach FILE,$(1),\
		if [ -e $(3)/$(4)$(FILE) ]; then \
			rm -rf $(3)/$(4)$(FILE); \
		fi; \
		ln -sf $(2)/$(FILE) $(3)/$(4)$(FILE); \
		echo "    Link to $(FILE) .... $(3)/$(4)$(FILE)"; \
	)
endef

init:
	@echo Create file defining var RCPATH for config scripts to read
	@echo "RCPATH=$(SRCDIR)" > $(DESTDIR)/.rcpath_env
	#
	@echo Setting up 'bash-it'
	# Only install $BASH_IT if it's not already setup
	if [ -z "${BASH_IT}" ]; then
	  source $RCPATH/bashit_setup.sh
	fi


rcfiles:
	@echo Link all rcfiles
	@$(call links,$(RCFILES),$(SRCDIR),$(DESTDIR),.)

myaliases:
	@echo Link to your my_aliases file
	@ln -sf $(MYALIAS) ./my_aliases

bins:
	@echo Link all files in bin
	@if [ ! -d $(DESTDIR)/bin ]; then mkdir -p $(DESTDIR)/bin; fi
	@$(call links,$(BINFILES),$(SRCDIR)/bin,$(DESTDIR)/bin)

mercurials:
	@echo Link all hg files
	@$(call links,$(HGFILES),$(SRCDIR),$(DESTDIR),.)

git-init:
	@echo Source git user setup
	@$(source $(SRCDIR)/git_user.sh )
	@echo Link all git files
	@$(call links,$(GITFILES),$(SRCDIR),$(DESTDIR),.)

submodules:
	@echo Git submodule init and update
	@git submodule init
	@git submodule update

configs:
	@echo Link files into .config folder
	@if [ ! -d $(DESTDIR)/.config ]; then mkdir -p $(DESTDIR)/.config; fi
	#
	@echo ...yamllint
	@if [ ! -d $(DESTDIR)/.config/yamllint ]; then mkdir -p $(DESTDIR)/.config/yamllint; fi
	@ln -svf $(SRCDIR)/yamllint $(DESTDIR)/.config/yamllint/config
	#
	@echo ...pip.conf
	@if [ ! -d $(DESTDIR)/.config/pip ]; then mkdir -p $(DESTDIR)/.config/pip; fi
	@ln -svf $(SRCDIR)/pip.conf $(DESTDIR)/.config/pip/pip.conf


#clean: remove_links

#remove_links:
#	cd $(DESTDIR)
#	@rm -rf $(RCFILES) $(GITFILES)
