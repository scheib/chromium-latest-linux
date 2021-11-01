#!/bin/sh

BASEDIR="$(dirname $(realpath $(readlink -f $0)))"

$BASEDIR/update.sh && $BASEDIR/run.sh
