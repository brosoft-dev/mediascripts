#!/bin/bash

FLATTENLIST=`mktemp`.flatten
FILELIST=`mktemp`.flatten.files

echo "There is no safeguard here, to proceed"
echo "is to allow this script to perform the"
echo "following:"
echo "1. Scan from the current directory (./) for 2nd-tier folders"
echo "     eg: Not ./dir1, but will match ./dir1/subdir2 and ./dir1/subdir2/sub10"
echo "2. Find all files that exist within those 2nd-tier folders and move them"
echo "     to the base folder. eg: move ./dir1/subdir2/file.txt -> ./dir1/file.txt"
echo "3. Will ask you if the destination exists as a file (overwrite, skip)"
echo "4. Will rename if the destination exists as a directory and exit."
echo "     eg: ./dir1/conflictname -> ./dir1/conflictname.dir"
echo
echo "Continue [yN]?"
read CONTINUE

if [ "${CONTINUE}x" == "yx" ]; then
	echo "Proceeding..."
elif [ "${CONTINUE}x" == "Yx" ]; then
	echo "Proceeding..."
else
	echo "Cancelled."
	exit 0
fi

find . -maxdepth 2 -mindepth 2 -type d > $FLATTENLIST

while read d
do
	BASE=`echo "$d" | sed 's/^\(\.\/\)\([^\/]\+\).*$/\1\2\//p' | head -n 1`
	find "$d" -type f > $FILELIST
	while read f
	do
		NAME=`basename "$f"`
		if [ -d "$BASE$NAME" ]; then
			echo "CONFLICT -> DIR"
			mv "$BASE$NAME" "$BASE$NAME.dir"
			echo "'$BASE$NAME' and '$f'"
			echo "Renamed '$BASE$NAME' to '$BASE$NAME.dir' but need to restart."
			exit 0
		elif [ -f "$BASE$NAME" ]; then
			echo "CONFLICT -> FILE"
			echo "'$BASE$NAME' and '$f'"

			echo -n "Overwrite [Yn]? "
			read OVERWRITE </dev/tty

			if [ "${OVERWRITE}x" == "x" ]; then
				PROCEED=1
			elif [ "${OVERWRITE}x" == "yx" ]; then
				PROCEED=1
			elif [ "${OVERWRITE}x" == "Yx" ]; then
				PROCEED=1
			else
				PROCEED=0
			fi

			if [ $PROCEED -eq 1 ]; then
				echo "MOVED:"
				echo "  '$f'"
				echo "  '$BASE$NAME'"
				mv "$f" "$BASE$NAME"
			else
				echo "SKIPPED"
			fi
		else
			echo "MOVED:"
			echo "  '$f'"
			echo "  '$BASE$NAME'"
			mv "$f" "$BASE$NAME"
		fi
	done < $FILELIST
done < $FLATTENLIST

echo
echo
echo "Now run:"
echo "  find . -mindepth 2 -type d -exec rmdir {} \;"
echo "...a few times"
