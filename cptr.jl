using Libdl: dlext

# Platform-independent library name
libcptr_path() = joinpath(".", "libcptr."*dlext)

# Set array length to 4
n = Cint(4)

# Allocate object in Fortran
cptr = ccall((:allocatestuff, libcptr_path()), Ptr{Cvoid}, (Ref{Cint},), n)

# Print some information about it
ccall((:enquirestuff, libcptr_path()), Cvoid, (Ref{Ptr{Cvoid}},), cptr)

# Release memory
ccall((:clearstuff, libcptr_path()), Cvoid, (Ref{Ptr{Cvoid}},), cptr)

# Print pointer value
println(" ", Int(cptr))

# Pass string from Julia to Fortran
ccall((:print_string, libcptr_path()), Cvoid, (Cstring,), "wololo😊")

# Pass array from Julia to Fortran
values = Cint[1, 1, 2, 3, 5, 8, 13]
ccall((:printintarray, libcptr_path()), Cvoid, (Ref{Cint}, Ref{Cint},), values, length(values))
