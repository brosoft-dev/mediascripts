#!/bin/bash

RENAMELIST=/tmp/renamelist

echo "Namefix by KB <dev@brosoft.com.au>"
echo "Will scan current directory (./) for movie folders like:"
echo "  A.movie.title.2010.mkv.720p.grouptag"
echo "and..."
echo "  A Title almost perfect 2010"
echo "And will show you what it would rename it as:"
echo "  A Movie Title (2010)"
echo "  A Title Almost Perfect (2010)"
echo "No action is performed unless specific arguments are given."
echo "(safe to run as '$0')"
echo -n "Proceed [Yn]?"
read CONTINUE

if [ "${CONTINUE}x" == "x" ]; then
	echo
elif [ "${CONTINUE}x" == "yx" ]; then
	echo
elif [ "${CONTINUE}x" == "Yx" ]; then
	echo
else
	echo "Cancelled"
	exit 0
fi

ls -1 | egrep -v '^.*\([1-2][09][0-9][0-9]\)$' > $RENAMELIST

while read f; do
	n=`echo "$f" | sed 's/1080//'`
	n=`echo "$n" | sed 's/(/ /g;s/)/ /g;s/\./ /g'`
	n=`echo "$n" | sed 's/\(^.*\)\([1-2][90][0-9][0-9]\).*$/\1(\2)/g'`
	n=`echo "$n" | sed 's/  / /g'`
	n=`echo "$n" | sed 's/  / /g'`
	n=`echo "$n" | sed -e 's/\b\(.\)/\u\1/g'`

	if [ "x$f" = "x$n" ]; then
		echo -n "."
	else
		echo
		echo "->" $f
		if [ -f "$f" ]; then
			echo "FILE (IGNORED)"
		elif [ "$1x" == "DOITx" ]; then
			mv "$f" "$n"
			echo "MOVE> $n"
		else
			echo "ECHO> $n"
		fi
	fi
done <$RENAMELIST

if [ "$1x" != "DOITx" ]; then
	echo
	echo
	echo "Now run this again like:"
	echo "  $0 DOIT"
	echo "To actually rename the files."
fi
