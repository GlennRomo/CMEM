function [] = PlotFileTRUCK(Data,LeaderBoardFile_Name,EDUCATION,CATEGORY,TRIAL)

%{
    %Instantaneous Carbon Release and Vehicle Dynamics Plot
        figure('Name','CO2, Velocity, and Position Plot')
            InstCarbDiox_Plot = subplot(3,1,1);
            plot(Data.ParsedData(2:Data.SizeData,Data.stLabelNames.Time_Index),Data.stCO2Emissions.CO2EmissionsInstant.Mfuel.*Data.stInitCond.kg_to_g)
            title('Instantaneous Carbon Dioxide Released');
            xlabel('Time (s)');
            ylabel('Carbon Dioxide (g)');

            VehVelocity_Plot = subplot(3,1,2);
            plot(Data.ParsedData(1:Data.SizeData,Data.stLabelNames.Time_Index),Data.stDistanceTraveled.VelMag*Data.stInitCond.kphTOmph)
            title('Vehicle Velocity');
            xlabel('Time (s)');
            ylabel('Velocity (mph)');

            DistTrav_Plot = subplot(3,1,3);
            plot(Data.ParsedData(1:Data.SizeData,Data.stLabelNames.Time_Index),Data.stDistanceTraveled.InstantDistTrav*Data.stInitCond.meters_to_mi)
            title('Distance');
            xlabel('Time (s)');
            ylabel('Instant Distance Travelled (mi)');

            linkaxes([InstCarbDiox_Plot,VehVelocity_Plot,DistTrav_Plot],'x')


    %Cummulative Emissions Plot
        figure('Name','Cummulative Emissions Plot')
            CO2EmissionsCummPlot = subplot(4,1,1);
            plot(Data.ParsedData(2:Data.SizeData,Data.stLabelNames.Time_Index),Data.stCO2Emissions.CO2EmissionsCumm*Data.stInitCond.kg_to_g)
            title('Cummulative Carbon Dioxide Released');
            xlabel('Time (s)');
            ylabel('Carbon Dioxide (g)');
        
            COEmissionsCummPlot = subplot(4,1,2);
            plot(Data.ParsedData(2:Data.SizeData,Data.stLabelNames.Time_Index),Data.stSuppEmissions.COEmissionsCumm)
            title('Cummulative Carbon Monoxide Released');
            xlabel('Time (s)');
            ylabel('Carbon Monoxide (g)');

            HCEmissionsCummPlot = subplot(4,1,3);
            plot(Data.ParsedData(2:Data.SizeData,Data.stLabelNames.Time_Index),Data.stSuppEmissions.HCEmissionsCumm)
            title('Cummulative Hydrocarbon Released');
            xlabel('Time (s)');
            ylabel('Hydrocarbons (g)');

            NOxEmissionsCummPlot = subplot(4,1,4);
            plot(Data.ParsedData(2:Data.SizeData,Data.stLabelNames.Time_Index),Data.stSuppEmissions.NOxEmissionsCumm)
            title('Cummulative Nitrous Oxide Released');
            xlabel('Time (s)');
            ylabel('Nitrous Oxide (g)');

            linkaxes([CO2EmissionsCummPlot,COEmissionsCummPlot,HCEmissionsCummPlot,NOxEmissionsCummPlot],'x')

    %Instantaneous Emissions Plot
        figure('Name','Instantaneous Emissions Plot')
            CO2EmissionsInstantPlot = subplot(4,1,1);
            plot(Data.ParsedData(2:Data.SizeData,Data.stLabelNames.Mfuel_Index-1),Data.stCO2Emissions.CO2EmissionsInstant*Data.stInitCond.kg_to_g)
            title('Instantaneous Carbon Dioxide Released');
            xlabel('Time (s)');
            ylabel('Carbon Dioxide (g)');
        
            COEmissionsInstantPlot = subplot(4,1,2);
            plot(Data.ParsedData(2:Data.SizeData,Data.stLabelNames.Time_Index),Data.stSuppEmissions.COEmissionsInstant)
            title('Instantaneous Carbon Monoxide Released');
            xlabel('Time (s)');
            ylabel('Carbon Monoxide (g)');

            HCEmissionsInstantPlot = subplot(4,1,3);
            plot(Data.ParsedData(2:Data.SizeData,Data.stLabelNames.Time_Index),Data.stSuppEmissions.HCEmissionsInstant)
            title('Instantaneous Hydrocarbon Released');
            xlabel('Time (s)');
            ylabel('Hydrocarbons (g)');

            NOxEmissionsInstantPlot = subplot(4,1,4);
            plot(Data.ParsedData(2:Data.SizeData,Data.stLabelNames.Time_Index),Data.stSuppEmissions.NOxEmissionsInstant)
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
            plot(Data.ParsedData(2:Data.SizeData,Data.stLabelNames.Time_Index),Data.stCO2Emissions.CO2EmissionsInstant.Mfuel.*Data.stInitCond.kg_to_g)
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
            plot(Data.ParsedData(1:Data.SizeData,Data.stLabelNames.Time_Index),Data.stDistanceTraveled.AccelMag(1:Data.SizeData))
            title('Vehicle Acceleration');
            xlabel('Time (s)');
            ylabel('Acceleration (m/s^2)');

            linkaxes([InstCarbDiox_Plot2,Bk_DepressionPlot,Throttle_DepressionPlot,Vehicle_AccelPlot],'x')
%}

