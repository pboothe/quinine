#!/bin/bash
# Quinine makes a quine using tar.  To find out more, call the program with no
# arguments, or with the -h or --help flag.
#
# Author: Peter Boothe <pboothe@gmail.com> 2 May 2015
# First shown to the world at !!Con 2015
#
# This code is licensed CC:0 - do anything you want with it. 
#   http://creativecommons.org/publicdomain/zero/1.0/ 
# I enjoyed writing it, and after having fun, I am done. That said, it would be
# wonderful to find out it was actually useful, so it would be nice to hear
# from you if you use it!
LANGUAGE=C
HEADER=
CODE=
FUNCTION=
HELP=
ERROR=0

if [ $? != 0 ]
then
  ERROR=1
fi

while [ "${1:0:1}" = "-" ]
do
  case "$1"
  in
    --help)
      HELP=1; shift;;
    -l|--lang)
      LANGUAGE="$2"; shift; shift;;
    -h|--header)
      HEADER="$2"; shift; shift;;
    -c|--code)
      CODE="$2"; shift; shift;;
    -f|--function)
      FUNCTION="$2"; shift; shift;;
    *)
      echo "Unknown option: $i" 1>&2; ERROR=2; break;;
  esac
done

if [ "x$*" = x ]
then
  echo "No files specified" 1>&2
  ERROR=1
fi

if [ "x${FUNCTION}" = x ]; then
  FUNCTION=quinine_print_src
fi

case $LANGUAGE
in
  c|C)
    if [ "x${HEADER}" = x ]; then
      HEADER=quinine.h
    fi
    if [ "x${CODE}" = x ]; then
      CODE=quinine.c
    fi
    true;;
  python)
    if [ "x${CODE}" = x ]; then
      CODE=quinine.py
    fi
    true;;
  *)
    ERROR=1;;
esac

if [ x$HELP != x ] || [ $ERROR != 0 ]
then
  cat 1>&2 <<EOF
NAME
  quinine

SYNOPSIS
  quinine --lang=c --header=quinine.h --code=quinine.c file1 ... fileN

DESCRIPTION
  quinine is a script for creating library files that, together
  with the contained function quinine_print_src(), which will print,
  to stdout, a tar archive of the source that makes up the passed-in
  program.  This allows open source programs to carry their source
  with themselves, which helps add a lot of missing promise to the
  idea of open source.  It also allows people to see the *exact*
  source code which created their program.

  The following options are available:
    --help  Print this help/usage message
    -l/--lang LANGUAGE
         LANGUAGE can be any of {C, python}. By default it is C.
    -h/--header FILE
	 For languages that have separate definitions and declarations
	 (e.g. C and C++), the header argument specifies the name
	 of the header file where the code should be declared (but
	 not defined).
    -c/--code FILE
         Specifies the file for the code that defines the print function
    -f/--function STRING
         The name of the function to create in the code file.

  By default, the program acts as if it was invoked as:
    quinine --lang C --header quinine.h --code quinine.c \\
            --function quinine_print_src

Examples:
  Get help
    quinine --help

  Generate C/C++ code
    quinine --lang=C --header=quinine.h --code=quinine.c file1 ... fileN

  Generate Python code
    quinine --lang=python --code=quinine.py file1 ... fileN
EOF
  exit $ERROR
fi

# If we get to here, everything is well-formed and we actually have work to do
case ${LANGUAGE}
in
  c|C)
    cat > ${HEADER} <<EOF
#ifndef __${HEADER/[.\\]/_}__
#define __${HEADER/[.\\]/_}__

// Print out all of the source code in:
//    $*
void ${FUNCTION}();

#endif
EOF
    (
      echo "#include <stdio.h>"
      echo
      printf "static char* ${FUNCTION}_string = "
      tar cz $* | base64 -b 70 | sed -e 's/^/      "/' -e 's/$/"/'
      echo "    ;"
      echo
      echo "void ${FUNCTION}() {"
      echo "  printf(\"%s\", ${FUNCTION}_string);"
      echo "}"
    ) > ${CODE};;
  python)
    (
      echo "def ${FUNCTION}():"
      echo "  'Print out base64 encoded, tarred, zipped program'"
      printf "  print \""
      tar cz $* | base64 | sed -e 's/$/"/g'
      echo
      cat - <<EOF
if __name__ == '__main__':
  ${FUNCTION}()
EOF
    ) > ${CODE};;
  *)
    echo UNKOWN LANGUAGE AFTER CHECK - THIS SHOULD NEVER HAPPEN 1>&2
    exit 100
esac
