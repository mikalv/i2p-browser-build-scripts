#!/usr/bin/env bash
omnija_file="$1"
if [ -z "$EDITOR"  ]; then
    export EDITOR=vim
fi
temp_dir=$(mktemp -d)
cd $temp_dir
unzip $omnija_file
$EDITOR $(pwd)
rm -f $omnija_file
zip -qr9XD $omnija_file *
cd -
rm -fr $temp_dir
