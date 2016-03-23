function [ stOxyEnrichment,stVehicleCalib ] = OxyEnrichment( Data )

    
    %Run Calibration Function to find data for Max Torque, Power, etc.
        stVehicleCalib = VehicleCalib(Data);
    
    %Equation 8B - NCHRP 25.11
        stOxyEnrichment.Pth = (Data.stInitCond.Pscale * (0.5 * Data.stInitCond.VehicleMass * Data.stInitCond.SPmax * Data.stInitCond.MPHtoKPS + Data.stInitCond.Zdrag)) / Data.stInitCond.E1;
    
    for i = 1:Data.SizeData
    
        %Equation 8A - NCHRP 25.11
            stOxyEnrichment.Qth(i,1) = (stOxyEnrichment.Pth / Data.stInitCond.HPtoKW) * (Data.stInitCond.HPTorqueRatio / Data.ParsedData(i,Data.stLabelNames.AV_Eng_Index));
            
        if Data.ParsedData(i,Data.stLabelNames.M_EngOut_Index) > stOxyEnrichment.Qth(i,1)
            
            if Data.ParsedData(i,Data.stLabelNames.AV_Eng_Index) <= Data.stInitCond.Nm
                %Equation 7A - NCHRP 25.11
                Qwot = Data.stInitCond.Qm * (1 - 0.25 * (Data.stInitCond.Nm - Data.ParsedData(i,Data.stLabelNames.AV_Eng_Index)) / (Data.stInitCond.Nm - Data.stInitCond.Nidle));
            else
                %Equation 7A - NCHRP 25.11
                Qwot = Data.stInitCond.Qm * (1 - (1 - Data.stInitCond.Qp/Data.stInitCond.Qm) * (Data.ParsedData(i,Data.stLabelNames.AV_Eng_Index) - Data.stInitCond.Nm) / (Data.stInitCond.Np - Data.stInitCond.Nm));
            end
            
            %Equation 9 - NCHRP 25.11
                stOxyEnrichment.FuelAirEqRatio(i,1) = 1 + (Data.ParsedData(i,Data.stLabelNames.M_EngOut_Index) - stOxyEnrichment.Qth(i,1)) / (Qwot - stOxyEnrichment.Qth(i,1)) * (Data.stInitCond.Phi0 - 1);
        
        else
            %Equation 9 - NCHRP 25.11
                stOxyEnrichment.FuelAirEqRatio(i,1) = 1;
        end
        
    end
end

