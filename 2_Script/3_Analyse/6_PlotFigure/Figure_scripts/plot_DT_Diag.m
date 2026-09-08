function plot_DT_Diag(dat_D,smooth_dat_D,dat_T,smooth_dat_T,dat_DT,smooth_dat_DT,dat_TD,smooth_dat_TD,time,colors,resultsSave)

fig1 = figure;    
set(gcf, 'Position', [200, 200, 1200, 600]); % 调整窗口大小

h1 = plot_Line(smooth_dat_D,colors(1,:),time,0.825);
h2 = plot_Line(smooth_dat_T,colors(2,:),time,0.815);
h3 = plot_Line(smooth_dat_DT,colors(3,:),time,0.805);
h4 = plot_Line(smooth_dat_TD,colors(4,:),time,0.795);

plot([0,0],[0.45,0.83],'Color','k','LineStyle','--')
plot([500,500],[0.45,0.83],'Color','k','LineStyle','-')
plot([-600,996],[0.5,0.5],'Color','k','LineStyle','--')

lgnd{1} = sprintf('Train D Test D');
lgnd{2} = sprintf('Train T Test T');
lgnd{3} = sprintf('Train D Test T');
lgnd{4} = sprintf('Train T Test D');

lh=legend([h1,h2,h3,h4],lgnd,'Location','bestoutside');
legnames = {'Train D Test D','Train T Test T','Train D Test T','Train T Test D'};

for i = 1:length(legnames)
    str{i} = ['\' sprintf('color[rgb]{%f,%f,%f} %s',colors(i, 1), colors(i, 2), colors(i, 3), legnames{i})];
end

lh.String = str;
lh.FontSize = 12;
lh.Box = 'off';
lpos = lh.Position;
lh.Position = lpos;

hold on
ylim([0.45 0.83])
xlim([-600,996])
xticks([-400,-200,0,200,400,500,600,800,996])
xticklabels({'-0.4','-0.2','0','0.2','0.4','','0.6','0.8','1'})
xlabel('Time (ms)','Fontsize',10)
ylabel('AUC','Fontsize',10)
box off;

%saveas(fig1,fullfile(resultsSave,['TaskCon_timepoint_Final_TwoTail_Smooth','.svg']))
close(fig1)


predictD = squeeze(mean(dat_D(:,find(time==0):find(time==500)),2));
predictT = squeeze(mean(dat_T(:,find(time==0):find(time==500)),2));
predictDT = squeeze(mean(dat_DT(:,find(time==0):find(time==500)),2));
predictTD = squeeze(mean(dat_TD(:,find(time==0):find(time==500)),2));

fig1 = figure;
b = bar([mean(predictD),mean(predictT),mean(predictDT),mean(predictTD)]);
b.FaceColor = 'flat';
b.CData(1,:) = colors(1,:);
b.CData(2,:) = colors(2,:);
b.CData(3,:) = colors(3,:);
b.CData(4,:) = colors(4,:);

stdBar = [std(predictD)/sqrt(size(predictD,1)),std(predictT)/sqrt(size(predictT,1)),std(predictDT)/sqrt(size(predictDT,1)),std(predictTD)/sqrt(size(predictTD,1))];
hold on
er = errorbar([mean(predictD),mean(predictT),mean(predictDT),mean(predictTD)],stdBar,"LineStyle","none");
er.Color = [0,0,0];
ylim([0.5 0.83])


plot_Bar(predictD,1)
plot_Bar(predictT,2)
plot_Bar(predictDT,3)
plot_Bar(predictTD,4)


plot_ComparisonBar(predictD,(predictDT+predictTD)/2,1,3.5)
plot_ComparisonBar(predictT,(predictDT+predictTD)/2,2,3.5)


box off;
%saveas(fig1,fullfile(resultsSave,['TaskCon_timepoint_Final_Bar','.svg']))
close(fig1)



end










function h = plot_Line(smooth_dat,colors,time,lineHigh)


[obs,rnd] = cluster_test_helper(smooth_dat'-0.5,1000);
[sig,~,~] = cluster_test(obs,rnd); % Null two-tail; 1 one-tail >; -1 one-tail <
sigY = ones(1,sum(sig)).*lineHigh;
plot(time(sig), sigY,'.','Color', colors,'MarkerSize',18)
hold on
h = plot(time,mean(smooth_dat,1),'Color',colors,'LineStyle','-','LineWidth',2);
hold on
s=shadedErrorBar(time,mean(smooth_dat,1),std(smooth_dat,0,1)/sqrt(length(smooth_dat(:,1))),'lineProps',{'markerfacecolor',colors,'color',colors},'transparent',1);
s.patch.FaceColor = colors;
s.patch.EdgeColor = colors;
hold on


end






function plot_Bar(predictAUC,index)

[h,p,ci,stat] = ttest(predictAUC-0.5);
if p<0.001 
    text(index,std(predictAUC)/sqrt(length(predictAUC))+mean(predictAUC)+0.01,'***','HorizontalAlignment','center','VerticalAlignment','bottom','FontSize',14);
elseif p<0.01 
    text(index,std(predictAUC)/sqrt(length(predictAUC))+mean(predictAUC)+0.01,'**','HorizontalAlignment','center','VerticalAlignment','bottom','FontSize',14);
elseif p<0.05
    text(index,std(predictAUC)/sqrt(length(predictAUC))+mean(predictAUC)+0.01,'*','HorizontalAlignment','center','VerticalAlignment','bottom','FontSize',14);
end

hold on

end






function plot_ComparisonBar(predictAUC1,predictAUC2,index1,index2)

[h,p,ci,stat] = ttest(predictAUC1,predictAUC2);
disp(p)
disp(stat)
if p<0.001
    text((index1+index2)/2,std(predictAUC1)/sqrt(length(predictAUC1))+mean(predictAUC1)+0.02,'***','HorizontalAlignment','center','VerticalAlignment','bottom','FontSize',14);
    plot([index1,index2],[std(predictAUC1)/sqrt(length(predictAUC1))+mean(predictAUC1)+0.015,std(predictAUC1)/sqrt(length(predictAUC1))+mean(predictAUC1)+0.015],'k-');
elseif p<0.01
    text((index1+index2)/2,std(predictAUC1)/sqrt(length(predictAUC1))+mean(predictAUC1)+0.02,'**','HorizontalAlignment','center','VerticalAlignment','bottom','FontSize',14);
    plot([index1,index2],[std(predictAUC1)/sqrt(length(predictAUC1))+mean(predictAUC1)+0.015,std(predictAUC1)/sqrt(length(predictAUC1))+mean(predictAUC1)+0.015],'k-');

elseif p<0.05
    text((index1+index2)/2,std(predictAUC1)/sqrt(length(predictAUC1))+mean(predictAUC1)+0.02,'*','HorizontalAlignment','center','VerticalAlignment','bottom','FontSize',14);
    plot([index1,index2],[std(predictAUC1)/sqrt(length(predictAUC1))+mean(predictAUC1)+0.015,std(predictAUC1)/sqrt(length(predictAUC1))+mean(predictAUC1)+0.015],'k-');
end

hold on

end