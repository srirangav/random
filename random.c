/*
     random.c - a command line random number generator based on arc4random()

     Copyright (c) 2011-2017, 2020 Sriranga Veeraraghavan <sriranga@berkeley.edu>

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
#include <inttypes.h>
#include <string.h>
#include <unistd.h>
#include <limits.h>
#include <stdarg.h>

/* prototypes */

static int get_int (char *str, intmax_t *num);
static int print_error (const char *fmt, ...);
static void print_usage (char *cmd);

/* functions */

/* print_error - prints a formatted error message */

static int
print_error (const char *fmt, ...)
{
    int rc;
    va_list ap;
    
    if ((rc = fprintf(stderr, "ERROR: ")) > 0) {
        va_start(ap, fmt);
        rc = vfprintf(stderr, fmt, ap);
        va_end(ap);
    }
    
    return rc;
}

/* print_usage - prints the usage message */

static void
print_usage (char *cmd)
{
    fprintf(stderr, "Usage: %s\n", cmd);
    fprintf(stderr, "       %s [num]\n", cmd);
    fprintf(stderr, "       %s [num1] [num2]\n", cmd);
}

/* get_int - get an int from the specified string */

static int
get_int (char *str, intmax_t *num)
{
    char *ep;
    
    if (str == NULL || num == NULL) {
        return 0;
    }
    
    *num = (intmax_t) strtoimax(str, &ep, 0);
    
    if ((errno == EINVAL && *num == 0) ||
        !(str[0] != '\0' && *ep == '\0') ||
        (errno == ERANGE && *num == INTMAX_MAX)) {
        return 0;
    }

    return 1;
}

/* main */

int
main (int argc, char **argv)
{
    intmax_t val = 0, min = 0, max = INTMAX_MAX;
    
    if (argc == 2) {

        /* only one argument */

        if (!get_int(argv[1],&val)) {
            print_error("Not a valid number: '%s'\n", argv[1]);
            print_usage(argv[0]);
            exit(1);
        }

        /* if the number is less than 0, treat it as the min value,
           otherwise treat it as the max value */
        
        if (val <= 0) {
            min = val;
        } else {
            max = val;
        }
        
    } else if (argc >= 3) {

        /* at least two arguments - treat it as a range */

        if (!get_int(argv[1],&min)) {
            print_error("Not a valid number: '%s'\n", argv[1]);
            print_usage(argv[0]);
            exit(1);
        }

        if (!get_int(argv[2],&max)) {
            print_error("Not a valid number: '%s'\n", argv[2]);
            print_usage(argv[0]);
            exit(1);
        }
        
    }

    /* swap min & max if min is greater than max */

    if (min > max) {
        val = min;
        min = max;
        max = val;
    }

    /* keep max under INTMAX */

    if (max == INTMAX_MAX) {
	max--;
    }

    /* use arc4random_uniform(3) instead of % to avoid modulo bias */
	
    val = arc4random_uniform(max - min + 1) + min;

    fprintf(stdout,"%ji\n", val);

    exit(0);
}

