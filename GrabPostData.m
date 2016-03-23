%-------------------------------------------------------%
%GrabPostData.m                                         %
%                                                       %
%Takes post data from TruckSim 8.4 simulation for       %
%several variables. Places the variables into an array  %
%called ParsedData and returns the array to the         %
%governing function call.                               %
%-------------------------------------------------------%


function Output = GrabPostData(FileName)

    count = 2;      %Overall Data Index Counter
    count1 = 1;     %Inner Data Set Index Counter
    headCount = 1;  %Number of Variable Set Headers
    true = 1;       %Initial Set to Grab String Headers for first data set
    varSets = -1;   %Number of variable sets counter for indexing

    %Dump entire file into the DataBulkArray variable
    DataBulkArray = dataread('file',FileName, '%s','delimiter', '\t');

    

    %Size for the logic unit of when to stop the 'file reading loop'
    [sizeArray,~] = size(DataBulkArray);
    EvOdd = mod(sizeArray,2);


    %'File reading loop' and determing if we have data in our next dataline
    while count < sizeArray && isempty(DataBulkArray{count}) == 0

        count = count + 1;

        if true == 1
            count = count + 1;

            Output.VarHeader(headCount,1) = cellstr(DataBulkArray{count-2});    %Add both Header Strings
            Output.VarHeader(headCount,2) = cellstr(DataBulkArray{count-1});    %to Header Array

            headCount = headCount + 1;
            true = 0;
            varSets = varSets + 2;      %Start next variable set down two index values for new set
            count1 = 1;                 %Reset Inner Indexing Counter to Zero
        end

        while count < sizeArray && all(ismember(DataBulkArray{count}, '0123456789+-.eEdD')) > 0

            DataString = DataBulkArray{count};      %Take next data point for processing
            DataString2 = DataBulkArray{count+1};

            Output.ParsedData(count1,varSets) = str2num(DataString);    %Convert string and save num value
            Output.ParsedData(count1,varSets+1) = str2num(DataString2); %into Output Structure

            count = count + 2;         %Added two for the two numbers processed
            count1 = count1+1;         %inner count higher
            true = 1;                  %Unnecessary now that the known For-Loop Length is used

        end
        
        [Output.SizeData,~] = size(Output.ParsedData);
        break
        
    end
    
    Output.NumVars = round(sizeArray / (Output.SizeData*2 + 2)); %Variable Set Numbers for Known Number
                                                          %of variables
    
    
    
    %Known Variable Set Length For-Loop Data Extractor - Follow the same
    %instructions for the earlier loop and this just knows the lengths of
    %the needed data points
    for setsCount = 2:Output.NumVars
        
        Output.VarHeader(headCount,1) = cellstr(DataBulkArray{count});
        Output.VarHeader(headCount,2) = cellstr(DataBulkArray{count+1});

        count = count + 2;
        headCount = headCount + 1;
        varSets = varSets + 2;
        count1 = 1;
    
        for dataCount = 1:Output.SizeData

            DataString = DataBulkArray{count};
            DataString2 = DataBulkArray{count+1};
            
            Output.ParsedData(dataCount,varSets) = str2num(DataString);
            Output.ParsedData(dataCount,varSets+1) = str2num(DataString2);
            
            count = count + 2;
            count1 = count1+1;
        end
    end
    
end
