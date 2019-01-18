module m_write_output
use m_global_data, only: mk, nthreads, Pi, test_flag
contains
    subroutine write_output(N, T_old, T_new, f, error_ftheo, A_X, B_X, A_Y, B_Y, cart_x, cart_y)
    implicit none
    real(mk),dimension(:,:) :: T_new, T_old, f, error_ftheo, cart_x, cart_y
    real(mk) :: A_X,B_X,A_Y,B_Y
    integer(mk) :: i,j
    integer(mk) :: N
    !logical :: test_flag

!    !$omp parallel
!    !$omp master
!    !$ nthreads = omp_get_num_threads()
!      print*,'num threads = ', nthreads
!    !$omp end master        
!    !$omp end parallel
    
    !Write the function f to be able to plot
    open(20,file='f.dat')
    do j=1,N+2
        do i=1,N+2
            write(20,'(3E12.4)') cart_x(i,j), cart_y(i,j) , f(i,j)
        enddo
    write(20,'(A)')
    enddo
    close(20)


    !Write the error to be able to plot
    if (test_flag) then
        open(30,file='error.dat')
        do j=1,N+2
            do i=1,N+2
                write(30,'(3E12.4)')cart_x(i,j), cart_y(i,j), error_ftheo(i,j)
            enddo
        write(30,'(A)')
        enddo
        close(30)
        print*,'max err', maxval(error_ftheo)
    endif    

    !Write the result to be able to plot
    open(40,file='result.dat')
    do j=1,N+2
        do i=1,N+2
            write(40,'(3E12.4)')cart_x(i,j), cart_y(i,j), T_new(i,j)
        enddo
    write(40,'(A)')
    enddo
    close(40)

    print*,'DEBUG:reached end of output.f90!'
    end subroutine write_output
end module
