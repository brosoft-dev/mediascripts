#!/bin/bash

echo "This will catch and delete most of the unwanted files"
echo "associated with torrent/usenet downloads."
echo "No action taken unless you run $0 DOIT"

if [ "$1x" != "DOITx" ]; then
	echo
	echo "Cancelled"
	exit 0
fi

# Archives
find . -name "*.[0-9][0-9]" -exec rm -vf {} \;
find . -name "*.r[0-9][0-9]" -exec rm -vf {} \;
find . -name "*.s[0-9][0-9]" -exec rm -vf {} \;
find . -name "*.t[0-9][0-9]" -exec rm -vf {} \;
find . -name "*.u[0-9][0-9]" -exec rm -vf {} \;
find . -name "*.rar" -exec rm -vf {} \;

# Pointless to keep
find . -name "*.ignore" -exec rm -vf {} \;
find . -name "*.nzb" -exec rm -vf {} \;
find . -name "*.url" -exec rm -vf {} \;

# Repair files
find . -name "*.par2" -exec rm -vf {} \;

# Useless text
find . -name "*.txt" -exec rm -vf {} \;

# Viruses
find . -name "*.exe" -exec rm -vf {} \;
find . -name "*.bat" -exec rm -vf {} \;
find . -name "*.vbs" -exec rm -vf {} \;

# Media-meta info related, sometimes useful for XBMC/folder-art etc...
#find . -name "*.sfv" -exec rm -vf {} \;
#find . -name "*.nfo" -exec rm -vf {} \;
#find . -name "*.srr" -exec rm -vf {} \;

exit 0
