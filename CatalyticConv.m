function [ stCatalyticConv ] = CatalyticConv( Data )

    %Minimum Measured Fuel-Air Equivalence Ratio
        PhiMin = min(Data.stOxyEnrichment.FuelAirEqRatio);
    
    %CPF for CO and HC
        stCatalyticConv.CoCPF = 1 - Data.stInitCond.GammaCO * exp(times((-Data.stInitCond.bCOCAT - Data.stInitCond.cCOCAT * (1 - Data.stOxyEnrichment.FuelAirEqRatio.^(-1))),Data.stCO2Emissions.QFuelConsume));
        stCatalyticConv.HcCPF = 1 - Data.stInitCond.GammaHC * exp(times((-Data.stInitCond.bHCCAT - Data.stInitCond.cHCCAT * (1 - Data.stOxyEnrichment.FuelAirEqRatio.^(-1))),Data.stCO2Emissions.QFuelConsume));

    %CPF for NOx
        for i = 1:Data.SizeData
            if Data.stOxyEnrichment.FuelAirEqRatio(i) == 1
                stCatalyticConv.Cat_EffNox(i) = (1 - Data.stInitCond.bNOxCAT * Data.stSuppEmissions.ENOxInstant(i)) * Data.stInitCond.GammaNOx;
            elseif Data.stOxyEnrichment.FuelAirEqRatio(i) > 1
                stCatalyticConv.Cat_EffNox(i) = (1 - Data.stInitCond.bNOxCAT * (1 - Data.stInitCond.cNOxCAT * (1 - Data.stOxyEnrichment.FuelAirEqRatio(i).^(-1))) * Data.stSuppEmissions.ENOxInstant(i)) * Data.stInitCond.GammaNOx;
            else
                stCatalyticConv.Cat_EffNox(i) = (Data.stInitCond.GammaNOx - stInitCond.LNOx) / (1 - PhiMin) * (Data.stOxyEnrichment.FuelAirEqRatio(i) - PhiMin) + stInitCond.LNOx;
            end
        end
        
        stCatalyticConv.NOxCPF = 1 - stCatalyticConv.Cat_EffNox/100;

end

