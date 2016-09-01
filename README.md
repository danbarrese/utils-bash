BASH Utilities
==============

The examples here assume you have the scripts on the classpath as executables
without the ".sh" extension.

## net
Simulates return-like syntax in BASH.

## xproduct
Cross product of multiple arrays.
Example:
```
$ xproduct "a b" "X Y Z"
a_X
b_X
a_Y
b_Y
a_Z
b_Z
```

## trim
Trivial example showing how to process the stdout of another process.
Example:
```
$ printf '%s\n' ' a ' |trim
a
$ ar=(' a ' ' b ')
$ printf '%s\n' ${ar[@]} |trim
a
b
```
