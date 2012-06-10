#! /bin/bash

if [ $# -lt 1 ] ; then
	echo Missing Exectuable Name!
	echo usage: makefiler.sh executable_name
	echo usage: makefiler.sh executable_name
fi

execName=$1

echo -n $execName > Makefile
echo -n " : " >> Makefile
shift

for var in *.cpp ; do
	echo -n "${var%cpp}o " >> Makefile
done

echo -e -n "\n\tg++ -ansi -Wall -g -o $execName $* "  >> Makefile

for var in *.cpp ; do
	echo -n "${var%cpp}o " >> Makefile
done

echo >> Makefile

	for var in *.cpp ; do

		echo -e -n "\n${var%cpp}o : $var " >> Makefile
		awk ' /#include "/ { printf("%s ", $2) }' $var | sed s/\"//g >> Makefile
		echo -e -n "\n\t g++ -ansi -Wall -g -c $* $var" >> Makefile
		echo >> Makefile

	done

echo -e -n "\nclean : " >> Makefile
echo -e -n "\n\t rm -f $execName " >>Makefile

for var in *.cpp ; do
	echo -n "${var%cpp}o " >> Makefile
done

echo >> Makefile
