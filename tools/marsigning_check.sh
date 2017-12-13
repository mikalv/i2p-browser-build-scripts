#!/bin/sh

# Copyright (c) 2016, The Tor Project, Inc.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:

#     * Redistributions of source code must retain the above copyright
# notice, this list of conditions and the following disclaimer.
#
#     * Redistributions in binary form must reproduce the above
# copyright notice, this list of conditions and the following disclaimer
# in the documentation and/or other materials provided with the
# distribution.
#
#     * Neither the names of the copyright owners nor the names of its
# contributors may be used to endorse or promote products derived from
# this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
# A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
# OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
# LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
# DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
# THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

# Usage:
# 1) Let SIGNMAR point to your signmar binary
# 2) Let LD_LIBRARY_PATH point to the mar-tools directory
# 3) Change into the directory containing the MAR files and the
#    sha256sums-unsigned-build.txt/sha256sums-unsigned-build.incrementals.txt.
# 4) Run /path/to/marsigning_check.sh

if [ -z "$SIGNMAR" ]
then
  echo "The path to your signmar binary is missing!"
  exit 1
fi

if [ -z "$LD_LIBRARY_PATH" ]
then
  echo "The library search path to your mar-tools directory is missing!"
  exit 1
fi

UNSIGNED_MARS=0
BADSIGNED_MARS=0

mkdir tmp

for f in `ls *.mar`; do
  case $f in
    *.incremental.mar) SHA256_TXT=`grep "$f" \
      sha256sums-unsigned-build.incrementals.txt`;;
    *) SHA256_TXT=`grep "$f" sha256sums-unsigned-build.txt`;;
  esac

  # Test 1: Is the .mar file still unsigned? I.e. does its SHA-256 sum still
  # match the one we had before we signed it? If so, notify us later and exit.
  if [ "$SHA256_TXT" = "`sha256sum $f`" ]
  then
    echo "$f has still the SHA-256 sum of the unsigned MAR file!"
    UNSIGNED_MARS=`expr $UNSIGNED_MARS + 1`
  fi

  # Test 2: Do we get the old SHA-256 sum after stripping the MAR signature? If
  # not, notify us later and exit.
  if [ "$UNSIGNED_MARS" = "0" ]
  then
    # At least we seem to have attempted to sign the MAR file. Let's see if we
    # succeeded by stripping the signature. This behavior is reproducible.
    # Thus, we know if we don't get the same SHA-256 sum we did not sign the
    # bundle correctly.
    echo "Trying to strip the MAR signature of $f..."
    ${SIGNMAR} -r $f tmp/$f
    cd tmp
    if ! [ "$SHA256_TXT" = "`sha256sum $f`" ]
    then
      echo "$f does not have the SHA-256 sum of the unsigned MAR file!"
      BADSIGNED_MARS=`expr $BADSIGNED_MARS + 1`
    fi
    cd ..
  fi
done

rm -rf tmp/

if ! [ "$UNSIGNED_MARS" = "0" ]
then
  echo "We got $UNSIGNED_MARS unsigned MAR file(s), exiting..."
  exit 1
fi

if ! [ "$BADSIGNED_MARS" = "0" ]
then
  echo "We got $BADSIGNED_MARS badly signed MAR file(s), exiting..."
  exit 1
fi

echo "The signatures are fine."
exit 0
