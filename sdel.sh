#!/bin/bash

current_time=$(date +%s)

mkdir -p ~/TRASH

for file in ~/TRASH/*.gz
do
    file_time=$(date -r $file +%s)
    if (( file_time < ( current_time - ( 60 * 1 ) ) ))
    then
        rm $file
    fi
done

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

