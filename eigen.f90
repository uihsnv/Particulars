!----------------------------------------------------------------------
!                            EIGENVALUES                              !
!----------------------------------------------------------------------

MODULE eigen

    USE la_precision, ONLY: WP => SP
    USE f95_lapack, ONLY: LA_SYEV, LA_SYEVD

    IMPLICIT NONE

CONTAINS


    SUBROUTINE eigen_syev()

        ! COMPUTE ALL EIGENVALUES AND, OPTIONALLY, ALL EIGENVECTORS OF A REAL SYMMETRIC MATRIX

        INTEGER :: I, J, INFO, N

        REAL(WP), ALLOCATABLE :: A(:,:), AA(:,:), W(:)

        WRITE (*,*) 'LA_SYEV Example Program Results'
        N = 5
        ALLOCATE( A(N,N), AA(N,N), W(N) )

        OPEN(UNIT=21,FILE='syev.ma',STATUS='UNKNOWN')
        DO J=1,N
            DO I=1,N
                READ(21,*) A(I,J)
            ENDDO
        ENDDO
        CLOSE(21)

        AA=TRANSPOSE(A)

        WRITE(*,*)'Matrix A:'
        DO I=1,N
            WRITE(*,"(5(F9.5))") A(I,:)
        ENDDO

        WRITE(*,*) 'CALL LA_SYEV( A, W )'
        CALL LA_SYEV(  A, W)
        WRITE(*,*) 'W on exit : '
        DO I=1,N
            WRITE(*,"(5(F10.5))") W(I)
        ENDDO

    END SUBROUTINE eigen_syev


    SUBROUTINE eigen_syevd()

        ! USE A DIVIDE AND CONQUER ALGORITHM. IF EIGENVECTORS ARE DESIRED, CAN BE MUCH FASTER THAN syev FOR LARGE MATRICES, BUT USE MORE WORKSPACE.

        INTEGER :: I, J, INFO, N

        REAL(WP), ALLOCATABLE :: A(:,:), AA(:,:), W(:)

        WRITE(*,*)
        WRITE(*,*)' * EXAMPLE 2 * '

        WRITE(*,*)'Matrix A:'
        DO I=1,N
            WRITE(*,"(5(F9.5))") AA(I,:)
        ENDDO

        WRITE(*,*) "CALL LA_SYEVD( A, W, 'V', 'L', INFO )"
        CALL LA_SYEVD( AA, W, 'V', 'L', INFO )

        WRITE(*,*) 'A on exit : '
        DO I=1,N
            WRITE(*,"(5(E14.6))") AA(I,:)
        ENDDO

        WRITE(*,*) 'W on exit : '
        DO I=1,N
            WRITE(*,"(5(F10.5))") W(I)
        ENDDO

        WRITE(*,*) ' INFO = ', INFO

    END SUBROUTINE eigen_syevd

END MODULE eigen
