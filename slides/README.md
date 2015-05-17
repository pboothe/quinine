#QUINE + TAR = QUININE!!
      
> Quines are self-printing programs. Every program can [be made to] print out its own source code, and storage has become exceedingly cheap. So, we introduce Quinine, a library that uses fixed points, analytic philosophy, and tape storage tools to make open-source programs that carry their source code with themselves.

Peter Boothe, !!Con 2015.

#Quines
* Named after analytic philosopher Willard Van Orman Quine (1908-2000), who studied indirect self-reference (among other things)
* Programs that print out their own source code
* Fixed-points of the `compile_and_run(s)` function (a.k.a. `eval(s)`)
* A fun challenge: write a program that prints out its own source code! (the quotation marks are usually the tricky part)
* The following quotation twice, the second time in quotes: "The following quotation twice, the second time in quotes:"
```
    q = '"""'
    s = """q = '{q}'
    s = {q}{s}{q}
    print s.format(q=q, s=s)"""
    print s.format(q=q, s=s)
```

#Every program can be "quinified"

A direct consequence of Kleene's Second Recursion Theorem

Kleene pronounced his last name /klay'nee/.
> As far as I am aware this pronunciation is incorrect in all known languages. I believe that this novel pronunciation was invented by my father. -Ken Kleene

#Cheater Quines
* For languages which print out the final value, all values are quines.  e.g. for scheme `'hello` and `nil` are cheater quines.
* For compiled languages, you can hijack the compile part of the compile-run cycle and feed the error messages back in until you find a loop.  For clang on OSX,

```
	Undefined symbols for architecture x86_64:
	  "_main", referenced from:
	     implicit entry/start for main executable
	ld: symbol(s) not found for architecture x86_64
	clang: error: linker command failed with exit code 1 (use -v to see invocation)
```
is a cheater quine.

* For python, if you run your program like `python < program.py`, then 
```
      File "<stdin>", line 1
        File "<stdin>", line 1
        ^
    IndentationError: unexpected indent
```
is a cheater quine
* For interpreted languages, you can open the file referenced by `argv[0]`, because those languages already carry their code with themselves.

#Storage has become cheap

#Tape
* The cheapest storage medium of all
* A giant pain to work with
* One big file, stored in order on a giant tape
* `tar`, the tape archiver, is a tool for storing many files in one file  
* Just write one big file to the tape, but the file is a <code>.tar</code> file and contains multitudes

#QUININE!!

* A program that quinifies your codebase: `quinine.sh` will produce `quinine.h` and `quinine.c` (or possibly `quinine.py`, depending on the arguments passed in).
* Creates a library function `quinine_print_src()` that prints a string that reproduces the surrounding codebase.
* Question: How does it make one string represent multiple files?
    That's where the `tar` comes in!
* Question: How do you make sure all characters in the string are printable so you don't have to escape anything in the string?
    That's where `base64enc` comes in!

#All in pursuit of a middling pun
