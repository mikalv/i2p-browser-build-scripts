#!/usr/bin/env python

# Sets these keys in a property list file:
#   CFBundleGetInfoString
#   CFBundleShortVersionString
#   NSHumanReadableCopyright

import getopt
import plistlib
import sys

def usage():
    print >> sys.stderr, "usage: %s I2PBROWSER_VERSION YEAR < Info.plist > FixedInfo.plist" % sys.argv[0]
    sys.exit(2)

_, args = getopt.gnu_getopt(sys.argv[1:], "")

if len(args) != 2:
    usage()

TORBROWSER_VERSION = args[0]
YEAR = args[1]

COPYRIGHT = "I2P Browser %s Copyright %s The Invisible Internet Project" % (I2PBROWSER_VERSION, YEAR)

plist = plistlib.readPlist(sys.stdin)

plist["CFBundleGetInfoString"] = "I2P Browser %s" % I2PBROWSER_VERSION
plist["CFBundleShortVersionString"] = I2PBROWSER_VERSION
plist["NSHumanReadableCopyright"] = COPYRIGHT

plistlib.writePlist(plist, sys.stdout)
