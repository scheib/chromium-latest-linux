#! /bin/bash
cd $(dirname $0)
./update.sh $1 && ./run.sh
