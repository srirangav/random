README
------

random v0.2.2
By Sriranga Veeraraghavan <sriranga@berkeley.edu>

random is a simple command line program for generating random integers.
random relies on arc4random(3).

When run without any arguments, random returns a random integer between
0 and INTMAX_MAX.

If random is provided a single argument and that argument is a positive
integer random retruns a random integer between 0 and the specified
integer.  If the single argument is a negative integer, random returns a
random integer between the specified integer and INTMAX_MAX.

If random is provide two or more arguments, random will return a random
integer in the range between the first two arguments.

History:

v0.2.2 - use arc4random_uniform(3) instead of arc4random with %
v0.2.1 - update gcc flags
v0.2.0 - initial GitHub release

