function stCO2Emissions = CO2Emissions(Data)
        
    stCO2Emissions.InstantFuelCons.Mfuel = zeros(Data.SizeData-1,1); %Pre-allocate memory for InstantFuelCons
    
    %Calculate Instantaneous Fuel Consumed through MFuel (kg/timestep)
        for i = 1:Data.SizeData-1
            stCO2Emissions.InstantFuelCons.Mfuel(i,1) = Data.ParsedData(i+1,Data.stLabelNames.Mfuel_Index) - Data.ParsedData(i,Data.stLabelNames.Mfuel_Index);
        end
        
    %Fuel Rate Determined by NCHRP Report for Preliminary Truck Model (g/s ??)
        K = Data.stInitCond.K0 * (1 + Data.stInitCond.C * (Data.ParsedData(:,Data.stLabelNames.AV_Eng_Index) * Data.stInitCond.RPMtoRPS - Data.stInitCond.N0));
        stCO2Emissions.InstantFuelCons.EngSpeedPower = (1/43.2) * (K .* Data.ParsedData(:,Data.stLabelNames.AV_Eng_Index) * Data.stInitCond.RPMtoRPS * Data.stInitCond.V + Data.ParsedData(:,Data.stLabelNames.PwrEngO_Index) / Data.stInitCond.eta) .* (1 + Data.stInitCond.b1 * (Data.ParsedData(:,Data.stLabelNames.AV_Eng_Index)*Data.stInitCond.RPMtoRPS - Data.stInitCond.N0).^2);
        
    %Cummulative Fuel Consumed through MFuel (kg)
        stCO2Emissions.FuelUsageCumm.Mfuel = cumsum(stCO2Emissions.InstantFuelCons.Mfuel);
        stCO2Emissions.FuelUsageCumm.EngSpeedPower = cumsum(stCO2Emissions.InstantFuelCons.EngSpeedPower);
    
    %Calculate Tailpipe Emissions from QFuel (kg)

        %Tailpipe Emissions (kg) = QFR(t) * StepSize * CarbonFuelRatio * CPF
        stCO2Emissions.QFuelConsume = Data.ParsedData(:,Data.stLabelNames.Qfuel_Index) * Data.stInitCond.time_step; 
        stCO2Emissions.QFuelCO2Release(:,1) = stCO2Emissions.QFuelConsume(:) * Data.stInitCond.CarbonFuelRatio * Data.stInitCond.CPF;
        
        
    %Instantaneous Carbon Dioxide Released (kg/timestep): %Tailpipe Emissions (kg) = FR(t) * CarbonFuelRatio * CPF
        stCO2Emissions.CO2EmissionsInstant.Mfuel = stCO2Emissions.InstantFuelCons.Mfuel * Data.stInitCond.CarbonFuelRatio * Data.stInitCond.CPF;
        stCO2Emissions.CO2EmissionsInstant.EngSpeedPower = stCO2Emissions.InstantFuelCons.EngSpeedPower * Data.stInitCond.CarbonFuelRatio * Data.stInitCond.CPF;
        
    %Total Consumed Carbon Dioxide (kg)
        stCO2Emissions.CO2Release_Total = sum(stCO2Emissions.CO2EmissionsInstant.Mfuel) * Data.stInitCond.CarbDioxtoCarbMWR;
        stCO2Emissions.CO2Release_Total_QFuel = sum(stCO2Emissions.QFuelCO2Release) * Data.stInitCond.CarbDioxtoCarbMWR;
        stCO2Emissions.CO2Release_Total_EngSpeedPower = sum(stCO2Emissions.CO2EmissionsInstant.EngSpeedPower) * Data.stInitCond.CarbDioxtoCarbMWR;
        %stCO2Emissions.CO2Release_Total = trapz(Data.ParsedData(2:Data.SizeData,Data.stLabelNames.Mfuel_Index-1),Data.CO2EmissionsInstant);
        %stCO2Emissions.CO2Release_Total_QFuel = trapz(Data.ParsedData(:,Data.stLabelNames.Mfuel_Index-1),Data.QFuelCO2Release);
    
    %Average Carbon Dioxide Released (kg/s)
        stCO2Emissions.CO2Release_Avg = stCO2Emissions.CO2Release_Total / Data.ParsedData(Data.SizeData,Data.stLabelNames.Time_Index);
    
    %Average Carbon Dioxide Released per Mile (g/mi)
        stCO2Emissions.CO2Release_Avg_mi.Mfuel = (stCO2Emissions.CO2Release_Total * Data.stInitCond.kg_to_g) / (Data.stDistanceTraveled.DistTrav_Total * Data.stInitCond.meters_to_mi);
        stCO2Emissions.CO2Release_Avg_mi.EngSpeedPower = (stCO2Emissions.CO2Release_Total_EngSpeedPower) / (Data.stDistanceTraveled.DistTrav_Total * Data.stInitCond.meters_to_mi);

        
        
        
    %TESTING!!
%         PossibleInstantFuelUsage_EngSpeedPower = Data.stCO2Emissions.InstantFuelCons.EngSpeedPower; %(g) of fuel /// * Data.stInitCond.time_step
%         C_Instant_TotalEngSpeedPower = PossibleInstantFuelUsage_EngSpeedPower * Data.stInitCond.CarbonFuelRatio * Data.stInitCond.CPF; %(g) of C
%         C02_Total_EngSpeedPower = sum(C_Instant_TotalEngSpeedPower) * Data.stInitCond.CarbDioxtoCarbMWR * 0.0002; %(g) of CO2
%         AvgCO2perMile_EngSpeedPower = (C02_Total_EngSpeedPower) / (Data.stDistanceTraveled.DistTrav_Total * Data.stInitCond.meters_to_mi); %(g/mi) of CO2
%         LBSperGAL = C02_Total_EngSpeedPower / Data.stCO2Emissions.FuelUsageCumm.EngSpeedPower(Data.SizeData) * 10.1 * 2.2; %g/gallon  and lbs/g

end