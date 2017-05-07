#!/bin/bash

i=1;
echo "=== print file information ==="
echo "current directory : `pwd`"
echo -e "the number of elements :" `ls -l | grep ':' | wc -l` "\n"

func()
{
	echo [$((i++))] `basename $file`
        echo "----------------------INFORMATION-----------------------"
        if [ -f $file ]
        then echo -n [0m
        echo "file type :" `stat -c %F $file`
        elif [ -d $file ]
        then echo -n [34m
        echo "file type :" `stat -c %F $file`
        echo -n [0m
        else echo -n [32m
        echo "file type :" `stat -c %F $file`
        echo -n [0m
        fi
echo "file size :" `stat -c %s $file`
echo "last modifing time :" `stat -c %y $file`
echo "permission :" `stat -c %a $file`
echo "absolute path : `pwd $file`/$file"
echo "relative path : ./$file"
echo "--------------------------------------------------------"
}

in_func()
{
	echo "	[$((j++))] `basename $file`"
        echo "	----------------------INFORMATION-----------------------"
        if [ -f $file ]
        then echo -n [0m
        echo "	file type :" `stat -c %F $file`
        elif [ -d $file ]
        then echo 	-n [34m
        echo "	file type :" `stat -c %F $file`
        echo -n [0m
        else echo -n [32m
        echo "	file type :" `stat -c %F $file`
        echo -n [0m
        fi
echo "	file size :" `stat -c %s $file`
echo "	last modifing time :" `stat -c %y $file`
echo "	permission :" `stat -c %a $file`
echo "	absolute path : `pwd $file`/$file"
echo "	relative path : ./`pwd|cut -d '/' -f5`/$file"
echo "	--------------------------------------------------------"
}

for file in * 
do 
	j=1
	if [ -d $file ]
	then 
	func
	cd `basename $file`
	for file in *
	do
		if [ -d $file ]
		then
		in_func
		fi
	done
	
	for file in *
	do
		if [ -f $file ]
		then
		in_func
		fi
	done

	for file in *
	do
		if [ ! -d $file -a ! -f $file ]
		then
			if [ "$file" != "*" ]
			then
			in_func
			fi
		fi
	done
	cd ..
	fi
done

for file in *
do
	if [ -f $file ]
	then
	func
	fi
done

for file in *
do
	if [ ! -d $file -a ! -f $file ]
	then
	func
	fi
done
