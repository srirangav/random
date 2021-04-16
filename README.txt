README
------

random v0.2.3
By Sriranga Veeraraghavan <ranga@calalum.org>

random is a simple command line program for generating random integer.
random relies on arc4random(3).

Usage:

    random
    random [num]
    random [num1] [num2]

    When run without any arguments, random prints out a random integer between
    0 and ULONG_MAX.

    When a single argument is provided, if that argument is a valid positive
    integer below ULONG_MAX, random prints out a random integer between 0 and
    the specified integer.  If the argument is 0, random prints out a random
    integer between 0 and ULONG_MAX.

    If two or more arguments are provided, and the first two arguments are valid
    positive integers below ULONG_MAX, random prints out a random integer between
    the first two arguments.

History:

    v0.2.4 - use OpenSSH portable arc4random_uniform to support older
             MacOSX versions (10.6 and earlier)
    v0.2.3 - changes to build with additional warnings on Apple M1
    v0.2.2 - use arc4random_uniform(3) instead of arc4random with %
    v0.2.1 - update gcc flags
    v0.2.0 - initial GitHub release

License:

    See LICENSE.txt
