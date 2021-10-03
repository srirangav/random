# Makefile for random

PREFIX = /usr/local
PGM_SRCS = random.c
PGM_OBJS = $(PGM_SRCS:.c=.o)
PGM = random
PGM_REL = 0.2.5
PGM_MAN = $(PGM).1
PGM_BINDIR = $(DESTDIR)$(PREFIX)/bin
PGM_MANDIR = $(DESTDIR)$(PREFIX)/man/man1
PGM_FILES = $(PGM_SRCS) $(PGM_MAN) Makefile README.txt LICENSE.txt
CC = cc

include platform.mk

.c.o:
	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -c $<

all: $(PGM)

$(PGM): $(PGM_OBJS)
	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -o $(PGM) $(PGM_OBJS) $(LIBS) 

distclean: clean
	/bin/rm -f platform.mk
    
clean:
	/bin/rm -f *.o *~ core .DS_Store $(PGM) $(PGM).1.txt *.tgz

tgz: clean
	[ ! -d $(PGM)-$(PGM_REL) ] && mkdir $(PGM)-$(PGM_REL)
	cp $(PGM_FILES) $(PGM)-$(PGM_REL)
	tar -cvf $(PGM)-$(PGM_REL).tar $(PGM)-$(PGM_REL)
	gzip $(PGM)-$(PGM_REL).tar
	mv -f $(PGM)-$(PGM_REL).tar.gz $(PGM)-$(PGM_REL).tgz
	/bin/rm -rf $(PGM)-$(PGM_REL)

$(PGM).1.txt:
	nroff -man $(PGM).1 | col -b > $(PGM).1.txt

# install and uninstall rules
# from: http://nuclear.mutantstargoat.com/articles/make/#writing-install-uninstall-rules

.PHONY: install
install: $(PGM)
	mkdir -p $(PGM_BINDIR) $(PGM_MANDIR)
	cp $(PGM) $(PGM_BINDIR)/$(PGM)
	cp $(PGM_MAN) $(PGM_MANDIR)/$(PGM_MAN)

.PHONY: uninstall
uninstall:
	rm $(PGM_BINDIR)/$(PGM) $(PGM_MANDIR)/$(PGM_MAN)
