module m_init_test
use m_global_data, only: mk, mkd
contains
    subroutine init_test(N,T_old,T_new,f,X_start,X_end,Y_start,Y_end,A_X,B_X,A_Y,B_Y)
    implicit none
    integer :: i,j
    integer(mkd) :: N
    real(mk) :: A_X,B_X,A_Y,B_Y
    real(mk),dimension(:,:) :: T_new, T_old, f
    real(mk), parameter :: Pi = acos(-1.0_mk)
    real(mk) :: X_start, X_end, Y_start, Y_end
    !Initialize f test function
    A_X = ((X_end - X_start)/(real(N)+1.0_mk))
    B_X = ((X_start*(real(N)+2.0_mk)-X_end)/(real(N)+1.0_mk))
    A_Y = ((Y_end - Y_start)/(real(N)+1.0_mk))
    B_Y = ((Y_start*(real(N)+2.0_mk)-Y_end)/(real(N)+1.0_mk))
    do j=1,N+2
        do i=1,N+2
            f(i,j) = 2 * Pi ** 2 *&
                     sin(Pi*(A_X*real(i)+B_X)) *&
                     sin(Pi*(A_Y*real(j)+B_Y))
        enddo
    enddo
    !Initialize T_old
    do j=1,N+2
        do i=1,N+2
            T_old(i,j) = 0
        enddo
    enddo
    !Initialize T_new
    do j=1,N+2
        do i=1,N+2
            T_new(i,j) = 0
        enddo
    enddo
    end subroutine init_test
end module
