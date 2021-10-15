README
------

random v0.2.7
By Sriranga Veeraraghavan <ranga@calalum.org>

random is a simple command line program for generating random integer.
random relies on arc4random(3).

Usage:

    random [num1] [num2]

    When run without any arguments, random prints out a random integer 
    between 0 and ULONG_MAX.

    When a single argument is provided, if that argument is a valid 
    positive integer below ULONG_MAX, random prints out a random integer 
    between 0 and the specified integer.  If the argument is 0, random 
    prints out a random integer between 0 and ULONG_MAX.

    If two or more arguments are provided, and the first two arguments 
    are valid positive integers below ULONG_MAX, random prints out a 
    random integer between the first two arguments.

Build:

    $ ./configure
    $ make 

Install:

    $ ./configure
    $ make
    $ make install

    By default, random is installed in /usr/local.  To install in a
    different location the installation PREFIX can be supplied to
    make as follows:

    $ make install PREFIX="<prefix>"

    For example, the following will install random in /opt/local:

    $ make PREFIX=/opt/local install

    A DESTDIR can also be specified for staging purposes (with or
    without an alternate prefix):

    $ make DESTDIR="<destdir>" [PREFIX="<prefix>"] install

Dependencies:

    On Linux, libbsd is required because arc4random is not 
    available on Linux by default - configure will check for 
    libbsd, but will not install it.

    On Debian-based systems, libbsd may be installed as follows:

    $ sudo apt-get install libbsd-dev

    On Fedora-based systems, libbsd may be installed as follows:

    $ sudo dnf install libbsd-devel

    See: https://stackoverflow.com/questions/19671152/

History:

    v0.2.7 - switch to autoconf
    v0.2.6 - modularize Makefile for multiple platforms, add support
             for FreeBSD, OpenBSD
    v0.2.5 - add install/uninstall rules to Makefile, add support for
             removing commas in supplied numbers
    v0.2.4 - use OpenSSH portable arc4random_uniform to support older
             MacOSX versions (10.6 and earlier); add support for Linux
             (Debian 10, Ubuntu 20.10)
    v0.2.3 - changes to build with additional warnings on Apple M1
    v0.2.2 - use arc4random_uniform(3) instead of arc4random with %
    v0.2.1 - update gcc flags
    v0.2.0 - initial GitHub release

Platforms:

    random has been tested on Debian 10.x (arm) and 11.x (arm),
    OpenBSD 6.9 (x86_64), FreeBSD 13 (x86_64), and MacOS 10.6+

License:

    See LICENSE.txt

