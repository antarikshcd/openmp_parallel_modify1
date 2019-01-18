module m_iter_gauss_siedel
use m_global_data, only: mk, mkd
use m_frobenius_norm

contains
    subroutine iter_gauss_siedel(N,T_old,T_new,f,k_max,d,X_start, X_end, Y_start, Y_end)
    implicit none
    integer(mk) :: i, j, k, k_max, count0, count1, c_rate
    integer(mk) :: N
    real(mk) :: elap_time, sum, norm, d, delta_X, delta_Y, aii,X_start, X_end, Y_start, Y_end, tmp
    real(mk),dimension(:,:) :: T_new, T_old, f
    delta_X = (X_end - X_start) / real(N+1, mk)
    delta_Y = (Y_end - Y_start) / real(N+1, mk)
    norm = 50 !higher than 20
    k = 0
    aii = 1.0/4.0
    
    ! call system clock
    call system_clock(count=count0, count_rate=c_rate)

    do while (norm > d .and. k < k_max)
        sum = 0.0
        do j=2,N+1
            do i=2,N+1
                
                tmp = T_new(i,j) ! store the old value of the element
                ! update the element
                T_new(i,j) = aii * (T_new(i-1,j) +&
                                        T_new(i+1,j) +&
                                        T_new(i,j-1) +&
                                        T_new(i,j+1) +&
                                        delta_X*delta_Y*f(i,j))
                ! update the norm
                sum = sum + (T_new(i,j) - tmp)*(T_new(i,j) - tmp)
            enddo
        enddo
 
        k = k + 1
        print*,'k=',k
        ! update norm
        norm = sum ** 0.5
        print*,'norm=',norm
        ! update
        T_old = T_new
    enddo

    call system_clock(count=count1)
    elap_time = real(count1 - count0)/real(c_rate)
    print*,'Wall time (fortran):', elap_time,'[s]' 
    print*,'Iteration rate=', k/elap_time,'[iteration/s]'   

    end subroutine iter_gauss_siedel
end module
