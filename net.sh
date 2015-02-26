#!/bin/bash

# This works similar to a "return" statement in other programming languages.
# Calling this function from another function will store the given parameters
# into a variable whose name is the name of the calling function.  For example:
# a method named "save" is called, which calls this function like "net true".
# The value of "true" is then stored into a variable named "save".
#
# TO RETURN A VALUE:
# function makeNum {
#     net 42
# }
#
# TO GET THE "RETURNED" VALUE:
# i=("${net_makeNum}")
#
# Every function that uses net should initially call net with no parameters.
# This will ensure that a function that is called twice that finishes the first
# time and does NOT finish the second time will not return a value from a
# previous call.  Example:
# function anyFunctionInTheWorld {
#     net      # Erases return value in case of failure.
#     # ...do lots of work...
#     # ...if any of the work fails, function returns ''...
#     net 42   # Sets return value.
# }
#
# Calling this function with no arguments will "return" a blank value. {{{
#
# DATE: February 25, 2015
# AUTHOR: Dan Barrese }}}
function net {
    local return_var_name="net_${FUNCNAME[1]}"
    eval "$return_var_name=()"
    [ $# -eq 0 ] && return 0
    local val=
    for val in "$@"; do
        eval $return_var_name'+=("$val")'
    done
}

