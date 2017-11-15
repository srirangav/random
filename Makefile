# Makefile for random
# $Id: Makefile 8 2005-06-18 05:40:25Z ranga $

PGM_SRCS = random.c
PGM_OBJS = $(PGM_SRCS:.c=.o)
PGM = random
PGM_REL = 0.2.0
PGM_FILES = $(PGM_SRCS) $(PGM).1 Makefile README.txt LICENSE.txt

CC = gcc
CFLAGS = -g -O2 -Wall -Wshadow -Wpointer-arith -Wcast-qual \
         -Wmissing-declarations -Wmissing-prototypes -W

.c.o:
	$(CC) $(CFLAGS) -c $<

all: $(PGM)

$(PGM): $(PGM_OBJS)
	$(CC) $(CFLAGS) -o $(PGM) $(PGM_OBJS)

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

install:
	@echo "Please do the following:"
	@echo
	@echo "mkdir -p ~/bin ~/man/man1"
	@echo "cp $(PGM) ~/bin"
	@echo "cp $(PGM).1 ~/man/man1"
	@echo
	@echo "Add ~/bin to PATH and ~/man to MANPATH"

