#!/bin/bash
# Name: xproduct
# Description: Cross product of arrays.
# Author: Dan Barrese
# Date: August 25, 2016

# For each variable starting with "prefix", execute the "fun" function. #>>
# ARGS:
#   prefix: The prefix of all the variables to iterate over.
#   fun: The name of the function to call for each variable.
# DATE: August 31, 2016
# #<<
function foreach {
    local prefix=$1
    local fn=$2
    shift 2
    local ar=
    for ar in $(compgen -A variable |egrep "^${prefix}.+"); do
        ar="${ar}[@]" # arrays0[@]
        ar=(${!ar}) # (a b)
        eval "${fn} ${ar[@]}"
    done
}

function sum_solutions {
    ((solutions=solutions * ${#@}))
}

function build_combination {
    local idx=$((i/j % ${#ar[@]}))
    combination+="${ar[${idx}]}${output_delim}"
    ((j=j * ${#ar[@]}))
}

# Performs a cross product of multiple arrays. #>>
# ARGS:
#   prefix: The prefix of all the variables which represent the array of
#       arrays.  For example, if your 2D array is stored in several variables
#       named "ar0", "ar1", "ar2", then the prefix should be "ar".
# DATE: August 31, 2016
# #<<
function cross_product {
    local solutions=1
    local i=
    foreach $1 sum_solutions

    for (( i = 0; i < ${solutions}; i++ )); do
        local j=1;
        local combination=
        foreach $1 build_combination
        printf '%s\n' "${combination%${output_delim}}"
    done
}

output_delim="_"
while getopts "o:" n; do
    case ${n} in
        o)
            output_delim="${OPTARG}"
            shift 2
            ;;
    esac
done

i=0
for group in "${@}"; do
    eval "cprodarrays$((i++))=(${group[@]})"
done

cross_product cprodarrays
exit

