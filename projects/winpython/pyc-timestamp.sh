#!/bin/bash
# Usage: pyc-timestamp.sh "2001-01-01" FILENAMES...
# Overwrite (in place) the timestamp in .pyc Python bytecode files.
#
# http://hg.python.org/cpython/file/2.7/Lib/py_compile.py#l123
# http://nedbatchelder.com/blog/200804/the_structure_of_pyc_files.html
# http://benno.id.au/blog/2013/01/15/python-determinism

TIMESPEC="$1"
shift

hex=$(printf 0x%08x $(date +%s --date="$TIMESPEC"))
# Write little-endian.
esc=$(printf "\\\\x%02x\\\\x%02x\\\\x%02x\\\\x%02x" $(($hex&0xff)) $((($hex>>8)&0xff)) $((($hex>>16)&0xff)) $((($hex>>24)&0xff)))
for filename in "$@"; do
	echo $filename
	echo -n -e "$esc" | dd of="$filename" bs=1 seek=4 conv=notrunc
done
