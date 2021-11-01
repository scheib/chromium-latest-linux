#!/bin/sh

BASEDIR="$(dirname $(realpath $(readlink -f $0)))"

$BASEDIR/latest/chrome --user-data-dir="$BASEDIR/user-data-dir" $* &> /dev/null &
