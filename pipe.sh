#!/bin/sh
# Simulate pipe behaviour to commands that only take input from arguments

test $# -gt 0 || {
	echo "Usage: <INPUT> | pipe cmd [ext]" 1>&2
	exit 1
}

if test $# -eq 2
then
	ext=.$2
else
	case $1 in
		surf | chrome ) ext=.html ;;
		mupdf ) ext=.pdf ;;
		* ) ext= ;;
	esac
fi

case $1 in
	chrome ) prefix="--app=file://" ;;
	* ) prefix= ;;
esac

tmppipe=/tmp/pipe.$$$ext
cat > $tmppipe # Redirect stdin to file
trap 'rm "$tmppipe"' EXIT
$1 $prefix$tmppipe # Run command on file
