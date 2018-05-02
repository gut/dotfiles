FILES = $$(find -maxdepth 1 \
	| grep -v git$$ \
	| grep -v gitignore \
	| grep -v gitmodules \
	| grep -v Makefile \
	| grep -v ^\.$$ \
	| sed -e 's/^\.\///')
ORIGIN = $(PWD)

all:
	git submodule update --init
	for file in $(FILES); do cd ~/; ln -snf $(ORIGIN)/$$file ~/$$file; done
