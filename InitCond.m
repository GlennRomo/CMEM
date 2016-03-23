function [ stInitCond ] = InitCond( Data )

    %Physical Parameters
        stInitCond.meters_to_mi = 0.000621371192; %CF: meters to miles
        stInitCond.MPHtoKPS = (0.447^2)/1000;     %Conversion Factor for mph to kps
        stInitCond.RPMtoRPS = 1/60;               %Conversion Factor for rpm to rev/s
        stInitCond.kphTOmph = 0.621371;           %Conversion Factor for kph to mph
        stInitCond.kg_to_g = 1000;                %CF: kg to grams
        stInitCond.HPtoKW = 0.7457;               %1 HP = 0.7457 kW
        stInitCond.HPTorqueRatio = 5252;          %1 HP = 5252 lb-ft * 1 rpm
        stInitCond.diesel_kg_to_gal = 3.0846;     %0.324 kg = 1 gal for Conventional Diesel (ICBE)
        stInitCond.AccelGrav = 9.80665;           %NIST Reference on Constants, Units, and Uncertainty
        stInitCond.minstosecs = 60;               %Number of secondsin a minute
        
    %Simulation Parameters
        %Simulation Preset Time Step
        stInitCond.time_step = Data.ParsedData(2,Data.stLabelNames.Time_Index) - Data.ParsedData(1,Data.stLabelNames.Time_Index);
        
        stInitCond.MapWindow = [-600 400 -1000 400]; %Window Size of Map for Each Gradient Plot
        stInitCond.CO2EmMax = 0.8e-04;            %Sets Max Value for CO2 Color Gradient
        stInitCond.ThrottleMax = 1;               %Sets Max Value for Throttle Color Gradient
        stInitCond.BrakeMax = 1;                  %Sets Max Value for Brake Color Gradient
        stInitCond.VelMax = 105;                  %Sets Max Value for Vel Color Gradient (kph)
        stInitCond.VelStop = 0.1;                 %Sets Max Value for Vel to Assume Complete Stop (kph)
        stInitCond.AccelMax = 5;                  %Sets Max Value for Decel Color Gradient (m/s^2)
        
        stInitCond.LeaderBoard1 = 0.98;              %Sets Leader Board Score at Percentage of Participant Score (-)
        stInitCond.LeaderBoard2 = 0.995;              %Sets Leader Board Score at Percentage of Participant Score (-)        
        stInitCond.LeaderBoard4 = 1.012;              %Sets Leader Board Score at Percentage of Participant Score (-)
        stInitCond.LeaderBoard5 = 1.017;              %Sets Leader Board Score at Percentage of Participant Score (-)
        stInitCond.LeaderBoard6 = 1.02;              %Sets Leader Board Score at Percentage of Participant Score (-)
    
    %Fuel Density
        stInitCond.CarbonFuelRatio = 2778/3240;   %ICBE: kg of Carbon/kg of Diesel = 0.8574;
                                                  %NIPER: kg of Carbon/kg of Diesel = 3220.0522/3240
                                                  %= 0.9938
                                                  %ICBE: kg of Carbon/kg of Gas = 2421/2791 = 0.8674
                                                  %NIPER: kg of Carbon/kg of Gas =
                                                  %2800.0257/2791 = ??
        stInitCond.CarbDioxtoCarbMWR = 44/12;     %Molecular Weight Ratio of CO2 and C
    
    %Preliminary Truck Model Emissions Coefficients
        stInitCond.aCO = 0.0052;                  %AVG Light-Duty Vehicle: CO Engine-Out Emissions Coefficient
        stInitCond.CO = 0.0031;                   %AVG Light-Duty Vehicle: CO Engine-Out Emissions Intercept
        stInitCond.aHC = 0.0018;                  %AVG Light-Duty Vehicle: HC Engine-Out Emissions Coefficient
        stInitCond.rHC = 0.0024;                  %AVG Light-Duty Vehicle: HC Engine-Out Emissions Intercept
        stInitCond.aNOx = 0.0314;                 %AVG Light-Duty Vehicle: NOx Engine-Out Emissions Coefficient
        stInitCond.rNOx = 0.0032;                 %AVG Light-Duty Vehicle: NOx Engine-Out Emissions Intercept
                                                  %NCHRP Project 25-11, Table 4.6
                                                  
        stInitCond.V = 3.42;                      %Tier 1 Light-Duty Truck: Engine Volume Displacement (liter)
        stInitCond.K0 = 0.215;                    %Tier 1 Light-Duty Truck: Engine Friction Factor Coefficient [kJ/(rev.liter)]
        stInitCond.C = 0.00125;                   %Tier 1 Light-Duty Truck: "Coefficient"
        stInitCond.b1 = 10^(-4);                  %Tier 1 Light-Duty Truck: "Coefficient"
        stInitCond.N0 = 30 * sqrt(3.0/stInitCond.V); %Engine Speed Minimum Based on Engine Volume Displacement
        stInitCond.eta = 0.45;                    %Tier 1 Light-Duty Truck: Indicated Efficiency for Diesel Engine
                                                  %NCHRP Table 4.4 - Column 17 or pg. 101 for FR Equations
                                   
                                              
        
	%Car Model Emissions Coefficients
    
        %Oxygen Enrichment Parameters
            stInitCond.VehicleMass = 6000;            %Vehicle Mass (kg)
            stInitCond.CPF = 1;                       %Catalyst Pass Fraction

            stInitCond.Pscale = 1.165;                %Power Threshold Dimensionless Scaling Factor (-)
            stInitCond.SPmax = 192;                   %Max FTP (Federal Test Procedure) Specific Power (mph^2/s)
            stInitCond.Zdrag = 1;                     %Power Demand from Air and tire Drag (kW)
            stInitCond.E1 = 81;                       %Max Drivetrain Efficiency
            stInitCond.E2 = 1.0;                      %Coefficient for Low Speed Driving
            stInitCond.E3 = 0.1;                      %Coefficient during High Power Driving
            stInitCond.Nm = 1704.9;                   %Engine Speed @ Max Torque (rpm)
            stInitCond.Np = 1741.2;                   %Engine Speed @ Max Power (rpm)
            stInitCond.Nidle = 600;                   %Engine Speed @ Idle (rpm)
            stInitCond.Qm = 2081.8;                   %Max Torque (N-m)
            stInitCond.Qp = 2060.6;                   %Engine Torque @ Max Power (N-m)
            stInitCond.Phi0 = 1.1854;                 %Fuel Air Equivalence Ratio @ WOT

        %Emissions Magnitude Parameters
            stInitCond.EngOUTCo = 3.6;                %Engine Out CO Enrichment Coefficient
            stInitCond.Aco =  0.1354;                 %Engine Out CO Emission Index Coefficient (NCHRP - Table 4.4 Avg)
            stInitCond.Ahc = 0.0148;                  %Engine Out HC Emission Index Coeffecient (NCHRP - Table 4.4 Avg)
            stInitCond.Rhc = 0.0023;                  %Engine Out HC Residual Value (NCHRP - Table 4.4 Avg)
            stInitCond.HCtrans = 2.0428;              %Engine Out HC Lean Emissions (g.s/mph^2) (NCHRP - Table 4.4 Avg)
            stInitCond.dSPdtTH = 31.7112;             %Threshold of the Specific Power Rate of Change (mph^2/s^2) (NCHRP - Table 4.4 Avg)
            stInitCond.HCmax = 0.0977;                %Maximum Value of Enleanment HC Puffs (g/s) (NCHRP - Table 4.4 Avg)
            stInitCond.rR = 0.2806;                   %Unburned Hydrocarbons Release Rate (1/s) (NCHRP - Table 4.4 Avg)
            stInitCond.bHC = stInitCond.HCmax/stInitCond.rR;  %Built-up Condensed fuel in the Intake Manifold at the Start of the Event (g)
            stInitCond.a1NOx = 0.0293;                %NOx Emission Index Coefficient (-) (NCHRP - Table 4.4 Avg)
            stInitCond.a2NOx = 0.0293;                      %NOx Emission Index Coefficient (-) (NCHRP - Table 4.4 Avg)
            stInitCond.FRno1 = -0.4063;               %Fuel Rate Thresholds (g/s) (NCHRP - Table 4.4 Avg)
            stInitCond.FRno2 = 0.2912;                %Fuel Rate Thresholds (g/s) (NCHRP - Table 4.4 Avg)
            stInitCond.Tcl = 191.6542;                %Cold-Start Surrogate Threshold Temperature (g) (NCHRP - Table 4.4 Avg)
            stInitCond.CShc = 3.1046;                 %Cold-Start Engine-Out HC Emission Index Multiplier (-) (NCHRP - Table 4.4 Avg)
            stInitCond.CSnox = 2.7392;                %Cold-Start Engine-Out NOx Emission Index Multiplier (-) (NCHRP - Table 4.4 Avg)
            
        %Catalytic Converter Parameters
            stInitCond.GammaCO = 83.9969;             %Maximum Catalyst CO efficiency (%) (NCHRP - Table 4.4 Avg)
            stInitCond.GammaHC = 83.8765;             %Maximum Catalyst HC efficiency (%) (NCHRP - Table 4.4 Avg)
            stInitCond.GammaNOx = 68.7100;            %Maximum Catalyst NOx efficiency (%) (NCHRP - Table 4.4 Avg)
            stInitCond.bCOCAT = 0.1927;               %Stoichiometric CPF Coefficient for CO (1/(g/s)) (NCHRP - Table 4.4 Avg)
            stInitCond.bHCCAT = 0.1165;               %Stoichiometric CPF Coefficient for HC (1/(g/s)) (NCHRP - Table 4.4 Avg)
            stInitCond.bNOxCAT = 2.9562;              %Stoichiometric CPF Coefficient for NOx (1/(g/s)) (NCHRP - Table 4.4 Avg)
            stInitCond.cCOCAT = 4.6196;               %Enrichment CPF Coefficient for CO (1/(g/s)) (NCHRP - Table 4.4 Avg)
            stInitCond.cHCCAT = 2.4246;               %Enrichment CPF Coefficient for HC (1/(g/s)) (NCHRP - Table 4.4 Avg)
            stInitCond.cNOxCAT = 2.0419;              %Enrichment CPF Coefficient for NOx (1/(g/s)) (NCHRP - Table 4.4 Avg)
            stInitCond.LNOx = -80;                    %Dimensionless Constant (~-80) (NCHRP - Page 88)
                        
            
end

