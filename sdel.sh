#!/bin/bash

script=$(readlink -f "$0")
if ! crontab -l | grep -q "sdel.sh"
then
    (crontab -l 2>/dev/null; echo "* 9,21 * * * \"$script\"") | crontab -
fi

current_time=$(date +%s)

mkdir -p ~/TRASH

if [ "$(ls -A ~/TRASH)" ]
then
    for file in ~/TRASH/*.gz
    do
        file_time=$(date -r $file +%s)
        if (( file_time < ( current_time - ( 60 * 60 * 24 * 2 ) ) ))
        then
            rm $file
        fi
     done
fi

for arg in "$@"
do
    if [ $(file -b --mime-type $arg) != "application/gzip" ]
    then
        $(tar -zcf $arg.tar.gz $arg)
        rm -r $arg
        mv $arg.tar.gz ~/TRASH
    else
        mv $arg ~/TRASH
    fi
done
