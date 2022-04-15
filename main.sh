#!/bin/bash

# bash strict mode
set -Eeuo pipefail
# debug mode
# set -x

function __error_handing__(){
    local last_status_code=$1;
    local error_line_number=$2;
    echo 1>&2 "Error - exited with status $last_status_code at line $error_line_number";
    perl -slne 'if($.+5 >= $ln && $.-4 <= $ln){ $_="$. $_"; s/$ln/">" x length($ln)/eg; s/^\D+.*?$/\e[1;31m$&\e[0m/g;  print}' -- -ln=$error_line_number $0
}

last_error_line_number=-1;
function __debug_handing__(){
    # why > 1
    # because EXIT code line number is 1
    # so the last line number should be overwritten by EXIT trap function call 
    if [[ $2 > 1 ]]; then
        last_error_line_number=$2
    fi
    local last_status_code=$1;
    local error_line_number=$2

    # We do not need any printing here, because EXIT trap will do that and the end
    # perl -slne 'if($.==$ln){ print "DEBUG $. $_"}' -- -ln=$error_line_number $0
}

function __exit_handing__(){
    perl -slne 'if($.+5 >= $ln && $.-4 <= $ln){ $_="$. $_"; s/$ln/">" x length($ln)/eg; s/^\D+.*?$/\e[1;33m$&\e[0m/g; print}' -- -ln=$last_error_line_number $0
}

trap  '__error_handing__ $? $LINENO' ERR

for arg in ${*}; do
    if [[ $arg == '__debug__' ]]; then
        trap '__debug_handing__ $? $LINENO' DEBUG
        trap '__exit_handing__' EXIT
    fi
done

for arg in ${*}; do
    if [[ $arg == '__verbose__' ]]; then
        set -v;
    fi
done