%%

        %Gradient Plots (CO2,Throttle,Brake,Velocity)
            CO2Emissions_Normalized = [Data.stCO2Emissions.CO2EmissionsInstant.Mfuel/Data.stInitCond.CO2EmMax;Data.stCO2Emissions.CO2EmissionsInstant.Mfuel(Data.SizeData-1)/Data.stInitCond.CO2EmMax];
            Velocity_Normalized = Data.stDistanceTraveled.VelMag/Data.stInitCond.VelMax;
            Acceleration_Normalized = (Data.ParsedData(:,Data.stLabelNames.Pbk_Con_Index)/Data.stInitCond.AccelMax);

            MarkerSize = 5;
            VelProfile = round([0 Data.stInitCond.VelMax*0.2 Data.stInitCond.VelMax*0.4 Data.stInitCond.VelMax*0.6 Data.stInitCond.VelMax*0.8 ]*Data.stInitCond.kphTOmph);

            set(0,'units','pixels')
            Pix_SS = get(0,'screensize');
            fontCOLOR = [0.7 0.3 0.3];
            tboxCOLOR = 0.2*[1 1 1];
            subplotSIZEFactor = 1.8;
            subplotPOSFactor1 = 0;
            subplotPOSFactor2 = 0.8;

            im = imread('Map2.jpg');
                [vertIM,horIM,~] = size(im);
                im = flipud(im);
                xLimit = -1175;     %For Map2
                yLimit = -1330;
                xWorldLimits = [xLimit,xLimit+horIM*1.792];
                yWorldLimits = [yLimit,yLimit+vertIM*1.792];

    %             xLimit = -1225;  %For Map1
    %             yLimit = -1320;
    %             xWorldLimits = [xLimit,xLimit+horIM*1.8];
    %             yWorldLimits = [yLimit,yLimit+vertIM*1.8];
                RA = imref2d(size(im),xWorldLimits,yWorldLimits);
                
                
    if EDUCATION == 2

            GradientsPlots = figure();
                set(GradientsPlots,'Position',[0 0 Pix_SS(3)/2 Pix_SS(4)])

                h = hot(100);
                colormap(flipud(colormap(h(20:100,:))));

                CO2_GradientPlot = subplot_tight(2,2,1,[0.05 0.11]);
                    hold on
                        imshow(im,RA)
                        %imshow(im,'XData',[Data.stInitCond.MapWindow(1),Data.stInitCond.MapWindow(2)],'YData',[Data.stInitCond.MapWindow(3),Data.stInitCond.MapWindow(4)])
                        %image([Data.stInitCond.MapWindow(1)-500,Data.stInitCond.MapWindow(2)+200],[Data.stInitCond.MapWindow(3),Data.stInitCond.MapWindow(4)],im)
                        scatter(flipud(Data.ParsedData(:,Data.stLabelNames.Xo_Index)),flipud(Data.ParsedData(:,Data.stLabelNames.Yo_Index)),MarkerSize,flipud(CO2Emissions_Normalized)*0.8,'s');

                        set(gca,'Color',tboxCOLOR);
                            set(gca,'xdir','reverse')
                            sp1Position = get(CO2_GradientPlot,'position');
                            sp1Position(1) = sp1Position(1)*subplotPOSFactor1;
                            sp1Position(3) = sp1Position(3)*subplotSIZEFactor;
                            set(CO2_GradientPlot,'Position',sp1Position)
                            c = colorbar;
                            caxis([0,1])
                            set(CO2_GradientPlot,'XTick',[],'YTick',[]);
                            set(c,'YTick',[0.001,0.999])
                            set(c,'YTicklabel',{'Low','High'}) %{{' ',' ',' ',' '}}



                        axis equal
                        axis(Data.stInitCond.MapWindow);
            %             freezeColors
            %             cbfreeze(c)
                        title('CO2 Emissions');


                    hold off

                Velocity_GradientPlot = subplot_tight(2,2,2,[0.05 0.11]);
                    hold on
                        imshow(im,RA)
                        scatter(flipud(Data.ParsedData(:,Data.stLabelNames.Xo_Index)),flipud(Data.ParsedData(:,Data.stLabelNames.Yo_Index)),MarkerSize,flipud(Velocity_Normalized),'s');

                        set(gca,'Color',tboxCOLOR);
                            set(gca,'xdir','reverse')
                            sp2Position = get(Velocity_GradientPlot,'position');
                            sp2Position(1) = sp2Position(1)*subplotPOSFactor2;
                            sp2Position(3) = sp2Position(3)*subplotSIZEFactor;
                            set(Velocity_GradientPlot,'Position',sp2Position)
                            c = colorbar;
                            caxis([0,1])
                            set(Velocity_GradientPlot,'XTick',[],'YTick',[]);
                            set(c,'YTick',[0 0.2 0.4 0.6 0.8 1.0])
                            set(c,'YTicklabel',{'0','12.5','25.0','37.5','50.0','62.5'}) %VelProfile

                        axis equal
                        axis(Data.stInitCond.MapWindow);
                        title('Speed (mph)');
                    hold off

                Throttle_GradientPlot = subplot_tight(2,2,3,[0.05 0.11]);
                    hold on
                        imshow(im,RA)
                        scatter(flipud(Data.ParsedData(:,Data.stLabelNames.Xo_Index)),flipud(Data.ParsedData(:,Data.stLabelNames.Yo_Index)),MarkerSize,flipud(Data.ParsedData(:,Data.stLabelNames.Throttle_Index)),'s');

                        set(gca,'Color',tboxCOLOR);
                            set(gca,'xdir','reverse')
                            sp3Position = get(Throttle_GradientPlot,'position');
                            sp3Position(1) = sp3Position(1)*subplotPOSFactor1;
                            sp3Position(3) = sp3Position(3)*subplotSIZEFactor;
                            set(Throttle_GradientPlot,'Position',sp3Position)
                            c = colorbar;
                            caxis([0,1])
                            set(Throttle_GradientPlot,'XTick',[],'YTick',[]);
                            set(c,'YTick',[0.001 0.999])
                            set(c,'YTicklabel',{'Low','High'}) %{'Light',' ',' ','Heavy'}

                        axis equal
                        axis(Data.stInitCond.MapWindow);
            %             freezeColors 
            %             cbfreeze(c)
                        title('Gas Pedal');
                    hold off

                %lineEFF = [0:1.7822e-04:2];

                Brake_GradientPlot = subplot_tight(2,2,4,[0.05 0.11]);
                    hold on
                        imshow(im,RA)
                        scatter(flipud(Data.ParsedData(:,Data.stLabelNames.Xo_Index)),flipud(Data.ParsedData(:,Data.stLabelNames.Yo_Index)),MarkerSize,flipud(Acceleration_Normalized(:,1)),'s'); %Data.ParsedData(:,Data.stLabelNames.Pbk_Con_Index)

                        set(gca,'Color',tboxCOLOR);
                            set(gca,'xdir','reverse')
                            sp4Position = get(Brake_GradientPlot,'position');
                            sp4Position(1) = sp4Position(1)*subplotPOSFactor2;
                            sp4Position(3) = sp4Position(3)*subplotSIZEFactor;
                            set(Brake_GradientPlot,'Position',sp4Position)
                            c = colorbar;
                            caxis([0,1])
                            set(Brake_GradientPlot,'XTick',[],'YTick',[]);
                            set(c,'YTick',[0.001 0.999])
                            set(c,'YTicklabel',{'Low','High'})

                        axis equal
                        axis(Data.stInitCond.MapWindow);
                        title('Brake Pedal');
                    hold off
    end
    
