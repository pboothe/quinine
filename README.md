#QUININE!!

* A program that quinifies your codebase: `quinine.sh` will produce `quinine.h` and `quinine.c` (or possibly `quinine.py`, depending on the arguments passed in).
* Creates a library function `quinine_print_src()` that prints a string that reproduces the surrounding codebase.
* In the example, to unpack the codebase into the current directory after compiling everything via `make`, run `./program --source | base64 -D | tar x`

More background can be had in the [slides/](https://github.com/pboothe/quinine/tree/master/slides) directory.
