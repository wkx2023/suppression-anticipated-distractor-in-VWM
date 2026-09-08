function PlotHz_Diag(Subj,All_AUC,time,Hz,HzPlot,colors,resultsSave)

fig1 = figure(1);

plot_AUC = squeeze(mean(All_AUC,1));
imagesc(time,Hz,plot_AUC)

colorbar;
caxis([0.5,0.54]);
hold on
plot([-600,4296],[7.5,7.5],'k--')
hold on
plot([-600,4296],[14.5,14.5],'k--')
hold on
plot([-600,-600],[1,30],'k--')
hold on
plot([0,0],[1,30],'k--')
hold on
plot([1152,1152],[1,30],'k--')
hold on
plot([1300,1300],[1,30],'k--')
hold on
plot([3300,3300],[1,30],'k--')
hold on
plot([3800,3800],[1,30],'k--')

saveas(fig1,fullfile(resultsSave,['Task_Hz_Auc_OneDay_ERP','.svg']))
close(fig1)



fig1 = figure(2);

predictPlotAUC = squeeze(mean(plot_AUC(:,find(time==1300):find(time==3300)),2));
representPlotAUC = squeeze(mean(plot_AUC(:,find(time==3400):find(time==3800)),2));
plot(Hz,predictPlotAUC,'-*b',Hz,representPlotAUC,'-or');
legend('proactive','reactive')
saveas(fig1,fullfile(resultsSave,['Task_PlotHz_OneDay_ERP','.svg']))
close(fig1)





