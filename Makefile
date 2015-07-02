#------------------------------------------------------------------------------#
#                        Makefile for Cometsong rcfiles!                       #
#------------------------------------------------------------------------------#

# Vars for customization
SRCDIR := $(PWD)
DESTDIR := $(HOME)
MYALIAS = '../my_aliases'


all: init normals gits hg
normals: rcfiles bins myaliases
gits: git-init submodules
hg: mercurials 

RCFILES = rcprofile $(SHFILES) $(LANGFILES) $(OTHERFILES)
SHFILES = $(ZSHFILES) $(BASHFILES)
ZSHFILES = zshrc
BASHFILES = bash_profile bashrc bash_completion bash_completion_alias
LANGFILES = inputrc perltidyrc pythonrc.py pylintrc Rprofile
OTHERFILES = toprc inputrc screenrc tmux.conf osx

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


#clean: remove_links

#remove_links:
#	cd $(DESTDIR)
#	@rm -rf $(RCFILES) $(GITFILES)
