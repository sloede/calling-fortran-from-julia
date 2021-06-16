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
```
At the moment it is unclear, why the final output is not also a null pointer as
in the pure Fortran example.
