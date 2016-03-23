%--------------------------------------------------------%
%EmissionsCalc_022116.m                                    %
%                                                        %
%The overall program used to identify emissions for the  %
%truck simulation. Will run sub-functions for collecting %
%data and processing emissions equations.                %
%                                                        %
%Make sure you have the settings correct for the FileName%
%vehicle type, and number of axels if running the        %
%calibration mode.                                       %
%--------------------------------------------------------%


clear all
clc
close all


    FileName = '\\gis-fs\DrivingStudy\ERDFiles\Run_b4e16a49-db6c-44bf-b50b-dc63d37bf671_22028_4.csv';


%% Decide which text data file and If analysis for the Car or Truck

%     %Open a new text file for extraction or a hardcoded file for testing
%         decideFILE = input('Which file for extraction? (n - NewFile or f - Filed)? \n \n','s');
% 
%        if decideFILE == 'f'
%             FileName = 'Data\HighwayTruck_FullThrottleNeutral_40mphMAX_StraightLineish.txt';   
%        elseif decideFILE == 'n'
%            FileName = input('What is the file name? \n \n','s');
%            FileName = strcat('Data\',FileName,'.txt');
%        end
%        
%        
%     %Car or Truck Input
%        decideVEHICLE = input('Is this a car or a truck? (c - Car or t - truck)? \n \n','s');
% 
%        if decideVEHICLE == 'c'
%            VEHICLE = 1; 
%        else
%            VEHICLE = 2;
%        end
%
%     %Number of Axles Input
%        NUMAXLE = input('How many axels does the vehicle have? (c - Car or t - truck)? \n \n','s');
%

%% Analysis Type

    SplitTitle = regexp(FileName, '[_.]', 'split');
    ParticipantNumberStr = SplitTitle(3);
    TrialNumberStr = SplitTitle(4);
    
    SplitParticipantNumber = str2double(regexp(char(ParticipantNumberStr),'\d','match'));
    LeaderBoardFile_Name = strcat('Data\LeaderBoardFile_',ParticipantNumberStr,'.txt');

    VEHICLE = 2; %1=Car; 2=Truck
    NUMAXLES = 2;
    EDUCATION = SplitParticipantNumber(1);
    CATEGORY = SplitParticipantNumber(2);
    TRIAL = str2double(SplitTitle(4)); 
    
    
%% Summary File
    
    SummaryFile_Name = char(strcat('Data\SummaryFile_',ParticipantNumberStr,'_',TrialNumberStr,'.txt'));
    fopen(SummaryFile_Name,'w');
    fileSummary = fopen(SummaryFile_Name,'a');
    
%% Grab Data from the File

    %Data = GrabPostData(FileName);
    Data.stLabelNames = LabelNames(FileName,NUMAXLES);
    
    Data.ParsedData = csvread(FileName,1);
    [Data.SizeData,~] = size(Data.ParsedData);
    
   
 %% Initital Conditions, Definitions, and Assumptions
    Data.stInitCond = InitCond(Data);
    
    
%% Total Distance Travelled
    Data.stDistanceTraveled = DistanceTravelled(Data);

    
%% Grab and Analyze CO2 Data for Emissions
    Data.stCO2Emissions = CO2Emissions(Data);         %Send to CO2 Emissions Function for Analysis
    
    
 %% Truck or Car Simulation Split
 
    switch VEHICLE
        
       case 1
        % Oxygen Enrichment Determination
            [Data.stOxyEnrichment,Data.stVehicleCalib] = OxyEnrichment(Data);
            
        % Grab and Analyze CO, NOx, SOx, and HC Engine-Out Emissions    
            Data.stSuppEmissions = SuppEmissionsCAR(Data);
            
        %Catalytic Converter Emissions
            Data.stCatalyticConv = CatalyticConv(Data);
            
        % Plots
            PlotFileCAR(Data);
            
       case 2
        % Grab and Analyze CO, NOx, SOx, and HC Emissions or Engine Output Data
            Data.stSuppEmissions = SuppEmissionsTRUCK(Data);

        % Plots
            PlotFileTRUCK(Data,LeaderBoardFile_Name{1,1},EDUCATION,CATEGORY,TRIAL);
            
    end
  

%% Total Carbon Release Message
    fprintf('\n%.2f gC02 were released with\n%.2f gCO2/mile in \n%.2f total miles.\n\n',Data.stCO2Emissions.CO2Release_Total*Data.stInitCond.kg_to_g,Data.stCO2Emissions.CO2Release_Avg_mi.Mfuel,Data.stDistanceTraveled.DistTrav_Total*Data.stInitCond.meters_to_mi);
    fprintf('%.2f gCO, %.2f gHC, and %.2f gNOx were released\n\n',Data.stSuppEmissions.COEmissionsTotal,Data.stSuppEmissions.HCEmissionsTotal,Data.stSuppEmissions.NOxEmissionsTotal);
    fprintf('%f gCO, %f gHC, and %f gNOx were released\n\n',Data.stSuppEmissions.COEmissionsTotal/(Data.stDistanceTraveled.DistTrav_Total*Data.stInitCond.meters_to_mi),Data.stSuppEmissions.HCEmissionsTotal/(Data.stDistanceTraveled.DistTrav_Total*Data.stInitCond.meters_to_mi),Data.stSuppEmissions.NOxEmissionsTotal/(Data.stDistanceTraveled.DistTrav_Total*Data.stInitCond.meters_to_mi));
    fprintf('MPG: %.2f\t KPG: %.2f\n\n',Data.stDistanceTraveled.DistTrav_Total*Data.stInitCond.meters_to_mi/(Data.ParsedData(Data.SizeData,Data.stLabelNames.Mfuel_Index)*Data.stInitCond.diesel_kg_to_gal),Data.stDistanceTraveled.DistTrav_Total*Data.stInitCond.meters_to_mi/Data.ParsedData(Data.SizeData,Data.stLabelNames.Mfuel_Index));
    fprintf('Total Time: %.0f:%.0f (mm:ss)\n\n',Data.stDistanceTraveled.TotalTimeMin,Data.stDistanceTraveled.TotalTimeSec);

    fprintf('CO2 Max: %f\t Sim CO2 Max: %f\n',Data.stInitCond.CO2EmMax,max(Data.stCO2Emissions.CO2EmissionsInstant.Mfuel));
    fprintf('CO2 Max: %.2f\t Sim CO2 Max: %.2f\n',Data.stInitCond.VelMax,max(Data.stDistanceTraveled.VelMag));

    fprintf(fileSummary,'%s\t %s\t %s\t %s\t %s\t %s\t %s\t %s\t\n','Trial Time(mm:ss)','Number of Stops (-)','Carbon Released (g)','Avg Velocity (mph)','Max Velocity (mph)','Total Distance (mi)','Max Accel (m/s^2)','Min Accel (m/s^2)','Avg Accel (m/s^2)');
    fprintf(fileSummary,'%.0f:%.0f\t %.0f\t %.2f\t %.2f\t %.2f\t %.2f\t %.2f\t %.2f\t',Data.stDistanceTraveled.TotalTimeMin,Data.stDistanceTraveled.TotalTimeSec,Data.stDistanceTraveled.NumStops_Total,Data.stCO2Emissions.CO2Release_Total*Data.stInitCond.kg_to_g,Data.stDistanceTraveled.VelMag_Avg*Data.stInitCond.kphTOmph,Data.stDistanceTraveled.VelMag_Max*Data.stInitCond.kphTOmph,Data.stDistanceTraveled.DistTrav_Total*Data.stInitCond.meters_to_mi,Data.stDistanceTraveled.AccelMag_Max,Data.stDistanceTraveled.AccelMag_Min,Data.stDistanceTraveled.AccelMag_Avg);
    
    if max(Data.stCO2Emissions.CO2EmissionsInstant.Mfuel) > Data.stInitCond.CO2EmMax || max(Data.stDistanceTraveled.VelMag) > Data.stInitCond.VelMax
        fprintf('\n\nCHANGE THE MAX VELOCITY OR CO2 EMISSIONS!!!!!!!\n\n');
    end
           
            
            
            