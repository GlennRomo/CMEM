function [ stVehicleCalib ] = VehicleCalib( Data )

    %Max Engine Output Index Values
    [stVehicleCalib.MAX_EngTorque,stVehicleCalib.MAX_EngTorque_Index] = max(Data.ParsedData(:,Data.stLabelNames.M_EngOut_Index)); %Find Max Engine Torque and Index Value
    [stVehicleCalib.MAX_EngPower,stVehicleCalib.MAX_EngPower_Index] = max(Data.ParsedData(:,Data.stLabelNames.PwrEngO_Index));  %Find Max Engine Power and Index Value

    %Max Engine Output Values
    stVehicleCalib.EngSpeed_MaxTorque = Data.ParsedData(stVehicleCalib.MAX_EngTorque_Index,Data.stLabelNames.AV_Eng_Index);
    stVehicleCalib.EngSpeed_MaxPower = Data.ParsedData(stVehicleCalib.MAX_EngPower_Index,Data.stLabelNames.AV_Eng_Index);
    stVehicleCalib.EngTorque_MaxPower = Data.ParsedData(stVehicleCalib.MAX_EngPower_Index,Data.stLabelNames.M_EngOut_Index);
    
end

