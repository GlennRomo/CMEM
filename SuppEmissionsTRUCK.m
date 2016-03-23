function [ stSuppEmissions ] = SuppEmissionsTRUCK( Data )

    %Instanaeous Emissions (g)
        stSuppEmissions.COEmissionsInstant = Data.stInitCond.aCO * Data.stCO2Emissions.InstantFuelCons.Mfuel * Data.stInitCond.kg_to_g + Data.stInitCond.CO;
        stSuppEmissions.HCEmissionsInstant = Data.stInitCond.aHC * Data.stCO2Emissions.InstantFuelCons.Mfuel * Data.stInitCond.kg_to_g + Data.stInitCond.rHC;
        stSuppEmissions.NOxEmissionsInstant = Data.stInitCond.aNOx * Data.stCO2Emissions.InstantFuelCons.Mfuel * Data.stInitCond.kg_to_g + Data.stInitCond.rNOx;

    %Cummulative Emissions (g)
        stSuppEmissions.COEmissionsCumm = cumsum(stSuppEmissions.COEmissionsInstant);
        stSuppEmissions.HCEmissionsCumm = cumsum(stSuppEmissions.HCEmissionsInstant);
        stSuppEmissions.NOxEmissionsCumm = cumsum(stSuppEmissions.NOxEmissionsInstant);
    
    %Total Emissions (g)
        stSuppEmissions.COEmissionsTotal = stSuppEmissions.COEmissionsCumm(Data.SizeData-1);
        stSuppEmissions.HCEmissionsTotal = stSuppEmissions.HCEmissionsCumm(Data.SizeData-1);
        stSuppEmissions.NOxEmissionsTotal = stSuppEmissions.NOxEmissionsCumm(Data.SizeData-1);
    

end

