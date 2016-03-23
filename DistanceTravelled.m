function [ stDistanceTraveled ] = DistanceTravelled( Data )

    %Total Time Conversion from 00:ss to mm:ss
        Mins = Data.ParsedData(Data.SizeData,Data.stLabelNames.Time_Index)/Data.stInitCond.minstosecs;
        stDistanceTraveled.TotalTimeMin = floor(Mins);
        stDistanceTraveled.TotalTimeSec = (Mins - stDistanceTraveled.TotalTimeMin) * Data.stInitCond.minstosecs;
         
    %Distance Travelled
        stDistanceTraveled.VelMag(:,1) = sqrt( (Data.ParsedData(:,Data.stLabelNames.Vx_Index)).^2 + ...
                (Data.ParsedData(:,Data.stLabelNames.Vy_Index)).^2 + (Data.ParsedData(:,Data.stLabelNames.Vz_Index)).^2);

        stDistanceTraveled.VelMag_Avg = mean(stDistanceTraveled.VelMag);
        stDistanceTraveled.VelMag_Max = max(stDistanceTraveled.VelMag);
            
        stDistanceTraveled.VelSign = ones(Data.SizeData,1);
        stDistanceTraveled.AccelSign = ones(Data.SizeData,1);
        stDistanceTraveled.NumStops = zeros(Data.SizeData,1);
        
        stDistanceTraveled.NumStops(1,1) = 1;

        for i = 1:Data.SizeData-1

            %Distance Travelled from Point Locations
                stDistanceTraveled.InstantDistTrav(i+1,1) = sqrt( ( Data.ParsedData(i+1,Data.stLabelNames.Xo_Index) - Data.ParsedData(i,Data.stLabelNames.Xo_Index) )^2 + ...
                    ( Data.ParsedData(i+1,Data.stLabelNames.Yo_Index) - Data.ParsedData(i,Data.stLabelNames.Yo_Index) )^2 + ...
                    ( Data.ParsedData(i+1,Data.stLabelNames.Zo_Index) - Data.ParsedData(i,Data.stLabelNames.Zo_Index) )^2);

            %Velocity Magnitude
                if stDistanceTraveled.InstantDistTrav(i+1,1) > stDistanceTraveled.InstantDistTrav(i,1) || stDistanceTraveled.InstantDistTrav(i+1,1) == stDistanceTraveled.InstantDistTrav(i,1)
                    stDistanceTraveled.VelSign(i+1,1) = 1;
                else
                    stDistanceTraveled.VelSign(i+1,1) = -1;
                end     
                
            %Number of Stops
                if stDistanceTraveled.VelMag(i+1,1) < Data.stInitCond.VelStop
                    if stDistanceTraveled.VelMag(i,1) > Data.stInitCond.VelStop || stDistanceTraveled.VelMag(i,1) == Data.stInitCond.VelStop
                    	stDistanceTraveled.NumStops(i+1,1) = 1;
                    end
                end

            %Acceleration Magnitude
                if stDistanceTraveled.VelMag(i+1,1) > stDistanceTraveled.VelMag(i,1) || stDistanceTraveled.VelMag(i+1,1) == stDistanceTraveled.VelMag(i,1)
                    stDistanceTraveled.AccelSign(i+1,1) = 1;
                else
                    stDistanceTraveled.AccelSign(i+1,1) = -1;
                end
        end

        stDistanceTraveled.DistTrav_Total = sum(stDistanceTraveled.InstantDistTrav);
        stDistanceTraveled.DistTravCumm = cumsum(stDistanceTraveled.InstantDistTrav);
        
        stDistanceTraveled.NumStops_Total = sum(stDistanceTraveled.NumStops);
        
        
    %Vehicle Acceleration Magnitude and Deceleration Array
        stDistanceTraveled.AccelMag(:,1) = sqrt( (Data.ParsedData(:,Data.stLabelNames.Ax_Index)).^2 + ...
        (Data.ParsedData(:,Data.stLabelNames.Ay_Index)).^2 + (Data.ParsedData(:,Data.stLabelNames.Az_Index)).^2);
    
       % tspan = Data.ParsedData(1,Data.stLabelNames.Time_Index):Data.stInitCond.time_step:Data.ParsedData(Data.SizeData,Data.stLabelNames.Time_Index);

       % [Velocity,Acceleration] = ode45(@VelIntegration, tspan,[stDistanceTraveled.VelMag(1,1),stDistanceTraveled.AccelMag(1,1)]);
    
        stDistanceTraveled.AccelMag = stDistanceTraveled.AccelMag .* stDistanceTraveled.AccelSign .* Data.stInitCond.AccelGrav;
        stDistanceTraveled.AccelMag_Max = max(stDistanceTraveled.AccelMag);
        stDistanceTraveled.AccelMag_Min = min(stDistanceTraveled.AccelMag);
        stDistanceTraveled.AccelMag_Avg = mean(stDistanceTraveled.AccelMag);
        
%         for j = 1:Data.SizeData
%             if stDistanceTraveled.AccelMag(:,1) < 0 
%                 stDistanceTraveled.DecelMag(:,1) = stDistanceTraveled.AccelMag(:,1);
%             else
%                 stDistanceTraveled.DecelMag(:,1) = stDistanceTraveled.AccelMag(:,1);
%             end
%         end
    
end

