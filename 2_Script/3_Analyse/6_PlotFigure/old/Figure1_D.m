%% Distractor/Target_Dynamicism Index 2026-01-06 wkx

% 读取所有的聚类元素
% 只截取100-996ms的所有数据
clear

cluster_files_Distractor = 'G:\Function_Matlab\SVM\OneDay\mat\Final\Cluster\';
cluster_files_Target = 'G:\Function_Matlab\SVM\OneDay\mat\Final\Cluster\';

resultsSave = 'G:\Function_Matlab\WM_Distractor\Figure_E1\';

times = [-600:4:996];
timesC = find(times==100);
timesS = find(times==996);
timesPlot = [100:4:996];
xTable = [100,300,500,700,900];


cluster_T = strcat(cluster_files_Target,'Cluster_con.mat');
cluster_T = load(cluster_T);
cluster_T = cluster_T.Cluster_5;
cluster_T = cluster_T(timesC:timesS,timesC:timesS); % time * time
Dynamic_T = dynamicism_v2(cluster_T);


cluster_D = strcat(cluster_files_Distractor,'Dynamic_task_Rand_Final','.mat');
cluster_D = load(cluster_D);
cluster_D = cluster_D.Cluster_task_P5;
cluster_D = cluster_D(:,timesC:timesS,timesC:timesS); % cir * time * time
Dynamic_D_Rand = NaN(size(cluster_D,1),size(cluster_D,2));
for cir = 1:size(cluster_D,1)  
    Dynamic_D = dynamicism_v2(squeeze(cluster_D(cir,:,:)));
    Dynamic_D_Rand(cir,:) = Dynamic_D;
end



color_plot =[149 79 151]/255;
colorCon_plot =[58 181 179]/255;
colors = [color_plot;colorCon_plot];



%% Figure 
fig1 = figure;
set(gcf, 'Position', [200, 200, 2000, 500]); % 调整窗口大小
subplot(1,2,1)

h1 = plot(timesPlot,mean(Dynamic_D_Rand,1),'Color',colors(1,:),'LineWidth',3);
hold on
s=shadedErrorBar(timesPlot,mean(Dynamic_D_Rand,1),std(Dynamic_D_Rand,0,1)/sqrt(length(Dynamic_D_Rand(:,1))),'lineProps',{'markerfacecolor',colors(1,:),'color',colors(1,:)},'transparent',1);
s.patch.FaceColor = colors(1,:);
s.patch.EdgeColor = colors(1,:);

hold on
h2 = plot(timesPlot,Dynamic_T,'Color',colors(2,:),'LineWidth',3);
lgnd{1} = sprintf('Distractor');
lgnd{2} = sprintf('Target');


ylim([0 0.8])
set(gca,'TickDir','out','XTick',xTable,'XTickLabel',{'0.1','0.3','0.5','0.7','0.9'},'Fontsize',8);
xlim([100,996])
box off
ylabel('Dynamicism index','Fontsize',10)
xlabel('Time from distractor/target onset(s)','Fontsize',10)

lh=legend([h1,h2],lgnd);
legnames = {'Distractor','Target'};
for i = 1:length(legnames)
    str{i} = ['\' sprintf('color[rgb]{%f,%f,%f} %s', colors(i, 1), colors(i, 2), colors(i, 3), legnames{i})];
end
lh.String = str;
lh.Box = 'off';
lpos = lh.Position;
lh.Position = lpos;


timeBar = [100:4:996];
timesS = find(timeBar==500);
subplot(1,2,2)

Dynamic_D_Rand = Dynamic_D_Rand(:,1:timesS);
Dynamic_T = Dynamic_T(1:timesS);
max_Index = Dynamic_D_Rand - Dynamic_T';
max_Index = mean(max_Index,2);
[h,p,ci,stat]=ttest(max_Index);
disp(p)
disp(stat)

b = bar([mean(max_Index)]);
b.FaceColor = 'flat';
b.CData(1,:) = [0.5,0.5,0.5];

stdBar = [std(max_Index)/sqrt(length(max_Index))];
hold on
er = errorbar([mean(max_Index)],stdBar,"LineStyle","none");
er.Color = [0,0,0];
set(gca,'Xticklabel',{'Distractor-Target'});
ylabel('Dynamicism Index','Fontsize',10)
ylim([0.12 0.15])

if p<0.001 
    text(1,std(max_Index)/sqrt(length(max_Index))+mean(max_Index)+0.0051,'***','HorizontalAlignment','center','VerticalAlignment','bottom','FontSize',14);
elseif p<0.01 
    text(1,std(max_Index)/sqrt(length(max_Index))+mean(max_Index)+0.0051,'**','HorizontalAlignment','center','VerticalAlignment','bottom','FontSize',14);
elseif p<0.05
    text(1,std(max_Index)/sqrt(length(max_Index))+mean(max_Index)+0.0051,'*','HorizontalAlignment','center','VerticalAlignment','bottom','FontSize',14);
end
box off




%% Figure Name
% saveas(fig1,fullfile(resultsSave,['Final_DynamicismTask_Con_Start100','.svg']))
close(fig1)



