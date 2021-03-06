!-------------------------------------------------------------------------------!
!                                     LATTICES                                  !
!-------------------------------------------------------------------------------!
!
!   Copyright (C) 2015-2018  Vishnu V. Krishnan : vishnugb@gmail.com
!
!   This program is free software: you can redistribute it and/or modify
!   it under the terms of the GNU General Public License as published by
!   the Free Software Foundation, either version 3 of the License, or
!   (at your option) any later version.
!
!   This program is distributed in the hope that it will be useful,
!   but WITHOUT ANY WARRANTY; without even the implied warranty of
!   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
!   GNU General Public License for more details.
!
!   You should have received a copy of the GNU General Public License
!   along with this program.  If not, see <https://www.gnu.org/licenses/>.

MODULE lattice

    USE parameters, ONLY : npart, box, npart_edge, npart_face, space, num_cell,&
        dimnsn, npart_cell, npart_d_cell
    USE random_init

CONTAINS



    SUBROUTINE lattice_random(Rx, Ry, Rz)

        ! A box of randomly placed partices

        REAL, DIMENSION(:), INTENT(OUT) :: Rx, Ry, Rz

        CALL init_random_seed()

        CALL RANDOM_NUMBER(Rx)
        Rx = box*Rx
        CALL RANDOM_NUMBER(Ry)
        Ry = box*Ry
        CALL RANDOM_NUMBER(Rz)
        Rz = box*Rz


    END SUBROUTINE lattice_random


    SUBROUTINE lattice_simple_cubic(Rx, Ry, Rz)

        ! A box of particles placed on a simple cubic lattice

        REAL, DIMENSION(:), INTENT(OUT) :: Rx, Ry, Rz

        INTEGER :: j
        INTEGER, DIMENSION(npart) :: I

        I = [(j, j=0, npart-1)]

        Rx = space * MODULO(I, npart_edge)
        Ry = space * MODULO( (I/npart_edge), npart_edge)
        Rz = I / npart_face


    END SUBROUTINE lattice_simple_cubic



    SUBROUTINE lattice_cell_simple_cubic(R, location)

        ! particles on a lattice, cell-wise

        REAL, DIMENSION(:), INTENT(OUT) :: R
        INTEGER, DIMENSION(:), INTENT(OUT) :: location

        INTEGER :: i

        location(1) = 1

        DO CONCURRENT (i = 1 : (num_cell-1))
            location(i) = 1 + (i * npart_d_cell)
        END DO

        R = 0

    END SUBROUTINE



    SUBROUTINE lattice_square(Rx, Ry)

        ! A box of particles placed on a square lattice

        REAL, DIMENSION(:), INTENT(OUT) :: Rx, Ry

        INTEGER :: j
        INTEGER, DIMENSION(npart) :: I

        I = [(j, j=0, npart-1)]

        Rx = space * MODULO(I, npart_edge)
        Ry = space * MODULO( (I/npart_edge), npart_edge)

    END SUBROUTINE lattice_square



    SUBROUTINE lattice_speciate(species)

        ! particle species assignment

        LOGICAL, DIMENSION(:), INTENT(OUT) :: species

        REAL, DIMENSION(npart) :: r

        CALL init_random_seed()

        CALL RANDOM_NUMBER(r)

        WHERE (r .LE. 0.2)
            species = .TRUE.
        ELSEWHERE
            species = .FALSE.
        ENDWHERE

    END SUBROUTINE lattice_speciate



    SUBROUTINE lattice_velocities_random(Vx, Vy, Vz)

        REAL, DIMENSION(:), INTENT(OUT) :: Vx, Vy, Vz

        REAL :: sumVx, sumVy, sumVz

        CALL init_random_seed()

        CALL RANDOM_NUMBER(Vx)
        Vx = Vx - 0.5
        sumVx = SUM(Vx)/REAL(npart)
        CALL RANDOM_NUMBER(Vy)
        Vy = Vy - 0.5
        sumVy = SUM(Vy)/REAL(npart)
        CALL RANDOM_NUMBER(Vz)
        Vz = Vz - 0.5
        sumVz = SUM(Vz)/REAL(npart)

        Vx = Vx - sumVx                                                         ! setting Vcm to zero
        Vy = Vy - sumVy
        Vz = Vz - sumVz

    END SUBROUTINE lattice_velocities_random


    SUBROUTINE lattice_velocities_random_2D(Vx, Vy)

        REAL, DIMENSION(:), INTENT(OUT) :: Vx, Vy

        REAL :: sumVx, sumVy

        CALL init_random_seed()

        CALL RANDOM_NUMBER(Vx)
        Vx = Vx - 0.5
        sumVx = SUM(Vx)/REAL(npart)
        CALL RANDOM_NUMBER(Vy)
        Vy = Vy - 0.5
        sumVy = SUM(Vy)/REAL(npart)

        Vx = Vx - sumVx                                                         ! setting Vcm to zero
        Vy = Vy - sumVy

    END SUBROUTINE lattice_velocities_random_2D



END MODULE lattice
