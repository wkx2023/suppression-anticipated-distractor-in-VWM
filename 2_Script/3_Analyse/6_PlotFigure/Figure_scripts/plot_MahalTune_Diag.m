function plot_MahalTune_Diag(dat_D,smooth_dat_D,dat_T,smooth_dat_T,dat_DT,smooth_dat_DT,dat_TD,smooth_dat_TD,time,colors,resultsSave)

fig1 = figure;    
set(gcf, 'Position', [200, 200, 1200, 600]); % 调整窗口大小
h1 = plot_Figure(smooth_dat_D,time,colors(1,:),-0.00103);
h2 = plot_Figure(smooth_dat_T,time,colors(2,:),-0.00113);
h3 = plot_Figure(smooth_dat_DT,time,colors(3,:),-0.00123);
h4 = plot_Figure(smooth_dat_TD,time,colors(4,:),-0.00133);
% 标准化图表形式
plot([-600,996],[0,0],'Color','k','LineStyle','--')
plot([0,0],[-0.0015,0.0045],'Color','k','LineStyle','--')
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
ylim([-0.0015,0.0045])
xlim([-600,996])
xticks([-400,-200,0,200,400,500,600,800,996])
xticklabels({'-0.4','-0.2','0','0.2','0.4','','0.6','0.8','1'})
xlabel('Time from distarctor/target onset (s)','Fontsize',10)
ylabel('Decoding Accuracy','Fontsize',10)
box off;
saveas(fig1,fullfile(resultsSave,['Final_S100_MahalTune_Angle','.svg']))
close(fig1)









fig1 = figure;
predictD = squeeze(mean(dat_D(:,find(time==100):find(time==500)),2));
predictT = squeeze(mean(dat_T(:,find(time==100):find(time==500)),2));
predictDT = squeeze(mean(dat_DT(:,find(time==100):find(time==500)),2));
predictTD = squeeze(mean(dat_TD(:,find(time==100):find(time==500)),2));
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
ylim([0 0.0025])


plot_Bar(predictD,1)
plot_Bar(predictT,2)
plot_Bar(predictDT,3)
plot_Bar(predictTD,4)

plot_ComparisonBar(predictD,(predictDT+predictTD)/2,1,3.5)
plot_ComparisonBar(predictT,(predictDT+predictTD)/2,2,3.5)


box off;
%saveas(fig1,fullfile(resultsSave,['MahalTune_timepoint_Final_Bar','.svg']))
%close(fig1)

end





function h = plot_Figure(cos_amp,time,color,lineHigh)

[datobs, datrnd] = cluster_test_helper(cos_amp(:,:)', 50000);
[h_mem, p_mem, ~] = cluster_test(datobs,datrnd,0,0.05,0.05);

pclustu = unique(p_mem);
npclust = nnz(pclustu < 0.05);
s=shadedErrorBar(time,mean(cos_amp,1),std(cos_amp,0,1)/sqrt(length(cos_amp(:,1))),'lineProps',{'markerfacecolor',color,'color',color},'transparent',1);
s.patch.FaceColor = color;
s.patch.EdgeColor = color;

hold on
h = plot(time,mean(cos_amp,1),'Color',color,'LineStyle','-','LineWidth',3);
hold on
for ipclust = 1:npclust % extract time range of each significant cluster and show in figure
    currind  = p_mem == pclustu(ipclust);
    fill([min(time(currind)),min(time(currind)),max(time(currind)),max(time(currind))],[lineHigh,lineHigh+0.0001,lineHigh+0.0001,lineHigh],color,'EdgeColor','none')
    hold on
end

hold on 

end







function plot_Bar(predictAUC,index)

[h,p,ci,stat] = ttest(predictAUC-0.5);
if p<0.001 
    text(index,std(predictAUC)/sqrt(length(predictAUC))+mean(predictAUC)+0.000001,'***','HorizontalAlignment','center','VerticalAlignment','bottom','FontSize',14);
elseif p<0.01 
    text(index,std(predictAUC)/sqrt(length(predictAUC))+mean(predictAUC)+0.000001,'**','HorizontalAlignment','center','VerticalAlignment','bottom','FontSize',14);
elseif p<0.05
    text(index,std(predictAUC)/sqrt(length(predictAUC))+mean(predictAUC)+0.000001,'*','HorizontalAlignment','center','VerticalAlignment','bottom','FontSize',14);
end

hold on

end






function plot_ComparisonBar(predictAUC1,predictAUC2,index1,index2)

[h,p,ci,stat] = ttest(predictAUC1,predictAUC2);
if p<0.001
    text((index1+index2)/2,std(predictAUC1)/sqrt(length(predictAUC1))+mean(predictAUC1)+0.000002,'***','HorizontalAlignment','center','VerticalAlignment','bottom','FontSize',14);
    plot([index1,index2],[std(predictAUC1)/sqrt(length(predictAUC1))+mean(predictAUC1)+0.0000015,std(predictAUC1)/sqrt(length(predictAUC1))+mean(predictAUC1)+0.0000015],'k-');
elseif p<0.01
    text((index1+index2)/2,std(predictAUC1)/sqrt(length(predictAUC1))+mean(predictAUC1)+0.000002,'**','HorizontalAlignment','center','VerticalAlignment','bottom','FontSize',14);
    plot([index1,index2],[std(predictAUC1)/sqrt(length(predictAUC1))+mean(predictAUC1)+0.0000015,std(predictAUC1)/sqrt(length(predictAUC1))+mean(predictAUC1)+0.0000015],'k-');

elseif p<0.05
    text((index1+index2)/2,std(predictAUC1)/sqrt(length(predictAUC1))+mean(predictAUC1)+0.000002,'*','HorizontalAlignment','center','VerticalAlignment','bottom','FontSize',14);
    plot([index1,index2],[std(predictAUC1)/sqrt(length(predictAUC1))+mean(predictAUC1)+0.0000015,std(predictAUC1)/sqrt(length(predictAUC1))+mean(predictAUC1)+0.0000015],'k-');
end

hold on

end