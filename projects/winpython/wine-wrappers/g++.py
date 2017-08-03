#!/usr/bin/env python

# A wrapper for i686-w64-mingw32-g++ that removes -mno-cygwin and converts
# Windows paths to Unix paths, so that the w64-mingw32 g++ can be called by
# Python distutils.

import os
import subprocess
import sys

import common

args = ["/var/tmp/dist/mingw-w64/bin/i686-w64-mingw32-g++"]
sys.argv.pop(0)
while sys.argv:
    a = sys.argv.pop(0)
    if not a.startswith("-"):
        args.append(common.winepath(a))
        continue
    if a == "-mno-cygwin":
        continue
    if a == "--output-lib":
        o = sys.argv.pop(0)
        a = "-out-implib="+o
    if a in ("-I", "-L"):
        args.append(a)
        args.append(common.winepath(sys.argv.pop(0)))
        continue
    o = common.search_startswith(a, ("-I", "-L"))
    if o is not None:
        path = a[len(o):]
        args.append("%s%s" % (o, common.winepath(path)))
        continue
    args.append(a)
p = common.popen_faketime(args, stderr=subprocess.PIPE)
stderr = p.stderr.read()
sys.stderr.write(stderr)
if " error: " in stderr:
    sys.exit(1)
