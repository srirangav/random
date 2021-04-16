/*
     random.c - a command line random number generator based on arc4random()

     Portions Copyright (c) 2011-2017, 2020-2021 Sriranga Veeraraghavan
     <ranga@calalum.org>. All rights reserved.

     Permission is hereby granted, free of charge, to any person
     obtaining a copy of this software and associated documentation
     files (the "Software"), to deal in the Software without
     restriction, including without limitation the rights to use, copy,
     modify, merge, publish, distribute, sublicense, and/or sell copies
     of the Software, and to permit persons to whom the Software is
     furnished to do so, subject to the following conditions:

     The above copyright notice and this permission notice shall be
     included in all copies or substantial portions of the Software.

     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
     MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
     BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
     ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
     CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
     SOFTWARE.
*/

/* includes */

#include <stdlib.h>
#include <stdio.h>
#include <errno.h>
#include <string.h>
#include <unistd.h>
#include <limits.h>
#include <stdarg.h>

/* constants */

static const char *gRandomStrErrNotPos = "Not a valid positive integer";
static const char *gRandomStrErrSame   = "Both integers are the same";

/* prototypes */

static void printUsage(char *cmd);
static int  getLong(char *str, unsigned long *num);
static u_int32_t uniform_arc4random(u_int32_t upper_bound);

/* functions */

/* print_usage - prints the usage message */

static void
printUsage (char *cmd)
{
    fprintf(stderr, "Usage: %s\n", cmd);
    fprintf(stderr, "       %s [num]\n", cmd);
    fprintf(stderr, "       %s [num1] [num2]\n", cmd);
}

/* get_int - get an int from the specified string */

static int
getLong (char *str, unsigned long *num)
{
    char *ep;

    if (str == NULL || num == NULL) {
        return 0;
    }

    *num = (unsigned long) strtoul(str, &ep, 0);

    if ((errno == EINVAL && *num == 0) ||
        !(str[0] != '\0' && *ep == '\0') ||
        errno == ERANGE) {
        return 0;
    }

    return 1;
}

/*
 * uniform_arc4random - calculate a uniformly distributed random number
 *                      less than upper_bound avoiding "modulo bias"
 *
 * Uniformity is achieved by generating new random numbers until the one
 * returned is outside the range [0, 2**32 % upper_bound).  This
 * guarantees the selected random number will be inside
 * [2**32 % upper_bound, 2**32) which maps back to [0, upper_bound)
 * after reduction modulo upper_bound.
 *
 * From: https://github.com/openssh/openssh-portable/blob/master/openbsd-compat/arc4random.c
 */

static u_int32_t
uniform_arc4random(u_int32_t upper_bound)
{
    u_int32_t r, min;

    if (upper_bound < 2)
        return 0;

    /* 2**32 % x == (2**32 - x) % x */
    min = -upper_bound % upper_bound;

    /*
     * This could theoretically loop forever but each retry has
     * p > 0.5 (worst case, usually far better) of selecting a
     * number inside the range we need, so it should rarely need
     * to re-roll.
     */
    for (;;) {
        r = arc4random();
        if (r >= min)
            break;
    }

    return r % upper_bound;
}

/* main */

int
main (int argc, char **argv)
{
    unsigned long val = 0, min = 0, max = ULONG_MAX;

    if (argc == 2) {

        /* only one argument */

        if (argv[1] == NULL ||
            argv[1][0] == '-' ||
            !getLong(argv[1], &val))
        {
            fprintf(stderr,
                    "Error: %s: '%s'\n",
                    gRandomStrErrNotPos,
                    argv[1]);
            printUsage(argv[0]);
            exit(1);
        }

        /* if the number is less than or equal to 0, treat it
           as the min value, otherwise treat it as the max value */

        if (val <= 0) {
            min = val;
        } else {
            max = val;
        }

    } else if (argc >= 3) {

        /* at least two arguments - treat it as a range */

        if (argv[1] == NULL ||
            argv[1][0] == '-' ||
            !getLong(argv[1], &min))
        {
            fprintf(stderr,
                    "Error: %s: '%s'\n",
                    gRandomStrErrNotPos,
                    argv[1]);
            printUsage(argv[0]);
            exit(1);
        }

        if (argv[2] == NULL ||
            argv[2][0] == '-' ||
            !getLong(argv[2], &max))
        {
            fprintf(stderr,
                    "Error: %s: '%s'\n",
                    gRandomStrErrNotPos,
                    argv[2]);
            printUsage(argv[0]);
            exit(1);
        }

        if (min == max)
        {
            fprintf(stderr,
                    "Error: %s: '%s'\n",
                    gRandomStrErrSame,
                    argv[1]);
            exit(1);
        }

    }

    /* swap min & max if min is greater than max */

    if (min > max) {
        val = min;
        min = max;
        max = val;
    }

    /* keep max under ULONG_MAX */

    if (max == ULONG_MAX) {
        max--;
    }

    val = uniform_arc4random((u_int32_t)(max - min + 1)) + min;

    fprintf(stdout, "%lu\n", val);

    exit(0);
}
