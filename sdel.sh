#!/bin/bash

mkdir -p ~/TRASH

for arg in "$@"
do
    if [ $(file -b --mime-type $arg) != "application/gzip" ]
    then
        $(gzip $arg)
        mv $arg.gz ~/TRASH
    else
        mv $arg ~/TRASH
    fi
done

