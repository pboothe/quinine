#QUININE!!

* A program that quinifies your codebase: `quinine.sh` will produce `quinine.h` and `quinine.c` (or possibly `quinine.py`, depending on the arguments passed in).
* Creates a library function `quinine_print_src()` that prints a string that reproduces the surrounding codebase.
* Question: How does it make one string represent multiple files?
    That's where the `tar` comes in!
* Question: How do you make sure all characters in the string are printable so you don't have to escape anything in the string?
    That's where `base64enc` comes in!
* In the example, to unpack the codebase into the current directory after compiling everything via `make`, run `./program | base64 -D | tar x`

More background can be had in the [slides/] directory.
