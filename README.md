# Calling Fortran from Julia

Compile the example by running
```bash
make
```

This will produce the executable `cptr`, which is linked against the newly
created shared library `libcptr.{so,dylib}`.

For the test output in pure Fortran, execute
```bash
./cptr
```
which will give you the following output:
```
           4
           3           3           3           3
                    0
```

For the test output when using `libcptr.{so,dylib}` from Julia, execute
```bash
julia cptr.jl
```
which will give you the following output:
```
           4
           3           3           3           3
 38557344 
 nchars =           10
 f_string: wololo😊
 Array length:            7
           1 :            1
           2 :            1
           3 :            2
           4 :            3
           5 :            5
           6 :            8
           7 :           13
```
At the moment it is unclear, why the third line is not also a null pointer as
in the pure Fortran example. The additional lines (starting with `nchars = ...`
are from a Julia-only test).
