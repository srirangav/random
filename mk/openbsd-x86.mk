# bsd-x86_64.mk - rules and variables to build on MacOSX/Darwin x86_64 
# (10.7+), FreeBSD, and OpenBSD

# based on:
# https://developers.redhat.com/blog/2018/03/21/compiler-and-linker-flags-gcc/
# https://caiorss.github.io/C-Cpp-Notes/compiler-flags-options.html
# https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html
# https://airbus-seclab.github.io/c-compiler-security/clang_compilation.html

CFLAGS = -O2 -W -Wall -Wextra -Wpedantic -Werror -Walloca \
         -Wconversion -Wformat=2 -Wformat-security \
         -Wnull-dereference -Wstack-protector -Wstrict-overflow=3 \
         -Wvla -Wimplicit-fallthrough -Wswitch-enum \
         -Wbad-function-cast -Wfloat-equal \
         -Wpointer-arith -Wmissing-declarations -Wshadow \
         -Wmissing-prototypes -Wcast-align -Wunused -Wpointer-arith \
         -Wno-missing-braces -Wformat-nonliteral -Wformat-y2k \
         -Werror=implicit-function-declaration \
         -pedantic -pedantic-errors \
         -D_FORTIFY_SOURCE=2 -D_GLIBCXX_ASSERTIONS \
         -fasynchronous-unwind-tables -fpic -fPIE \
         -fstack-protector-all -fno-sanitize-recover=all -fwrapv \
         -fstack-protector-strong -Wold-style-cast \
         -Warray-bounds-pointer-arithmetic \
         -Wconditional-uninitialized \
         -Wloop-analysis -Wshift-sign-overflow \
         -Wtautological-constant-in-range-compare \
         -Wassign-enum -Wformat-type-confusion \
         -Widiomatic-parentheses -Wunreachable-code-aggressive
EXTRA_CFLAGS = -fcf-protection=full -flto
LIBS = 
