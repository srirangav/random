dnl -*- Autoconf -*-
dnl Process this file with autoconf to produce a configure script.

AC_INIT([random],[0.2.7],[ranga@calalum.org])

# We want to turn on warnings if we are using gcc and the user did 
# not specify CFLAGS. The autoconf check for the C compiler sets the
# CFLAGS if gcc is used, so we will save it before we run that check.

save_CFLAGS="$CFLAGS"

# Checks for programs.

AC_PROG_CC
AC_PROG_INSTALL

CFLAGS="$save_CFLAGS $CFLAGS"

AC_CONFIG_SRCDIR([random.c])

# Check basic types.

AC_C_CONST
# AC_TYPE_INT8_T
# AC_TYPE_INT16_T
# AC_TYPE_INT32_T
# AC_TYPE_INT64_T

# Some systems need the u_intX_t types defined across.

# AC_CHECK_TYPE([u_int8_t], [], [
#   AC_TYPE_UINT8_T
#   AC_DEFINE(u_int8_t, [uint8_t], [Define a type for 8-bit unsigned
#                                   integers.])
# ])
# 
# AC_CHECK_TYPE([u_int16_t], [], [
#   AC_TYPE_UINT16_T
#   AC_DEFINE(u_int16_t, [uint16_t], [Define a type for 16-bit unsigned
#                                     integers.])
# ])

AC_CHECK_TYPE([u_int32_t], [], [
  AC_TYPE_UINT32_T
  AC_DEFINE(u_int32_t, [uint32_t], [Define a type for 32-bit unsigned
                                    integers.])
])

# AC_CHECK_TYPE([u_int64_t], [], [
#   AC_TYPE_UINT64_T
#   AC_DEFINE(u_int64_t, [uint64_t], [Define a type for 64-bit unsigned
#                                     integers.])
# ])

# search for arc4random, which is in libbsd on linux

AC_SEARCH_LIBS([arc4random], [bsd], [], [
                AC_MSG_ERROR([arc4random() is required])
])

# search for arc4random_uniform, which is in libbsd on linux

AC_SEARCH_LIBS([arc4random_uniform], [bsd], [], [
                CFLAGS="$CFLAGS -DNEED_UNIFORM_ARC4RANDOM"])

dnl TEST_AND_SET_CFLAG(flag, [program])
dnl
dnl This attempts to compile a program with a certain compiler flag.
dnl If no program is given, then the minimal C++ program is compiled, and 
dnl this tests just the validity of the compiler flag. 
dnl
dnl based on: https://github.com/edrosten/autoconf_tutorial

define([TEST_AND_SET_CFLAG],[
    AC_MSG_CHECKING([if compiler flag $1 works])    
    
    dnl Store the current CXXFLAGS
    save_CFLAGS="$CFLAGS"

    dnl Append the flag of interest

    CFLAGS="$CFLAGS $1"
    
    dnl Create an M4 macro, "prog", which expands to a C program.
    dnl This should either be a default one or the one specified.
    dnl Note that macros are not local, but there is a stack so push
    dnl the definition on to the stack to prevent clobbering a definition
    dnl that might already exist.

    m4_if([$2],[],[pushdef(prog, [int main(){}])], [pushdef(prog, [$2])])
    
    flag_test=0
    
    dnl See if the compiler runs
    
    AC_COMPILE_IFELSE([AC_LANG_SOURCE([prog])], [flag_test=1],[flag_test=0])
    
    dnl De-clobber the "prog" macro
    
    popdef([prog])

    if test $flag_test = 1
    then
        AC_MSG_RESULT(yes)
    else
        AC_MSG_RESULT(no)
        dnl The flag doesn't work, so restore the old CFLAGS
        CFLAGS="$save_CFLAGS"
    fi
])

# test and set compiler flags

TEST_AND_SET_CFLAG(-W)
TEST_AND_SET_CFLAG(-Wall)
TEST_AND_SET_CFLAG(-Wextra)
TEST_AND_SET_CFLAG(-Wpedantic) 
TEST_AND_SET_CFLAG(-Werror) 
TEST_AND_SET_CFLAG(-Walloca)
TEST_AND_SET_CFLAG(-Wconversion) 
TEST_AND_SET_CFLAG(-Wformat=2) 
TEST_AND_SET_CFLAG(-Wformat-security)
TEST_AND_SET_CFLAG(-Wformat-nonliteral)
TEST_AND_SET_CFLAG(-Wformat-y2k)
TEST_AND_SET_CFLAG(-Wformat-type-confusion)
TEST_AND_SET_CFLAG(-Wnull-dereference)
TEST_AND_SET_CFLAG(-Wstack-protector)
TEST_AND_SET_CFLAG(-Wstrict-overflow=3)
TEST_AND_SET_CFLAG(-Wvla) 
TEST_AND_SET_CFLAG(-Wimplicit-fallthrough)
TEST_AND_SET_CFLAG(-Wswitch-enum)
TEST_AND_SET_CFLAG(-Wbad-function-cast)
TEST_AND_SET_CFLAG(-Wfloat-equal)
TEST_AND_SET_CFLAG(-Wpointer-arith)
TEST_AND_SET_CFLAG(-Wmissing-declarations)
TEST_AND_SET_CFLAG(-Wmissing-prototypes)
TEST_AND_SET_CFLAG(-Wshadow)
TEST_AND_SET_CFLAG(-Wcast-align)
TEST_AND_SET_CFLAG(-Wunused)
TEST_AND_SET_CFLAG(-Wpointer-arith)
TEST_AND_SET_CFLAG(-Wno-missing-braces)
TEST_AND_SET_CFLAG(-Werror=implicit-function-declaration)
TEST_AND_SET_CFLAG(-Wold-style-cast)
TEST_AND_SET_CFLAG(-Warray-bounds-pointer-arithmetic)
TEST_AND_SET_CFLAG(-Wconditional-uninitialized)
TEST_AND_SET_CFLAG(-Wloop-analysis)
TEST_AND_SET_CFLAG(-Wshift-sign-overflow)
TEST_AND_SET_CFLAG(-Wtautological-constant-in-range-compare)
TEST_AND_SET_CFLAG(-Wassign-enum)
TEST_AND_SET_CFLAG(-Widiomatic-parentheses) 
TEST_AND_SET_CFLAG(-Wunreachable-code-aggressive)
TEST_AND_SET_CFLAG(-pedantic)
TEST_AND_SET_CFLAG(-pedantic-errors)
TEST_AND_SET_CFLAG(-D_FORTIFY_SOURCE=2)
TEST_AND_SET_CFLAG(-D_GLIBCXX_ASSERTIONS)
TEST_AND_SET_CFLAG(-fasynchronous-unwind-tables)
TEST_AND_SET_CFLAG(-fpic)
TEST_AND_SET_CFLAG(-fPIE)
TEST_AND_SET_CFLAG(-fstack-protector-all) 
TEST_AND_SET_CFLAG(-fstack-protector-strong)
TEST_AND_SET_CFLAG(-fno-sanitize-recover)
TEST_AND_SET_CFLAG(-fno-sanitize-recover=all)
TEST_AND_SET_CFLAG(-fwrapv)
TEST_AND_SET_CFLAG(-fcf-protection=full)
TEST_AND_SET_CFLAG(-fsanitize=memory)
TEST_AND_SET_CFLAG(-fsanitize=cfi)
TEST_AND_SET_CFLAG(-fsanitize=safe-stack)
TEST_AND_SET_CFLAG(-flto)

dnl Process Makefile.in to create Makefile
AC_CONFIG_FILES([Makefile])
AC_OUTPUT