%%            
            
    %Leader Board Box
    
        %FileExistName = LeaderBoardFile_Name{1,1};
    
        if CATEGORY == 2
            
            if TRIAL == 4 || TRIAL == 5 || TRIAL == 6
            
                fontCOLORwhite = [1 1 1];
                fontCOLORgreen = [0 1 0];
                fontCOLORyellow = [1 1 0];

                if TRIAL == 4

                    ScoreOrder(1) = Data.stCO2Emissions.CO2Release_Total*Data.stInitCond.kg_to_g*Data.stInitCond.LeaderBoard1;
                    ScoreOrder(2) = Data.stCO2Emissions.CO2Release_Total*Data.stInitCond.kg_to_g*Data.stInitCond.LeaderBoard2;
                    ScoreOrder(3) = Data.stCO2Emissions.CO2Release_Total*Data.stInitCond.kg_to_g;
                    ScoreOrder(4) = Data.stCO2Emissions.CO2Release_Total*Data.stInitCond.kg_to_g*Data.stInitCond.LeaderBoard4;
                    ScoreOrder(5) = Data.stCO2Emissions.CO2Release_Total*Data.stInitCond.kg_to_g*Data.stInitCond.LeaderBoard5;
                    ScoreOrder(6) = Data.stCO2Emissions.CO2Release_Total*Data.stInitCond.kg_to_g*Data.stInitCond.LeaderBoard6;

                    CurrentScoreLocation = 3;

                    ScoreStr = [sprintf('1     %.1f   Leader',ScoreOrder(1));
                                sprintf('2     %.1f         ',ScoreOrder(2));
                                sprintf('3     %.1f   YOU   ',ScoreOrder(3));
                                sprintf('4     %.1f         ',ScoreOrder(4));
                                sprintf('5     %.1f         ',ScoreOrder(5));
                                sprintf('6     %.1f         ',ScoreOrder(6));];

                    ScoreColor = [fontCOLORgreen;
                                  fontCOLORwhite;
                                  fontCOLORyellow;
                                  fontCOLORwhite;
                                  fontCOLORwhite;
                                  fontCOLORwhite];

                elseif (TRIAL == 5 && exist(LeaderBoardFile_Name, 'file') == 2) || (TRIAL == 6 && exist(LeaderBoardFile_Name, 'file') == 2)

                    Trial4Scores = dataread('file',LeaderBoardFile_Name, '%f','delimiter', '\t');

                    CurrentScore = Data.stCO2Emissions.CO2Release_Total*Data.stInitCond.kg_to_g;

                    %[FirstScore,SecondScore,ThirdScore,FourthScore,FifthScore,SixthScore]
                    NewScores = [Trial4Scores; CurrentScore];
                    ScoreOrder = transpose(sort(NewScores));
                    CurrentScoreLocation = find(ScoreOrder == CurrentScore);

                    TitleStr = sprintf('Place    Score');

                    ScoreStr = [sprintf('1     %.1f   Leader',ScoreOrder(1));
                                sprintf('2     %.1f         ',ScoreOrder(2));
                                sprintf('3     %.1f         ',ScoreOrder(3));
                                sprintf('4     %.1f         ',ScoreOrder(4));
                                sprintf('5     %.1f         ',ScoreOrder(5));
                                sprintf('6     %.1f         ',ScoreOrder(6));];

                    ScoreColor = [fontCOLORgreen;
                                  fontCOLORwhite;
                                  fontCOLORwhite;
                                  fontCOLORwhite;
                                  fontCOLORwhite;
                                  fontCOLORwhite];

                    ScoreStr(CurrentScoreLocation,:) = sprintf('%.0f     %.1f   YOU   ',CurrentScoreLocation,CurrentScore);

                    if CurrentScoreLocation > 1
                        ScoreColor(CurrentScoreLocation,:) = fontCOLORyellow;
                    end

                end

                FileLeaderBoard = fopen(char(LeaderBoardFile_Name),'w');
                fprintf(FileLeaderBoard,'%.1f\t %.1f\t %.1f\t %.1f\t %.1f\t %.1f\t',ScoreOrder(1),ScoreOrder(2),ScoreOrder(3),ScoreOrder(4),ScoreOrder(5),ScoreOrder(6));

                TitleStr = sprintf('Place    Score');

                topSPACING = Pix_SS(4)/2+300;
                midSPACING = Pix_SS(4)/2+280;
                rowSPACING = 50;

                leftSPACING = Pix_SS(3)/2-75;
                midleftSPACING = Pix_SS(3)/2+135;
                colSPACING = 50;
                fontSIZEscore = 25;

                lFigure = figure();
                    set(0,'units','pixels')
                        Pix_SS = get(0,'screensize');

                    figSIZE = get(lFigure,'Position');
                        set(lFigure,'Position',[Pix_SS(3)/2 0 Pix_SS(3)/2 Pix_SS(4)])
                        set(gcf,'Color',tboxCOLOR);

                    scoreTextBox = uicontrol('style','text');
                        set(scoreTextBox,'String',TitleStr,'Units','pixels','Position', [0 0 leftSPACING topSPACING],'backgroundcolor',tboxCOLOR,'fontsize',32,'ForegroundColor',fontCOLORwhite)

                    numTextBox(1) = uicontrol('style','text');
                        set(numTextBox(1),'String',ScoreStr(1,:),'Units','pixels','Position', [0 0 midleftSPACING midSPACING-rowSPACING],'backgroundcolor',tboxCOLOR,'fontsize',fontSIZEscore,'ForegroundColor',ScoreColor(1,:),'FontName','FixedWidth','FontWeight','bold')
                    numTextBox(2) = uicontrol('style','text');
                        set(numTextBox(2),'String',ScoreStr(2,:),'Units','pixels','Position', [0 0 midleftSPACING midSPACING-rowSPACING*2],'backgroundcolor',tboxCOLOR,'fontsize',fontSIZEscore,'ForegroundColor',ScoreColor(2,:),'FontName','FixedWidth','FontWeight','bold')
                    numTextBox(3) = uicontrol('style','text');
                        set(numTextBox(3),'String',ScoreStr(3,:),'Units','pixels','Position', [0 0 midleftSPACING midSPACING-rowSPACING*3],'backgroundcolor',tboxCOLOR,'fontsize',fontSIZEscore,'ForegroundColor',ScoreColor(3,:),'FontName','FixedWidth','FontWeight','bold')
                    numTextBox(4) = uicontrol('style','text');
                        set(numTextBox(4),'String',ScoreStr(4,:),'Units','pixels','Position', [0 0 midleftSPACING midSPACING-rowSPACING*4],'backgroundcolor',tboxCOLOR,'fontsize',fontSIZEscore,'ForegroundColor',ScoreColor(4,:),'FontName','FixedWidth','FontWeight','bold')
                    numTextBox(5) = uicontrol('style','text');
                        set(numTextBox(5),'String',ScoreStr(5,:),'Units','pixels','Position', [0 0 midleftSPACING midSPACING-rowSPACING*5],'backgroundcolor',tboxCOLOR,'fontsize',fontSIZEscore,'ForegroundColor',ScoreColor(5,:),'FontName','FixedWidth','FontWeight','bold')
                    numTextBox(6) = uicontrol('style','text');
                        set(numTextBox(6),'String',ScoreStr(6,:),'Units','pixels','Position', [0 0 midleftSPACING midSPACING-rowSPACING*6],'backgroundcolor',tboxCOLOR,'fontsize',fontSIZEscore,'ForegroundColor',ScoreColor(6,:),'FontName','FixedWidth','FontWeight','bold')

    %                 numTextBox(CurrentScoreLocation) = uicontrol('style','text');
    %                     set(numTextBox(CurrentScoreLocation),'String',ScoreStr(CurrentScoreLocation,:),'Units','pixels','Position', [0 0 midleftSPACING midSPACING-rowSPACING*CurrentScoreLocation],'backgroundcolor',tboxCOLOR,'fontsize',fontSIZEscore,'ForegroundColor',fontCOLORyellow,'FontName','FixedWidth','FontWeight','bold')
  
            end
        end
