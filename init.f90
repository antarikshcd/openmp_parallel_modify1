module m_init

use m_global_data, only: mk, nthreads
!$ use omp_lib    
contains
    subroutine init(N,T_old,T_new,f,X_start,X_end,Y_start,Y_end,A_X,B_X,A_Y,B_Y)
    implicit none
    integer(mk) :: i,j, i_start, i_end, j_start, j_end
    integer(mk) :: N
    real(mk) :: A_X,B_X,A_Y,B_Y
    real(mk),dimension(:,:) :: T_new, T_old, f
    real(mk) :: X_start, X_end, Y_start, Y_end, X_i, X_f, Y_i, Y_f
    !Initialize f real function
    X_i = 0 ; X_f = 1.0_mk / 3.0_mk
    Y_i = - 2.0_mk / 3.0_mk ; Y_f = - 1.0_mk / 3.0_mk
    A_X = ((X_end - X_start)/(real(N)+1.0_mk))
    B_X = ((X_start*(real(N)+2.0_mk)-X_end)/(real(N)+1.0_mk))
    A_Y = ((Y_end - Y_start)/(real(N)+1.0_mk))
    B_Y = ((Y_start*(real(N)+2.0_mk)-Y_end)/(real(N)+1.0_mk))

    !$omp parallel
    !$omp master
!$  nthreads = omp_get_num_threads()
    print*,'num threads init = ', nthreads
    !$omp end master        
    !$omp end parallel

    !$omp parallel default(shared)
    ! loop 1
    !$omp do private(i,j) !add scheduling, collapse !use sections to separate independednt pieces of code
    do j=1,N+2
        do i=1,N+2
             f(i,j) = 0
        enddo
    enddo
    !$omp end do nowait
    
    !sequential region
    !$omp single
    if (mod(N,2).eq.0) then
         i_start = floor((X_i-B_X)/A_X)
         i_end = floor((X_f-B_X)/A_X)
         j_start = floor((Y_i-B_Y)/A_Y)
         j_end = floor((Y_f-B_Y)/A_Y)
    else
         i_start = floor((X_i-B_X)/A_X)
         i_end = floor((X_f-B_X)/A_X)
         j_start = floor((Y_i-B_Y)/A_Y)+1
         j_end = floor((Y_f-B_Y)/A_Y)
    endif
    !$omp end single nowait
    !print*,'i_start', i_start !debug
     
     ! barrier
    !$omp barrier

    !loop2
    !$omp do private(i,j)
    do j=j_start,j_end
        do i=i_start,i_end
             f(i,j) = 200
        enddo
    enddo
    !$omp end do nowait 


    !Initialize T_old
    !$omp do private(i,j)
    do j=2,N+1
        do i=2,N+1
            T_old(i,j) = 0
        enddo
    enddo
    !$omp end do nowait


    !$omp do private(i)
    do i=1,N+2
        T_old(i,N+2) = 20
    enddo
    !$omp end do nowait

    !$omp do private(j)
    do j=1,N+2
        T_old(1,j) = 20
    enddo
    !$omp end do nowait

    !$omp do private(j)
    do j=1,N+2
        T_old(N+2,j) = 20
    enddo
    !$omp end do nowait

    !$omp do private(j)
    do i=1,N+2
        T_old(i,1) = 0
    enddo
    !$omp end do nowait

    !$omp barrier
    !Initialize T_new
    !$omp do private(i,j)
    do j=1,N+2
        do i=1,N+2
            T_new(i,j) = T_old(i,j)
        enddo
    enddo
    !$omp end do

!    !$omp do private(i, j)
!    do j=2,N+1
!        do i=2,N+1
!            T_new(i,j) = 0
!        enddo
!    enddo
!    !$omp end do nowait
!
!    !$omp do private(i)
!    do i=1,N+2
!        T_new(i,N+2) = 20
!    enddo
!    !$omp end do nowait 
!
!    !$omp do private(j)
!    do j=2,N+2
!        T_new(1,j) = 20
!    enddo
!    !$omp end do nowait
!
!    !$omp do private(j)
!    do j=2,N+2
!        T_new(N+2,j) = 20
!    enddo
!    !$omp end do nowait
    !$omp end parallel
    
    !debug the boundary conditions
    !print*,'T_old(1,:)' !debug
    !print*, T_old(1,:)  !debug

    !print*,'T_old(N+2,:)' !debug
    !print*, T_old(N+2,:)  !debug

    !print*,'T_old(:,1)'   !debug
    !print*, T_old(:,1)    !debug

    !print*,'T_old(:,N+2)' !debug
    !print*, T_old(:,N+2)  !debug

    !print*,'T_new(1,:)'  !debug
    !print*, T_new(1,:)   !debug

    !print*,'T_new(N+2,:)' !debug
    !print*, T_new(N+2,:)  !debug

    !print*,'T_new(:,1)' !debug
    !print*, T_new(:,1)  !debug

    !print*,'T_new(:,N+2)' !debug
    !print*, T_new(:,N+2) !debug

    !print*,'T_new', T_new !debug
    !print*,'f', f          !debug

    end subroutine init
end module
