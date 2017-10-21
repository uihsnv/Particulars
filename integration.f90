!----------------------------------------------------------------------
!                   INTEGRATING EQUATIONS OF MOTION                   !
!----------------------------------------------------------------------

MODULE integration

    USE parameters, ONLY : npart, box, dt

    IMPLICIT NONE

    REAL, DIMENSION(npart), PRIVATE, PARAMETER :: box_array = box

CONTAINS



    SUBROUTINE integration_VelVerlet_pos(Rx, Ry, Rz, Vx, Vy, Vz, Fx, Fy, Fz)

        !  Positions from the Velocity Verlet algorithm with PBCs

        REAL, DIMENSION(:), INTENT(IN) :: Vx, Vy, Vz, Fx, Fy, Fz
        REAL, DIMENSION(:), INTENT(INOUT) :: Rx, Ry, Rz

        Rx = MODULO(Rx + (Vx*dt) + (0.5*Fx*(dt**2)), box_array)
        Ry = MODULO(Ry + (Vy*dt) + (0.5*Fy*(dt**2)), box_array)
        Rz = MODULO(Rz + (Vz*dt) + (0.5*Fz*(dt**2)), box_array)

    END SUBROUTINE integration_VelVerlet_pos

    SUBROUTINE integration_VelVerlet_pos_2D(Rx, Ry, Vx, Vy, Fx, Fy)

        !  Positions from the Velocity Verlet algorithm with PBCs

        REAL, DIMENSION(:), INTENT(IN) :: Vx, Vy, Fx, Fy
        REAL, DIMENSION(:), INTENT(INOUT) :: Rx, Ry

        Rx = MODULO(Rx + (Vx*dt) + (0.5*Fx*(dt**2)), box_array)
        Ry = MODULO(Ry + (Vy*dt) + (0.5*Fy*(dt**2)), box_array)

    END SUBROUTINE integration_VelVerlet_pos_2D



    SUBROUTINE integration_VelVerlet_vel(Vx, Vy, Vz, Fx, Fy, Fz)

        !  A velocity half-step from the Velocity Verlet algorithm

        REAL, DIMENSION(:), INTENT(IN) :: Fx, Fy, Fz
        REAL, DIMENSION(:), INTENT(INOUT) :: Vx, Vy, Vz

        Vx = Vx + ((Fx*dt)/2.0)
        Vy = Vy + ((Fy*dt)/2.0)
        Vz = Vz + ((Fz*dt)/2.0)

    END SUBROUTINE integration_VelVerlet_vel


    SUBROUTINE integration_VelVerlet_vel_2D(Vx, Vy, Fx, Fy)

        !  A velocity half-step from the Velocity Verlet algorithm

        REAL, DIMENSION(:), INTENT(IN) :: Fx, Fy
        REAL, DIMENSION(:), INTENT(INOUT) :: Vx, Vy

        Vx = Vx + ((Fx*dt)/2.0)
        Vy = Vy + ((Fy*dt)/2.0)

    END SUBROUTINE integration_VelVerlet_vel_2D



END MODULE integration