%%            
            
    %Grams of Carbon Message Box
    
        if CATEGORY == 2 || CATEGORY == 3
    
            CO2TotalStr = sprintf('%.2f grams', Data.stCO2Emissions.CO2Release_Total*Data.stInitCond.kg_to_g);    
            CO2str = sprintf('of Carbon were released');

            mFigure = figure();
                set(0,'units','pixels')
                    Pix_SS = get(0,'screensize');

                figSIZE = get(mFigure,'Position');
                    set(mFigure,'Position',[Pix_SS(3)/2 0 Pix_SS(3)/2 Pix_SS(4)])
                    set(gcf,'Color',tboxCOLOR);

                mTextBox = uicontrol('style','text');
                    set(mTextBox,'String',CO2TotalStr)
                    set(mTextBox,'Units','pixels')
                    set(mTextBox,'Position', [0 0 Pix_SS(3)/2-20 Pix_SS(4)/2+200])
                    set(mTextBox,'backgroundcolor',tboxCOLOR)
                    set(mTextBox,'fontsize',68)
                    set(mTextBox,'ForegroundColor',fontCOLOR)


                mTextBox1 = uicontrol('style','text');
                    set(mTextBox1,'String',CO2str)
                    set(mTextBox1,'Units','pixels')
                    set(mTextBox1,'Position', [0 0 Pix_SS(3)/2-30 Pix_SS(4)/2+60])
                    set(mTextBox1,'backgroundcolor',tboxCOLOR)
                    set(mTextBox1,'fontsize',36)
                    set(mTextBox1,'ForegroundColor',fontCOLOR)

        end

%%
            
%{
%%                
    %Instantaneous Carbon Release and Vehicle Dynamics Plot
        figure('Name','EngSpeed CO2')
            plot(Data.ParsedData(1:Data.SizeData,Data.stLabelNames.Time_Index),Data.stCO2Emissions.CO2EmissionsInstant.EngSpeedPower/max(Data.stCO2Emissions.CO2EmissionsInstant.EngSpeedPower)) %.*Data.stInitCond.kg_to_g
            hold on
            title('Instantaneous Carbon Dioxide Released');
            xlabel('Time (s)');
            ylabel('Carbon Dioxide (g)');
            
%             
%     %Instantaneous Carbon Release and Vehicle Dynamics Plot
%         figure('Name','Mfuel CO2')
            plot(Data.ParsedData(2:Data.SizeData,Data.stLabelNames.Time_Index),(Data.stCO2Emissions.CO2EmissionsInstant.Mfuel/max(Data.stCO2Emissions.CO2EmissionsInstant.Mfuel)),'g')
%             title('Instantaneous Carbon Dioxide Released');
%             xlabel('Time (s)');
%             ylabel('Carbon Dioxide (g)');
            legend('EnginePower','Mfuel')
%}    

end

