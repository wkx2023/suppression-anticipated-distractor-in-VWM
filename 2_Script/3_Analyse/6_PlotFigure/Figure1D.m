%% Behavioral_Performance


%% 行为数据
BeHa_File = 'G:\EEG_data\Behavioral\Task\';
Sub = [1101:1105,1107:1111,1113:1116,1118:1120,1122:1128,1130:1135];


for subi = 1:length(Sub) % 循环每个被试

    Sub_BeHa_File = strcat(BeHa_File,num2str(Sub(subi)),'_data.mat');
    Sub_BeHa_laod = load(Sub_BeHa_File);
    Sub_BeHa_Grating = abs(Sub_BeHa_laod.new_error(Sub_BeHa_laod.index_type_all == 1)) - mean(abs(Sub_BeHa_laod.new_error(Sub_BeHa_laod.index_type_all == 3)));
    Sub_BeHa_Moving = abs(Sub_BeHa_laod.new_error(Sub_BeHa_laod.index_type_all == 2)) - mean(abs(Sub_BeHa_laod.new_error(Sub_BeHa_laod.index_type_all == 3)));
    Sub_BeHa_Line = abs(Sub_BeHa_laod.new_error(Sub_BeHa_laod.index_type_all == 4)) - mean(abs(Sub_BeHa_laod.new_error(Sub_BeHa_laod.index_type_all == 3)));
 

    Gratig_Error(subi) = mean(abs(Sub_BeHa_Grating));
    Moving_Error(subi) = mean(abs(Sub_BeHa_Moving));
    Line_Error(subi) = mean(abs(Sub_BeHa_Line));



end

fig1 = figure();

[h,p_Grating,ci,stat]=ttest(Gratig_Error);
disp(p_Grating)
disp(stat)

[h,p_Moving,ci,stat]=ttest(Moving_Error);
disp(p_Moving)
disp(stat)

[h,p_Line,ci,stat]=ttest(Line_Error);
disp(p_Line)
disp(stat)

meanBar = [mean(Gratig_Error) mean(Moving_Error) mean(Line_Error)];
b = bar(meanBar);
b.FaceColor = 'flat';
b.CData(1,:) = [0.9020    0.9020    0.9804];
b.CData(2,:) = [0.8471    0.7490    0.8471];
b.CData(3,:) = [0.8667    0.6275    0.8667];

stdBar = [std(Gratig_Error)/sqrt(length(Gratig_Error)) std(Moving_Error)/sqrt(length(Moving_Error)) std(Line_Error)/sqrt(length(Line_Error))];
hold on
er = errorbar(meanBar,stdBar,"LineStyle","none");
er.Color = [0,0,0];
set(gca,'Xticklabel',{'Grating','Moving','Line'});
ylabel('Behavioral Bias','Fontsize',10)

if p_Grating<0.001 
    text(1,std(Gratig_Error)/sqrt(length(Gratig_Error))+mean(Gratig_Error)+0.51,'***','HorizontalAlignment','center','VerticalAlignment','bottom','FontSize',14);
elseif p_Grating<0.01 
    text(1,std(Gratig_Error)/sqrt(length(Gratig_Error))+mean(Gratig_Error)+0.51,'**','HorizontalAlignment','center','VerticalAlignment','bottom','FontSize',14);
elseif p_Grating<0.05
    text(1,std(Gratig_Error)/sqrt(length(Gratig_Error))+mean(Gratig_Error)+0.51,'*','HorizontalAlignment','center','VerticalAlignment','bottom','FontSize',14);
end

if p_Moving<0.001 
    text(2,std(Moving_Error)/sqrt(length(Moving_Error))+mean(Moving_Error)+0.51,'***','HorizontalAlignment','center','VerticalAlignment','bottom','FontSize',14);
elseif p_Moving<0.01 
    text(2,std(Moving_Error)/sqrt(length(Moving_Error))+mean(Moving_Error)+0.51,'**','HorizontalAlignment','center','VerticalAlignment','bottom','FontSize',14);
