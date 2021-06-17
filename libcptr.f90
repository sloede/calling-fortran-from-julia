!
!////////////////////////////////////////////////////////////////////////
!
!      CPtr.f90
!      Created: June 16, 2021 at 8:13 AM 
!      By: David Kopriva  
!
!////////////////////////////////////////////////////////////////////////
!
   Module storage 
      IMPLICIT NONE  
      TYPE stuff
         INTEGER          :: n
         INTEGER, POINTER :: a(:)
      END TYPE stuff
   END Module storage
! 
!//////////////////////////////////////////////////////////////////////// 
! 
   Module LibModule 
      USE storage
      USE ISO_C_BINDING
      IMPLICIT NONE
!
!  --------
   CONTAINS
!  --------
!
!//////////////////////////////////////////////////////////////////////// 
! 
      FUNCTION allocateStuff(n) BIND(C) RESULT(cptr)
         IMPLICIT NONE  
         INTEGER :: n
         TYPE(stuff), POINTER :: s
         TYPE(c_ptr)          :: cptr
         
         ALLOCATE(s)
         ALLOCATE(s % a(n))
         s % a = 3
         cptr = C_LOC(s)
         
      END FUNCTION allocateStuff
!
!//////////////////////////////////////////////////////////////////////// 
! 
      SUBROUTINE clearStuff(cptr) BIND(C) 
         IMPLICIT NONE  
         TYPE(c_ptr)          :: cptr
         TYPE(stuff), POINTER :: s
         
         CALL C_F_POINTER(CPTR = cptr, FPTR = s) ! ? how to check type s = stuff?
         
         DEALLOCATE(s % a)
         DEALLOCATE(s)
         NULLIFY(s)
         cptr = c_null_ptr
      END SUBROUTINE clearStuff
!
!//////////////////////////////////////////////////////////////////////// 
! 
   SUBROUTINE enquireStuff(cptr) BIND(C) 
      IMPLICIT NONE  
      TYPE(c_ptr)          :: cptr
      TYPE(stuff), POINTER :: s
      
      CALL C_F_POINTER(CPTR = cptr, FPTR = s) ! ? how to check type s = stuff?
      PRINT *, SIZE(s % a)
      PRINT *, s % a
      
   END SUBROUTINE enquireStuff
   
   END Module LibModule
