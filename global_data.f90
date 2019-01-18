module m_global_data
implicit none
integer, parameter :: mks=kind(1.0E0)
integer, parameter :: mkd=kind(1.0D0)
integer, parameter :: mk = mkd
integer(mk) :: i, j, k_max, info
integer(mk) :: N
real(mk) :: d, X_start, X_end, Y_start, Y_end, A_X, B_X, A_Y, B_Y
real(mk),dimension(:,:),allocatable :: T_new, T_old, f, error_ftheo, cart_x, cart_y
real(mk), parameter :: Pi = acos(-1.0_mk)
!openmp declarations
integer(mk) :: nthreads
! flag to make the sin test
logical :: test_flag


end module
