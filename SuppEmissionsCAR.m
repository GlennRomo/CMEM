function [ stSuppEmissions ] = SuppEmissionsCAR( Data )

    %Specific Power
        stSuppEmissions.SP(:,1) = 2 * Data.stDistanceTraveled.VelMag(:,1);
        stSuppEmissions.dSP_dt = (stSuppEmissions.SP(2:Data.SizeData) - stSuppEmissions.SP(1:Data.SizeData-1)) / Data.stInitCond.time_step;

    %Instanaeous Emissions (g)
    
        %Carbon Monoxide
            stSuppEmissions.COEmissionsInstant(:,1) = (Data.stInitCond.EngOUTCo * ( 1 - 1/Data.stOxyEnrichment.FuelAirEqRatio(:)) + Data.stInitCond.Aco) .* transpose(Data.stCO2Emissions.QFuelConsume(:));
            
        %Hydrocarbons
        
            %EHC-comb (Stoichiometric and Enrichment Conditions)
                stSuppEmissions.EHCcomb = Data.stInitCond.Ahc * Data.stCO2Emissions.QFuelConsume(:) + Data.stInitCond.Rhc;
            
            %EHC-lean-trans (Associated with Rapid Load Changes)
                for i = 1:Data.SizeData
                        if Data.stDistanceTraveled.AccelMag(i).*Data.stInitCond.AccelGrav < 0 && abs(stSuppEmissions.dSP_dt(i)) > Data.stInitCond.dSPdtTH
                            stSuppEmissions.EHCleantrans(i) = Data.stInitCond.HCtrans * ( abs(stSuppEmissions.dSP_dt(i)) - Data.stInitCond.dSPdtTH );
                        else
                            stSuppEmissions.EHCleantrans(i) = 0;
                        end
                end
            
            %EHC-lean-release (Associated with Long Deceleration Events)
                HCLeanSummation = 0;
            
                for i = 1:Data.SizeData
                    if Data.ParsedData(i,Data.stLabelNames.PwrEngO_Index) < 0
                        stSuppEmissions.EHCleanreleaseNoCold(i) = (Data.stInitCond.rR * Data.stInitCond.time_step) * (Data.stInitCond.bHC - HCLeanSummation);
                        HCLeanSummation = HCLeanSummation + stSuppEmissions.EHCleanreleaseNoCold(i);
                    elseif Data.ParsedData(i,Data.stLabelNames.PwrEngO_Index) >= 0
                        stSuppEmissions.EHCleanreleaseNoCold(i) = 0;
                        HCLeanSummation = 0;
                    end
                                        
                    %HC Temperature Multiplication Factor
                    if Data.ParsedData(i,Data.stLabelNames.Mfuel_Index) < Data.stInitCond.Tcl
                        stSuppEmissions.EHCleanrelease(i) = (1 + (Data.stInitCond.CShc - 1) * (Data.stInitCond.Tcl - Data.ParsedData(i,Data.stLabelNames.Mfuel_Index)) / Data.stInitCond.Tcl) * stSuppEmissions.EHCleanreleaseNoCold(i);
                    else
                        stSuppEmissions.EHCleanrelease(i) = stSuppEmissions.ENOxInstantNoCold(i);
                    end
                end
                
            %Emissions of Hydrocarbons
                stSuppEmissions.HCEmissionsInstant = transpose(stSuppEmissions.EHCcomb) + stSuppEmissions.EHCleantrans + stSuppEmissions.EHCleanrelease;
        
            
        %Nitrogen Oxides
            
            %NOx Emissions
                for i = 1:Data.SizeData
                        if Data.stCO2Emissions.QFuelConsume(i) < Data.stInitCond.FRno1
                            stSuppEmissions.ENOxInstantNoCold(i) = 0;
                        elseif Data.stOxyEnrichment.FuelAirEqRatio(i,1) < 1.05
                            stSuppEmissions.ENOxInstantNoCold(i) = Data.stInitCond.a1NOx * ( Data.stCO2Emissions.QFuelConsume(i) + Data.stInitCond.FRno1 );
                        elseif Data.stOxyEnrichment.FuelAirEqRatio(i,1) >= 1.05
                            stSuppEmissions.ENOxInstantNoCold(i) = Data.stInitCond.a2NOx * ( Data.stCO2Emissions.QFuelConsume(i) + Data.stInitCond.FRno2 );
                        end
                        
                        %NOx Temperature Multiplication Factor
                        if Data.ParsedData(i,Data.stLabelNames.Mfuel_Index) < Data.stInitCond.Tcl
                            stSuppEmissions.ENOxInstant(i) = (1 + (Data.stInitCond.CSnox - 1) * (Data.stInitCond.Tcl - Data.ParsedData(i,Data.stLabelNames.Mfuel_Index)) / Data.stInitCond.Tcl) * stSuppEmissions.ENOxInstantNoCold(i);
                        else
                            stSuppEmissions.ENOxInstant(i) = stSuppEmissions.ENOxInstantNoCold(i);
                        end
                end
            
    %Cummulative Emissions (g)
        stSuppEmissions.COEmissionsCumm = cumsum(stSuppEmissions.COEmissionsInstant);
        stSuppEmissions.HCEmissionsCumm = cumsum(transpose(stSuppEmissions.HCEmissionsInstant));
        stSuppEmissions.NOxEmissionsCumm = cumsum(transpose(stSuppEmissions.ENOxInstant));
    
    %Total Emissions (g)
        stSuppEmissions.COEmissionsTotal = stSuppEmissions.COEmissionsCumm(Data.SizeData,1);
        stSuppEmissions.HCEmissionsTotal = stSuppEmissions.HCEmissionsCumm(Data.SizeData-1);
        stSuppEmissions.NOxEmissionsTotal = stSuppEmissions.NOxEmissionsCumm(Data.SizeData-1);
    

end

