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
UNAME = /usr/bin/uname
GREP = /usr/bin/grep
SWVERS = /usr/bin/sw_vers

# CFLAGS, based on:
# https://developers.redhat.com/blog/2018/03/21/compiler-and-linker-flags-gcc/
# https://caiorss.github.io/C-Cpp-Notes/compiler-flags-options.html
# https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html
# https://airbus-seclab.github.io/c-compiler-security/clang_compilation.html

CFLAGS = -O2 -W -Wall -Wextra -Wpedantic -Werror -Walloca \
         -Wconversion -Wformat=2 -Wformat-security \
         -Wnull-dereference -Wstack-protector -Wstrict-overflow=3 \
         -Wvla -Warray-bounds-pointer-arithmetic \
         -Wimplicit-fallthrough -Wconditional-uninitialized \
         -Wloop-analysis -Wshift-sign-overflow -Wswitch-enum \
         -Wtautological-constant-in-range-compare \
         -Wassign-enum -Wbad-function-cast -Wfloat-equal \
         -Wformat-type-confusion -Wpointer-arith \
         -Widiomatic-parentheses -Wunreachable-code-aggressive \
         -Wmissing-declarations -Wshadow -Wmissing-prototypes \
         -Wcast-align -Wunused -Wpointer-arith -Wno-missing-braces \
         -Wformat-nonliteral -Wformat-y2k \
         -Werror=implicit-function-declaration \
         -pedantic -pedantic-errors \
         -D_FORTIFY_SOURCE=2 -D_GLIBCXX_ASSERTIONS \
         -fasynchronous-unwind-tables -fpic -fPIE \
         -fstack-protector-all -fno-sanitize-recover -fwrapv
CFLAGS_CLANG = -fstack-protector-strong -Wold-style-cast
CFLAGS_CLANG_x86_64 = -fcf-protection=full -fsanitize=memory \
                      -fsanitize=cfi -fsanitize=safe-stack

.c.o:
	MACH_TYPE="`$(UNAME) -m`" && \
    CLANG="NO" && \
    if $(CC) -v 2>&1 | $(GREP) -i clang 2>&1 > /dev/null ; then \
       CLANG="YES" ; \
    fi && \
    case x"$$MACH_TYPE" in \
        x"amd64"|x"x86_64") \
            if [ X"$$CLANG" = X"YES" ] ; then \
               $(CC) $(CFLAGS) \
                     $(CFLAGS_CLANG) $(CFLAGS_CLANG_x86_64) -c $< ; \
            else \
               $(CC) $(CFLAGS) $(CFLAGS_x86_64) -c $< ; \
            fi ;; \
        *)  $(CC) $(CFLAGS) -c $< ;; \
    esac

all: $(PGM)

$(PGM): $(PGM_OBJS)
	MACH_TYPE="`$(UNAME) -m`" && \
    CLANG="NO" && \
    if $(CC) -v 2>&1 | $(GREP) -i clang 2>&1 > /dev/null ; then \
       CLANG="YES" ; \
    fi && \
    case x"$$MACH_TYPE" in \
        x"amd64"|x"x86_64") \
            if [ X"$$CLANG" = X"YES" ] ; then \
               $(CC) $(CFLAGS) \
                     $(CFLAGS_CLANG) $(CFLAGS_CLANG_x86_64) \
                     -o $(PGM) $(PGM_OBJS) ; \
            else \
               $(CC) $(CFLAGS) $(CFLAGS_x86_64) -o $(PGM) $(PGM_OBJS) ; \
            fi ;; \
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