elseif p_Moving<0.05
    text(2,std(Moving_Error)/sqrt(length(Moving_Error))+mean(Moving_Error)+0.51,'*','HorizontalAlignment','center','VerticalAlignment','bottom','FontSize',14);
end

if p_Line<0.001 
    text(3,std(Line_Error)/sqrt(length(Line_Error))+mean(Line_Error)+0.51,'***','HorizontalAlignment','center','VerticalAlignment','bottom','FontSize',14);
elseif p_Line<0.01 
    text(3,std(Line_Error)/sqrt(length(Line_Error))+mean(Line_Error)+0.51,'**','HorizontalAlignment','center','VerticalAlignment','bottom','FontSize',14);
elseif p_Line<0.05
    text(3,std(Line_Error)/sqrt(length(Line_Error))+mean(Line_Error)+0.51,'*','HorizontalAlignment','center','VerticalAlignment','bottom','FontSize',14);
end



[h,p_GratingVMoving,ci,stat]=ttest(Gratig_Error,Moving_Error);
disp(p_GratingVMoving)
disp(stat)
if p_GratingVMoving<0.001 
    text(1.5,std(Gratig_Error)/sqrt(length(Gratig_Error))+mean(Gratig_Error)+0.7,'***','HorizontalAlignment','center','VerticalAlignment','bottom','FontSize',14);
elseif p_GratingVMoving<0.01 
    text(1.5,std(Gratig_Error)/sqrt(length(Gratig_Error))+mean(Gratig_Error)+0.7,'**','HorizontalAlignment','center','VerticalAlignment','bottom','FontSize',14);
elseif p_GratingVMoving<0.05
    text(1.5,std(Gratig_Error)/sqrt(length(Gratig_Error))+mean(Gratig_Error)+0.7,'*','HorizontalAlignment','center','VerticalAlignment','bottom','FontSize',14);
end

[h,p_GratingVLine,ci,stat]=ttest(Gratig_Error,Line_Error);
disp(p_GratingVLine)
disp(stat)
if p_GratingVLine<0.001 
    text(2,std(Gratig_Error)/sqrt(length(Gratig_Error))+mean(Gratig_Error)+0.7,'***','HorizontalAlignment','center','VerticalAlignment','bottom','FontSize',14);
elseif p_GratingVLine<0.01 
    text(2,std(Gratig_Error)/sqrt(length(Gratig_Error))+mean(Gratig_Error)+0.7,'**','HorizontalAlignment','center','VerticalAlignment','bottom','FontSize',14);
elseif p_GratingVLine<0.05
    text(2,std(Gratig_Error)/sqrt(length(Gratig_Error))+mean(Gratig_Error)+0.7,'*','HorizontalAlignment','center','VerticalAlignment','bottom','FontSize',14);
end

[h,p_MovingVLine,ci,stat]=ttest(Moving_Error,Line_Error);
disp(p_MovingVLine)
disp(stat)
if p_MovingVLine<0.001 
    text(2.5,std(Gratig_Error)/sqrt(length(Gratig_Error))+mean(Gratig_Error)+0.7,'***','HorizontalAlignment','center','VerticalAlignment','bottom','FontSize',14);
elseif p_MovingVLine<0.01 
    text(2.5,std(Gratig_Error)/sqrt(length(Gratig_Error))+mean(Gratig_Error)+0.7,'**','HorizontalAlignment','center','VerticalAlignment','bottom','FontSize',14);
elseif p_MovingVLine<0.05
    text(2.5,std(Gratig_Error)/sqrt(length(Gratig_Error))+mean(Gratig_Error)+0.7,'*','HorizontalAlignment','center','VerticalAlignment','bottom','FontSize',14);
end


box off



Group = [Gratig_Error',Moving_Error',Line_Error'];
t = table(Group(:,1),Group(:,2),Group(:,3),...
    'VariableNames',{'idx1','idx2','idx3'});
rm = fitrm(t,'idx1-idx3 ~ 1','WithinDesign',[1 2 3]);
ranovatbl = ranova(rm);
disp(ranovatbl);



% Figure Name
saveas(fig1,fullfile(resultsSave,['Behavioral_Performance','.svg']))
close(fig1)