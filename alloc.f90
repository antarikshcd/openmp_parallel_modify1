module m_alloc
use m_global_data, only: mk
contains
    subroutine alloc(N,T,info)
    implicit none
    integer(mk) :: info
    integer(mk) :: N
    real(mk), dimension(:,:), allocatable :: T
    allocate(T(N+2,N+2),STAT=info)
    end subroutine alloc
end module
