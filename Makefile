# Determine library name
ifeq ($(shell uname -s),Darwin)
	DLEXT := .dylib
else
	DLEXT := .so
endif 
LIBCPTR := libcptr$(DLEXT)

# Fortran compiler & flags
FC := gfortran
FFLAGS := -O2

all: cptr

cptr: cptr.f90 $(LIBCPTR)
	$(FC) $(FFLAGS) -o $@ -Wl,-rpath,$(PWD) $^

lib: libcptr$(DLEXT)

$(LIBCPTR): libcptr.f90
	$(FC) $(FFLAGS) -fPIC -shared -o $@ $<

clean:
	rm -f libmodule.mod
	rm -f storage.mod
	rm -f cptr
	rm -f $(LIBCPTR)

.PHONY: all lib clean
