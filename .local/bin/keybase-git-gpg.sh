#!/bin/sh

##
# This program can possibly be substituted for gpg in the git `gpg.program` configuration
# to allow a person to use Keybase.io to sign commits on behalf of gpg.

##
# Copyright 2019 Michael A. Smith
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of this software
# and associated documentation files (the "Software"), to deal in the Software without restriction,
# including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense,
# and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so,
# subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all copies
# or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO
# THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
# IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
# WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE
# OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#

##
# For reference, this is the text of `git help config` as it pertains to gpg.program
#
#  Use this custom program instead of "gpg" found on $PATH when making
#  or verifying a PGP signature. The program must support the same
#  command-line interface as GPG, namely, to verify a detached
#  signature, "gpg --verify $signature - <$file" is run, and the
#  program is expected to signal a good signature by exiting with code
#  0, and to generate an ASCII-armored detached signature, the
#  standard input of "gpg -bsau $key" is fed with the contents to be
#  signed, and the program is expected to send the result to its
#  standard output.
#

export GPG_TTY=$(tty)

main() {
  case "$1" in
    --verify) verify "$@";;
    *) sign "$@";;
  esac
}

verify() {
  # ...to verify a detached signature,
  # "gpg --verify $signature - <$file"
  # is run...
  exec gpg "$@"
}
  
sign() {
  # ...to generate an ASCII-armored detached signature, the
  # standard input of "gpg -bsau $key" is fed with the contents to be
  # signed, and the program is expected to send the result to its
  # standard output.
  shift 2
  d=$(mktmp -d "${TMPDIR:-/tmp}/gitsig.XXXXXXXXX")
  cat > "$d/commit.msg"
  keybase pgp sign --detached --key "$1" --infile "$d/commit.msg" --outfile "$d/commit.sig"
  gpg --verify --status-fd=2 "$d/commit.sig" "$d/commit.msg" > /dev/null 2> "$d/gpgstatus.txt"
  grep '^\[GNUPG:\] KEY_CONSIDERED' "$d/gpgstatus.txt" >&2
  printf '[GNUPG:] SIG_CREATED ' >&2
}

main "$@"