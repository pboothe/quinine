#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>
#include <getopt.h>

#include "quinine.h"

void usage(const char *error_msg, ...) {
  if (error_msg != NULL) {
    va_list args;
    va_start(args, error_msg);
    vfprintf(stderr, error_msg, args);
    va_end(args);
  }
  printf("A sample program that does very little.  Supports the arguments:\n"
         "   -h --help    Print this message\n"
         "   -s --source  Print the source for this program\n"
         "                ex. \"./program -s | base64 -D | tar xvz\" will\n"
         "                create a fresh copy of the source code in the local\n"
         "                directory.\n");
}

int main(int argc, char **argv) {
  static struct option longopts[] = {
    {"help", no_argument, NULL, 'h'},
    {"source", no_argument, NULL, 's'},
    {NULL, 0, NULL, 0}
  };
  char ch;

  while ((ch = getopt_long(argc, argv, "hs", longopts, NULL)) != -1) {
    switch (ch) {
      case 'h': usage(NULL); exit(0); break;
      case 's': quinine_print_src(); exit(0); break;
      default: usage("Unrecognized argument %c\n", ch); exit(1); break;
    }
  }
  printf("Hello world\n");
  return 0;
}
