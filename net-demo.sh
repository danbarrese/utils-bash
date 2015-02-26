#!/bin/bash
source "net.sh" || exit 1

function makeInt {
    net
    makeArray
    net $1
}

function makeArray {
    net
    local ar=()
    ar+=('hello')
    ar+=('my friend')
    net "${ar[@]}"
}

function f {
    net $1
}

function relay {
    net
    makeArray
    net "${net_makeArray[@]}"
}

makeArray
ar=("${net_makeArray[@]}")
[ ${#ar[@]} -eq 2 ] || exit 1
for (( i = 0; i < ${#ar[@]}; i++ )); do
    printf '%s\n' "$(($i+1)): ${ar[i]}"
done

printf '\n'
makeInt 42
[ $net_makeInt -eq 42 ] || exit 1
printf '%s\n' "42=$net_makeInt"

printf '\n'
f 10 && f 20 && f 30
[ $net_f == 30 ] || exit 1
printf '%s\n' "30=$net_f"

printf '\n'
relay
ar=("${net_relay[@]}")
[ ${#ar[@]} -eq 2 ] || exit 1
for (( i = 0; i < ${#ar[@]}; i++ )); do
    printf '%s\n' "$(($i+1)): ${ar[i]}"
done

