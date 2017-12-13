#!/bin/sh

# Copyright (c) 2017, The Tor Project, Inc.
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
# 1) Let OSSLSIGNCODE point to your osslsigncode binary
# 2) Change into the directory containing the .exe files and the sha256sums-unsigned-build.txt
# 3) Run /path/to/authenticode_check.sh

if [ -z "$OSSLSIGNCODE" ]
then
  echo "The path to your osslsigncode binary is missing!"
  exit 1
fi

UNSIGNED_BUNDLES=0
BADSIGNED_BUNDLES=0

mkdir tmp

for f in `ls *.exe`; do
  SHA256_TXT=`grep "$f" sha256sums-unsigned-build.txt`

  # Test 1: Is the .exe file still unsigned? I.e. does its SHA-256 sum still
  # match the one we had before we signed the .exe file? If so, notify us
  # later and exit.
  if [ "$SHA256_TXT" = "`sha256sum $f`" ]
  then
    echo "$f has still the SHA-256 sum of the unsigned bundle!"
    UNSIGNED_BUNDLES=`expr $UNSIGNED_BUNDLES + 1`
  fi

  # Test 2: Do we get the old SHA-256 sum after stripping the authenticode
  # signature? If not, notify us later and exit.
  if [ "$UNSIGNED_BUNDLES" = "0" ]
  then
    # At least we seem to have attempted to sign the bundle. Let's see if we
    # succeeded by stripping the signature. This behavior is reproducible.
    # Thus, we know if we don't get the same SHA-256 sum we did not sign the
    # bundle correctly.
    echo "Trying to strip the authenticode signature of $f..."
    ${OSSLSIGNCODE} remove-signature $f tmp/$f
    cd tmp
    if ! [ "$SHA256_TXT" = "`sha256sum $f`" ]
    then
      echo "$f does not have the SHA-256 sum of the unsigned bundle!"
      BADSIGNED_BUNDLES=`expr $BADSIGNED_BUNDLES + 1`
    fi
    cd ..
  fi
done

rm -rf tmp/

if ! [ "$UNSIGNED_BUNDLES" = "0" ]
then
  echo "We got $UNSIGNED_BUNDLES unsigned bundle(s), exiting..."
  exit 1
fi

if ! [ "$BADSIGNED_BUNDLES" = "0" ]
then
  echo "We got $BADSIGNED_BUNDLES badly signed bundle(s), exiting..."
  exit 1
fi

echo "The signatures are fine."
exit 0
