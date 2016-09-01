#!/bin/bash
# Name: trim
# Description: Trims whitespace around string.  Example script showing how to
#   capture stdin from another process.
# Author: Dan Barrese (danbarrese.com)
# Date: August 12, 2016

stdin=
if [ -t 0 ]; then
    if [ $# -gt 0 ]; then
        stdin=$@
    fi
else
    # how to preserve color?
    stdin=$(cat "-")
fi

trimmed="$(echo -e "${stdin}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"
printf '%s\n' "${trimmed}"

