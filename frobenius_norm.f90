module m_frobenius_norm
    use m_global_data, only: mk, mkd
    
    contains
        subroutine frob_norm(matrix, norm)
        	implicit none
        	real(mk), dimension(:,:) :: matrix
        	real(mk) :: norm, loc_sum, sum
            integer :: i,j,Nx, Ny ! stores the size of array in x and y            
            
            ! size of array
            Nx = size(matrix,1)
            Ny = size(matrix,2)
            sum = 0.0
            ! calculate the norm
            do j=1,Ny

            	
            	do i=1,Nx
                    sum = sum + matrix(i,j)*matrix(i,j)
                enddo
               

            enddo

            ! calcualte norm
            norm = sum ** 0.5

        end subroutine frob_norm
end module m_frobenius_norm
