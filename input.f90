module m_input
use m_global_data, only: mk, mkd
contains
    subroutine input(N,X_start, X_end, Y_start, Y_end,k_max,d)
    implicit none
    integer(mk) :: N
    integer(mk) :: k_max
    real(mk) :: d, X_start, X_end, Y_start, Y_end
    namelist/list/N, X_start, X_end, Y_start, Y_end, k_max,d
    open(10,file='input.txt')
    read(10,list)
    close(10)
    end subroutine input
end module