fig1 = figure(3);
set(gcf, 'Position', [200, 200, 1200, 600]); 
for HzI = 1:length(HzPlot)
    plotHzI = squeeze(mean(All_AUC(:,find(Hz==HzPlot{HzI}(1)):find(Hz==HzPlot{HzI}(2)),:),2));
    h(HzI) = plot(time,mean(plotHzI,1),'Color',colors(HzI,:),'LineStyle','-','LineWidth',2);
    hold on
    s=shadedErrorBar(time,mean(plotHzI,1),std(plotHzI,0,1)/sqrt(length(plotHzI(:,1))),'lineProps',{'markerfacecolor',colors(HzI,:),'color',colors(HzI,:)},'transparent',1);
    s.patch.FaceColor = colors(HzI,:);
    s.patch.EdgeColor = colors(HzI,:);
    hold on

    [obs,rnd] = cluster_test_helper(plotHzI'-0.5,1000);
    [sig,~,~] = cluster_test(obs,rnd); % Null two-tail; 1 one-tail >; -1 one-tail <
    sigY = ones(1,sum(sig)).*0.475 + (HzI-1)*0.005;
    plot(time(sig), sigY,'.','Color', colors(HzI,:),'MarkerSize',18)
    hold on
end



plot([-600,4296],[0.5 0.5],'k--')

lgnd{1} = sprintf('Theta(5-7Hz)');
lgnd{2} = sprintf('Alpha(8-14Hz)');
lgnd{3} = sprintf('Beta(15-30Hz)');

lh = legend(h,lgnd, 'Location', 'bestoutside');
legnames = {'Theta(5-7Hz)','Alpha(8-14Hz)','Beta(15-30Hz)'};

for i = 1:length(legnames)
    str{i} = ['\' sprintf('color[rgb]{%f,%f,%f} %s',colors(i, 1), colors(i, 2), colors(i, 3), legnames{i})];
end

lh.String = str;
lh.FontSize = 12;
lh.Box = 'off';
lpos = lh.Position;
lh.Position = lpos;

hold on
ylim([0.45 0.72])
xlim([-600,4296])
xlabel('Time (s)','Fontsize',15)
ylabel('AUC','Fontsize',15)
xticks([-500,0,152,500,1000,1148,1300,1500,2000,2500,3000,3300,3500,3800,4000])
xticklabels({'-0.5','0','','0.5','1','','','1.5','2','2.5','3','','3.5','','4'})
box off;

saveas(fig1,fullfile(resultsSave,['Task_timepoint_Hz_OneDay_ERP','.svg']))
close(fig1)



%% Bar
[h,p,ci,stat] = ttest(squeeze(mean(mean(All_AUC(:,find(Hz==5):find(Hz==7),find(time==1300):find(time==3300)),3),2))-0.5);
disp(p)
disp(stat.tstat)
[h,p,ci,stat] = ttest(squeeze(mean(mean(All_AUC(:,find(Hz==8):find(Hz==14),find(time==1300):find(time==3300)),3),2))-0.5);
disp(p)
disp(stat.tstat)
[h,p,ci,stat] = ttest(squeeze(mean(mean(All_AUC(:,find(Hz==15):find(Hz==30),find(time==1300):find(time==3300)),3),2))-0.5);
disp(p)
disp(stat.tstat)

[h,p,ci,stat] = ttest(squeeze(mean(mean(All_AUC(:,find(Hz==5):find(Hz==7),find(time==3400):find(time==3800)),3),2))-0.5);
disp(p)
disp(stat.tstat)
[h,p,ci,stat] = ttest(squeeze(mean(mean(All_AUC(:,find(Hz==8):find(Hz==14),find(time==3400):find(time==3800)),3),2))-0.5);
disp(p)
disp(stat.tstat)
[h,p,ci,stat] = ttest(squeeze(mean(mean(All_AUC(:,find(Hz==15):find(Hz==30),find(time==3400):find(time==3800)),3),2)),0.5);
disp(p)
disp(stat.tstat)


%% 绘制预测阶段 不同频段的比较

predictHzTheta = squeeze(mean(mean(All_AUC(:,find(Hz==5):find(Hz==7),find(time==1300):find(time==3300)),3),2));
predictHzAlpha = squeeze(mean(mean(All_AUC(:,find(Hz==8):find(Hz==14),find(time==1300):find(time==3300)),3),2));
predictHzBeta = squeeze(mean(mean(All_AUC(:,find(Hz==15):find(Hz==30),find(time==1300):find(time==3300)),3),2));

fig1 = figure(4);
b = bar([mean(predictHzTheta),mean(predictHzAlpha),mean(predictHzBeta)]);
b.FaceColor = 'flat';
b.CData(1,:) = colors(1,:);
b.CData(2,:) = colors(2,:);
b.CData(3,:) = colors(3,:);

stdBar = [std(predictHzTheta)/sqrt(length(Subj)),std(predictHzAlpha)/sqrt(length(Subj)),std(predictHzBeta)/sqrt(length(Subj))];
hold on
er = errorbar([mean(predictHzTheta),mean(predictHzAlpha),mean(predictHzBeta)],stdBar,"LineStyle","none");
er.Color = [0,0,0];
set(gca,'Xticklabel',{'Theta','Alpha','Beta'});
ylabel('AUC','Fontsize',10)
ylim([0.45 0.65])

[h,p,ci,stat] = ttest(predictHzTheta,predictHzAlpha);
disp(p)
disp(stat.tstat)
if p<0.001 
    text(1.5,std(predictHzAlpha)/sqrt(length(Subj))+mean(predictHzAlpha)+0.02,'***','HorizontalAlignment','center','VerticalAlignment','bottom','FontSize',14);
    plot([1,2],[std(predictHzAlpha)/sqrt(length(Subj))+mean(predictHzAlpha)+0.015',std(predictHzAlpha)/sqrt(length(Subj))+mean(predictHzAlpha)+0.015],'k-');

elseif p<0.01 
    text(1.5,std(predictHzAlpha)/sqrt(length(Subj))+mean(predictHzAlpha)+0.02,'**','HorizontalAlignment','center','VerticalAlignment','bottom','FontSize',14);
    plot([1,2],[std(predictHzAlpha)/sqrt(length(Subj))+mean(predictHzAlpha)+0.015',std(predictHzAlpha)/sqrt(length(Subj))+mean(predictHzAlpha)+0.015],'k-');
elseif p<0.05
    text(1.5,std(predictHzAlpha)/sqrt(length(Subj))+mean(predictHzAlpha)+0.02,'*','HorizontalAlignment','center','VerticalAlignment','bottom','FontSize',14);
    plot([1,2],[std(predictHzAlpha)/sqrt(length(Subj))+mean(predictHzAlpha)+0.015',std(predictHzAlpha)/sqrt(length(Subj))+mean(predictHzAlpha)+0.015],'k-');

end

[h,p,ci,stat] = ttest(predictHzAlpha,predictHzBeta);
disp(p)
disp(stat.tstat)
if p<0.001 
    text(2.5,std(predictHzBeta)/sqrt(length(Subj))+mean(predictHzBeta)+0.02,'***','HorizontalAlignment','center','VerticalAlignment','bottom','FontSize',14);
    plot([2,3],[std(predictHzBeta)/sqrt(length(Subj))+mean(predictHzBeta)+0.015',std(predictHzBeta)/sqrt(length(Subj))+mean(predictHzBeta)+0.015],'k-');

elseif p<0.01 
    text(2.5,std(predictHzBeta)/sqrt(length(Subj))+mean(predictHzBeta)+0.02,'**','HorizontalAlignment','center','VerticalAlignment','bottom','FontSize',14);
    plot([2,3],[std(predictHzBeta)/sqrt(length(Subj))+mean(predictHzBeta)+0.015',std(predictHzBeta)/sqrt(length(Subj))+mean(predictHzBeta)+0.015],'k-');

elseif p<0.05
    text(2.5,std(predictHzBeta)/sqrt(length(Subj))+mean(predictHzBeta)+0.02,'*','HorizontalAlignment','center','VerticalAlignment','bottom','FontSize',14);
    plot([2,3],[std(predictHzBeta)/sqrt(length(Subj))+mean(predictHzBeta)+0.015',std(predictHzBeta)/sqrt(length(Subj))+mean(predictHzBeta)+0.015],'k-');

end





box off;
saveas(fig1,fullfile(resultsSave,['Predict_timepoint_Hz_OneDay_ERP','.svg']))
close(fig1)



%% 绘制呈现阶段不同频段的比较
representTheta = squeeze(mean(mean(All_AUC(:,find(Hz==5):find(Hz==7),find(time==3400):find(time==3800)),3),2));
representAlpha = squeeze(mean(mean(All_AUC(:,find(Hz==8):find(Hz==14),find(time==3400):find(time==3800)),3),2));
representBeta = squeeze(mean(mean(All_AUC(:,find(Hz==15):find(Hz==30),find(time==3400):find(time==3800)),3),2));

fig1 = figure(5);
b = bar([mean(representTheta),mean(representAlpha),mean(representBeta)]);
b.FaceColor = 'flat';
b.CData(1,:) = colors(1,:);
b.CData(2,:) = colors(2,:);
b.CData(3,:) = colors(3,:);
stdBar = [std(representTheta)/sqrt(length(Subj)),std(representAlpha)/sqrt(length(Subj)),std(representBeta)/sqrt(length(Subj))];
hold on
er = errorbar([mean(representTheta),mean(representAlpha),mean(representBeta)],stdBar,"LineStyle","none");
er.Color = [0,0,0];
set(gca,'Xticklabel',{'Theta','Alpha','Beta'});
ylabel('AUC','Fontsize',10)
ylim([0.45 0.65])
[h,p,ci,stat] = ttest(representTheta,representAlpha);
disp(p)
disp(stat.tstat)
if p<0.001 
    text(1.5,std(representTheta)/sqrt(length(Subj))+mean(representTheta)+0.02,'***','HorizontalAlignment','center','VerticalAlignment','bottom','FontSize',14);
    plot([1,2],[std(representTheta)/sqrt(length(Subj))+mean(representTheta)+0.015',std(representTheta)/sqrt(length(Subj))+mean(representTheta)+0.015],'k-');
elseif p<0.01 
    text(1.5,std(representTheta)/sqrt(length(Subj))+mean(representTheta)+0.02,'**','HorizontalAlignment','center','VerticalAlignment','bottom','FontSize',14);
    plot([1,2],[std(representTheta)/sqrt(length(Subj))+mean(representTheta)+0.015',std(representTheta)/sqrt(length(Subj))+mean(representTheta)+0.015],'k-');
elseif p<0.05
    text(1.5,std(representTheta)/sqrt(length(Subj))+mean(representTheta)+0.02,'*','HorizontalAlignment','center','VerticalAlignment','bottom','FontSize',14);
    plot([1,2],[std(representTheta)/sqrt(length(Subj))+mean(representTheta)+0.015',std(representTheta)/sqrt(length(Subj))+mean(representTheta)+0.015],'k-');

end
[h,p,ci,stat] = ttest(representAlpha,representBeta);
disp(p)
disp(stat.tstat)
if p<0.001 
    text(2.5,std(representAlpha)/sqrt(length(Subj))+mean(representAlpha)+0.02,'***','HorizontalAlignment','center','VerticalAlignment','bottom','FontSize',14);
    plot([2,3],[std(representAlpha)/sqrt(length(Subj))+mean(representAlpha)+0.015',std(representAlpha)/sqrt(length(Subj))+mean(representAlpha)+0.015],'k-');

elseif p<0.01 
    text(2.5,std(representAlpha)/sqrt(length(Subj))+mean(representAlpha)+0.02,'**','HorizontalAlignment','center','VerticalAlignment','bottom','FontSize',14);
    plot([2,3],[std(representAlpha)/sqrt(length(Subj))+mean(representAlpha)+0.015',std(representAlpha)/sqrt(length(Subj))+mean(representAlpha)+0.015],'k-');
elseif p<0.05
    text(2.5,std(representAlpha)/sqrt(length(Subj))+mean(representAlpha)+0.02,'*','HorizontalAlignment','center','VerticalAlignment','bottom','FontSize',14);
    plot([2,3],[std(representAlpha)/sqrt(length(Subj))+mean(representAlpha)+0.015',std(representAlpha)/sqrt(length(Subj))+mean(representAlpha)+0.015],'k-');
end


box off;
saveas(fig1,fullfile(resultsSave,['Represention_timepoint_Hz_OneDay_ERP','.svg']))
close(fig1)





