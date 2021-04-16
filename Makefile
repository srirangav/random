# Makefile for random

PGM_SRCS = random.c
PGM_OBJS = $(PGM_SRCS:.c=.o)
PGM = random
PGM_REL = 0.2.3
PGM_FILES = $(PGM_SRCS) $(PGM).1 Makefile README.txt LICENSE.txt

CC = cc
UNAME = /usr/bin/uname

# CFLAGS, based on:
# https://developers.redhat.com/blog/2018/03/21/compiler-and-linker-flags-gcc/
# https://caiorss.github.io/C-Cpp-Notes/compiler-flags-options.html
# https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html

CFLAGS       =  -O2 -W -Wall -Wextra -Wshadow -Wcast-qual -Wmissing-declarations \
                -Wmissing-prototypes -Wconversion -Wcast-align -Wunused \
                -Wshadow -Wold-style-cast -Wpointer-arith -Wno-missing-braces \
                -Wformat-nonliteral -Wformat-security -Wformat-y2k \
                -Werror -Werror=implicit-function-declaration \
                -pedantic -pedantic-errors \
                -D_FORTIFY_SOURCE=2 -D_GLIBCXX_ASSERTIONS \
                -fasynchronous-unwind-tables -fpic \
                -fstack-protector-all -fstack-protector-strong -fwrapv
CFLAGS_x86_64 = -fcf-protection

.c.o:
	MACH_TYPE="`$(UNAME) -m`" && \
    case x"$$MACH_TYPE" in \
        x"amd64"|x"x86_64") \
            $(CC) $(CFLAGS) $(CFLAGS_x86_64) -c $< ;; \
        *)  $(CC) $(CFLAGS) -c $< ;; \
    esac

all: $(PGM)

$(PGM): $(PGM_OBJS)
	MACH_TYPE="`$(UNAME) -m`" && \
    case x"$$MACH_TYPE" in \
        x"amd64"|x"x86_64") \
            $(CC) $(CFLAGS) $(CFLAGS_x86_64) -o $(PGM) $(PGM_OBJS) ;; \
        *)  $(CC) $(CFLAGS) -o $(PGM) $(PGM_OBJS) ;; \
    esac

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
