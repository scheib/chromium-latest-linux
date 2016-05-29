#! /bin/bash

BASEDIR=$(dirname $0)

export CHROME_DEVEL_SANDBOX=$BASEDIR/latest/chrome_sandbox

# Uncomment these lines to get rid of API Keys missing warning
#export GOOGLE_API_KEY="no"
#export GOOGLE_DEFAULT_CLIENT_ID="no"
#export GOOGLE_DEFAULT_CLIENT_SECRET="no"

# Use this if you want separate profile location
$BASEDIR/latest/chrome --user-data-dir="$BASEDIR/user-data-dir" $* &> /dev/null &

# Use this if you want to use standard profile location
# $BASEDIR/latest/chrome-wrapper $* &> /dev/null &
