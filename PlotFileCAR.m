function [] = PlotFileCAR(Data)


    %Instantaneous Carbon Release and Vehicle Dynamics Plot
        figure('Name','Carbon, Velocity, and Position Plot')
            InstCarbDiox_Plot = subplot(3,1,1);
            plot(Data.ParsedData(2:Data.SizeData,Data.stLabelNames.Time_Index),Data.stCO2Emissions.CO2EmissionsInstant.*Data.stInitCond.kg_to_g)
            title('Instantaneous Carbon Dioxide Released');
            xlabel('Time (s)');
            ylabel('Carbon Dioxide (g)');

            VehVelocity_Plot = subplot(3,1,2);
            plot(Data.ParsedData(1:Data.SizeData,Data.stLabelNames.Time_Index),Data.stDistanceTraveled.VelMag)
            title('Vehicle Velocity');
            xlabel('Time (s)');
            ylabel('Velocity (kph)');

            DistTrav_Plot = subplot(3,1,3);
            plot(Data.ParsedData(2:Data.SizeData,Data.stLabelNames.Time_Index),Data.stDistanceTraveled.DistTravCumm*Data.stInitCond.meters_to_mi)
            title('Distance');
            xlabel('Time (s)');
            ylabel('Distance Travelled (mi)');

            linkaxes([InstCarbDiox_Plot,VehVelocity_Plot,DistTrav_Plot],'x')

    

    %Cummulative Emissions Plot
        figure('Name','Cummulative Emissions Plot')
            CO2EmissionsCummPlot = subplot(4,1,1);
            plot(Data.ParsedData(2:Data.SizeData,Data.stLabelNames.Time_Index),Data.stCO2Emissions.CO2EmissionsCumm*Data.stInitCond.kg_to_g)
            title('Cummulative Carbon Dioxide Released');
            xlabel('Time (s)');
            ylabel('Carbon Dioxide (g)');
        
            COEmissionsCummPlot = subplot(4,1,2);
            plot(Data.ParsedData(1:Data.SizeData,Data.stLabelNames.Time_Index),Data.stSuppEmissions.COEmissionsCumm)
            title('Cummulative Carbon Monoxide Released');
            xlabel('Time (s)');
            ylabel('Carbon Monoxide (g)');

            HCEmissionsCummPlot = subplot(4,1,3);
            plot(Data.ParsedData(1:Data.SizeData,Data.stLabelNames.Time_Index),Data.stSuppEmissions.HCEmissionsCumm)
            title('Cummulative Hydrocarbon Released');
            xlabel('Time (s)');
            ylabel('Hydrocarbons (g)');

            NOxEmissionsCummPlot = subplot(4,1,4);
            plot(Data.ParsedData(1:Data.SizeData,Data.stLabelNames.Time_Index),Data.stSuppEmissions.NOxEmissionsCumm)
            title('Cummulative Nitrous Oxide Released');
            xlabel('Time (s)');
            ylabel('Nitrous Oxide (g)');

            linkaxes([CO2EmissionsCummPlot,COEmissionsCummPlot,HCEmissionsCummPlot,NOxEmissionsCummPlot],'x')

    %Instantaneous Emissions Plot
        figure('Name','Instantaneous Emissions Plot')
            CO2EmissionsInstantPlot = subplot(4,1,1);
            plot(Data.ParsedData(2:Data.SizeData,Data.stLabelNames.Time_Index),Data.stCO2Emissions.CO2EmissionsInstant*Data.stInitCond.kg_to_g)
            title('Instantaneous Carbon Dioxide Released');
            xlabel('Time (s)');
            ylabel('Carbon Dioxide (g)');
        
            COEmissionsInstantPlot = subplot(4,1,2);
            plot(Data.ParsedData(1:Data.SizeData,Data.stLabelNames.Time_Index),Data.stSuppEmissions.COEmissionsInstant)
            title('Instantaneous Carbon Monoxide Released');
            xlabel('Time (s)');
            ylabel('Carbon Monoxide (g)');

            HCEmissionsInstantPlot = subplot(4,1,3);
            plot(Data.ParsedData(1:Data.SizeData,Data.stLabelNames.Time_Index),Data.stSuppEmissions.HCEmissionsInstant)
            title('Instantaneous Hydrocarbon Released');
            xlabel('Time (s)');
            ylabel('Hydrocarbons (g)');

            NOxEmissionsInstantPlot = subplot(4,1,4);
            plot(Data.ParsedData(1:Data.SizeData,Data.stLabelNames.Time_Index),Data.stSuppEmissions.ENOxInstant)
            title('Instantaneous Nitrous Oxide Released');
            xlabel('Time (s)');
            ylabel('Nitrous Oxide (g)');

            linkaxes([CO2EmissionsInstantPlot,COEmissionsInstantPlot,HCEmissionsInstantPlot,NOxEmissionsInstantPlot],'x')


    %Engine Torque and Power Plots
        figure('Name','Engine Torque and Power Plot')
            M_EngOut_TorquePlot = subplot(3,1,1);
            plot(Data.ParsedData(1:Data.SizeData,Data.stLabelNames.Time_Index),Data.ParsedData(1:Data.SizeData,Data.stLabelNames.M_EngOut_Index))
            title('Engine Output Torque');
            xlabel('Time (s)');
            ylabel('Torque (N-m)');

            PwrEngO_kWPlot = subplot(3,1,2);
            plot(Data.ParsedData(1:Data.SizeData,Data.stLabelNames.Time_Index),Data.ParsedData(1:Data.SizeData,Data.stLabelNames.PwrEngO_Index))
            title('Engine Output Crankshaft Power');
            xlabel('Time (s)');
            ylabel('Power (kW)');

            AV_Eng_Plot = subplot(3,1,3);
            plot(Data.ParsedData(1:Data.SizeData,Data.stLabelNames.Time_Index),Data.ParsedData(1:Data.SizeData,Data.stLabelNames.AV_Eng_Index))
            title('Engine Crankshaft Speed');
            xlabel('Time (s)');
            ylabel('Speed (rpm)');

            linkaxes([M_EngOut_TorquePlot,PwrEngO_kWPlot,AV_Eng_Plot],'x')
            
            
    %Sustainable Driving Determination Plots
        figure('Name','Sustainable Driving Determination Plot')
            InstCarbDiox_Plot2 = subplot(4,1,1);
            plot(Data.ParsedData(2:Data.SizeData,Data.stLabelNames.Time_Index),Data.stCO2Emissions.CO2EmissionsInstant.*Data.stInitCond.kg_to_g)
            title('Instantaneous Carbon Dioxide Released');
            xlabel('Time (s)');
            ylabel('Carbon Dioxide (g)');

            Throttle_DepressionPlot = subplot(4,1,2);
            plot(Data.ParsedData(1:Data.SizeData,Data.stLabelNames.Time_Index),Data.ParsedData(1:Data.SizeData,Data.stLabelNames.Throttle_Index))
            title('Throttle Depression Ratio');
            xlabel('Time (s)');
            ylabel('Ratio (-)');

            Bk_DepressionPlot = subplot(4,1,3);
            plot(Data.ParsedData(1:Data.SizeData,Data.stLabelNames.Time_Index),Data.ParsedData(1:Data.SizeData,Data.stLabelNames.Bk_Stat_Index))
            title('Brake Depression Ratio');
            xlabel('Time (s)');
            ylabel('Ratio (-)');

            Vehicle_AccelPlot = subplot(4,1,4);
            plot(Data.ParsedData(1:Data.SizeData,Data.stLabelNames.Time_Index),Data.stDistanceTraveled.AccelMag(1:Data.SizeData).*Data.stInitCond.AccelGrav)
            title('Vehicle Acceleration');
            xlabel('Time (s)');
            ylabel('Acceleration (m/s^2)');

            linkaxes([InstCarbDiox_Plot2,Bk_DepressionPlot,Throttle_DepressionPlot,Vehicle_AccelPlot],'x')


end

