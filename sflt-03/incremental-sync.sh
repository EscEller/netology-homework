#!/bin/bash

exec 2>> /dev/null

path="/tmp/backup/"
del=0

if [ ! -e $path ]; then
	mkdir $path
fi

for i in $(seq 5 -1 1);
do
if [ ! -e $path$i ] && [ ! -e $path"1+" ] || [[ ! -e $path$i  &&  -e $path"5+" ]]; then 
	bnum=$i
	del="$i+"
elif [ ! -e $path$(($i+1)) ] && [ $(($i+1)) < 6 ] && [  ! -e $path"1+" ] || [[ ! -e $path$(($i+1))  &&  -e $path"5+" ]]; then 
	bnum=$(($i+1))
	del="$(($i+1))+"
elif [ ! -e $path"5+" ] && [ -e $path"5" ]; then
	if [ ! -e "$path$i+" ]; then 
		bnum="$i+"
		del=$i
	elif [ ! -e $path$(($i+1)) ] && [ $(($i+1)) < 6 ]; then 
		bnum="$(($i+1))+"
		del=$(($i+1))
	fi
fi
done


if [ ! -e "$path$bnum" ]; then 
	rsync -a -c /home/kuzubov/ $path$bnum
	rm -rf $path$del
	echo "Sync completed"
	ls $path
else
	echo "Full backup already exists"
	ls $path
fi
