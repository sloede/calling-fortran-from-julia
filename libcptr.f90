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
         TYPE(c_ptr), INTENT(INOUT)          :: cptr
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

!//////////////////////////////////////////////////////////////////////// 
! 
   Module LibString
      USE ISO_C_BINDING
      IMPLICIT NONE
!
!  --------
   CONTAINS
!  --------
!
!//////////////////////////////////////////////////////////////////////// 
! 
      SUBROUTINE print_string(c_string) bind(C)
         IMPLICIT NONE
         CHARACTER(kind=c_char), dimension(*) :: c_string
         character(len=:), allocatable :: f_string

         f_string = c_f_string(c_string)
         print *, "f_string: ", f_string
      END SUBROUTINE print_string

      ! Sources:
      ! * https://community.intel.com/t5/Intel-Fortran-Compiler/Converting-c-string-to-Fortran-string/m-p/959515/highlight/true#M94338
      ! * https://stackoverflow.com/a/11443635/1329844
      ! * http://fortranwiki.org/fortran/show/c_interface_module
      FUNCTION c_f_string(c_string) RESULT(f_string)
         implicit none  
         character(kind=c_char), dimension(*), intent(in) :: c_string
         character(len=:), allocatable :: f_string
         integer i, nchars

         ! Figure out length of C string by counting characters before NULL
         i = 1
         do
           if (c_string(i) == c_null_char) exit
           i = i + 1
         end do
         nchars = i - 1  ! Exclude null character from Fortran string
         print *, "nchars = ", nchars
         allocate(character(len=nchars) :: f_string)

         do i=1,nchars
           f_string(i:i) = c_string(i)
         end do
      END FUNCTION c_f_string
   
   END Module LibString
