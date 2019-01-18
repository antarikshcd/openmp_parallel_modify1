module m_output
use m_global_data, only: mk, nthreads, Pi
contains
    subroutine output(N,T_old,T_new,f,f_theo,A_X,B_X,A_Y,B_Y)
    implicit none
    real(mk),dimension(:,:) :: T_new, T_old, f, f_theo
    real(mk) :: A_X,B_X,A_Y,B_Y
    integer(mk) :: i,j
    integer(mk) :: N

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
            write(20,'(3E12.4)')A_X*real(i)+B_X,A_Y*real(j)+B_Y,f(i,j)
        enddo
    write(20,'(A)')
    enddo
    close(20)

    !Compute the theoretical function
    do j=1,N+2
        do i=1,N+2
            f_theo(i,j) = sin(Pi*(A_X*real(i)+B_X)) *&
                          sin(Pi*(A_Y*real(j)+B_Y))
        enddo
    enddo

    !Write the error to be able to plot
!    open(30,file='error.dat')
!    do j=1,N+2
!        do i=1,N+2
!            write(30,'(3E12.4)')A_X*real(i)+B_X,A_Y*real(j)+B_Y,(T_new(i,j)-f_theo(i,j))
!        enddo
!    write(30,'(A)')
!    enddo
!    close(30)
!    print*,'max err', maxval(T_new-f_theo)

    !Write the result to be able to plot
    open(40,file='result.dat')
    do j=1,N+2
        do i=1,N+2
            write(40,'(3E12.4)')A_X*real(i)+B_X,A_Y*real(j)+B_Y,T_new(i,j)
        enddo
    write(40,'(A)')
    enddo
    close(40)

    print*,'DEBUG:reached end of output.f90!'
    end subroutine output
end module
