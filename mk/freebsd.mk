# freebsd.mk - variables to build on FreeBSD

# based on:
# https://developers.redhat.com/blog/2018/03/21/compiler-and-linker-flags-gcc/
# https://caiorss.github.io/C-Cpp-Notes/compiler-flags-options.html
# https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html
# https://airbus-seclab.github.io/c-compiler-security/clang_compilation.html

EXTRA_CFLAGS = -fstack-protector-strong -Wold-style-cast \
               -Warray-bounds-pointer-arithmetic \
               -Wconditional-uninitialized \
               -Wloop-analysis -Wshift-sign-overflow \
               -Wtautological-constant-in-range-compare \
               -Wassign-enum -Wformat-type-confusion \
               -Widiomatic-parentheses -Wunreachable-code-aggressive
LIBS = 
