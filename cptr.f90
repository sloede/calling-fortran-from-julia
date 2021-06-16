!
!////////////////////////////////////////////////////////////////////////
!
!      CPtr.f90
!      Created: June 16, 2021 at 8:13 AM 
!      By: David Kopriva  
!
!//////////////////////////////////////////////////////////////////////// 
! 
   PROGRAM main
   USE storage 
   USE ISO_C_BINDING
   USE LibModule
   IMPLICIT NONE  
   TYPE(stuff), POINTER :: s
   TYPE(c_ptr)          :: cptr
   
   cptr = allocateStuff(n = 4)
   CALL enquireStuff(cptr)
   CALL clearStuff(cptr)
   PRINT *, cptr ! Should be NULL = 0
   
   END PROGRAM main

