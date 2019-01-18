module m_output_data
use m_global_data, only: mk, nthreads, Pi, test_flag

contains
    subroutine output_data(N,A_X,B_X,A_Y,B_Y, T_new, error_ftheo, cart_x, cart_y)
    implicit none
    real(mk),dimension(:,:) :: cart_x, cart_y, T_new, error_ftheo
    real(mk) :: A_X,B_X,A_Y,B_Y,f_theo
    integer(mk) :: i,j
    integer(mk) :: N
    
    ! write the source field in cartesian coordinates
    !$omp parallel do default(shared) private(i,j)
    do j=1,N+2
        do i=1,N+2
            cart_x(i,j) = A_X*real(i)+B_X 
            cart_y(i,j) = A_Y*real(j)+B_Y
        enddo
    enddo
    !$omp end parallel do

    if (test_flag) then
        !Compute the theoretical function
        !$omp parallel do default(shared) private(i,j)
        do j=1,N+2
            do i=1,N+2

            	!$omp critical(cric_prod)
                f_theo = sin(Pi*cart_x(i,j)) *&
                              sin(Pi*cart_y(i,j))
                !$omp end critical(cric_prod)
                error_ftheo(i,j) = T_new(i,j) - f_theo               
            !(T_new(i,j)-f_theo(i,j)
            enddo
        enddo
    endif


    end subroutine output_data
end module m_output_data
