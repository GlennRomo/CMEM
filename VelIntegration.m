function [ state_d ] = VelIntegration( POSITION_MAG , VELOCITY_MAG)

    

    state_d(1) = VELOCITY_MAG;
    state_d(2) = interp1q(C_LiftDragFile(:,2),C_LiftDragFile(:,6),ang_attck);


end

