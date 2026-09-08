function plot_Distractor_Diag(dat,smooth_dat,time,colors,resultsSave)

fig1 = figure;    
set(gcf, 'Position', [200, 200, 1200, 600]); % 调整窗口大小

[obs,rnd] = cluster_test_helper(smooth_dat'-0.5,1000);
[sig,~,~] = cluster_test(obs,rnd); % Null two-tail; 1 one-tail >; -1 one-tail <
sigY = ones(1,sum(sig)).*0.475;


% for TimeI = 1:size(dat,2)
%     [h,p,ci,stat] = ttest(squeeze(smooth_dat(:,TimeI)),0.5,"Tail","right");
%     p_raw(TimeI) = p;
%     t_raw(TimeI) = stat.tstat;
% end

%[FDR]=mafdr(p_raw,'BHFDR', true);

%[h, crit_p, adj_p] = fdr_bh(p_raw,0.05);


% sig = (FDR < 0.05) & (p_raw < 0.025) & (t_raw > 0);
% sig = h;
% sigY = ones(1,sum(sig)).*0.475;


plot(time(sig), sigY,'.','Color', colors(1,:),'MarkerSize',18)
hold on
plot(time,mean(smooth_dat,1),'Color',colors(1,:),'LineStyle','-','LineWidth',2);

hold on
s=shadedErrorBar(time,mean(smooth_dat,1),std(smooth_dat,0,1)/sqrt(length(smooth_dat(:,1))),'lineProps',{'markerfacecolor',colors(1,:),'color',colors(1,:)},'transparent',1);
s.patch.FaceColor = colors(1,:);
s.patch.EdgeColor = colors(1,:);
hold on

plot([0,0],[0.45,0.8],'Color','k','LineStyle','--')
plot([-600,4296],[0.5,0.5],'Color','k','LineStyle','--')

lgnd{1} = sprintf('Distractor');
lh=legend(lgnd,'Location','bestoutside');
legnames = {'Distractor'};
for i = 1:length(legnames)
    str{i} = ['\' sprintf('color[rgb]{%f,%f,%f} %s',colors(i, 1), colors(i, 2), colors(i, 3), legnames{i})];
end
lh.String = str;
lh.FontSize = 12;
lh.Box = 'off';
lpos = lh.Position;
lh.Position = lpos;

hold on
ylim([0.45 0.8])
xlim([-600,4296])
xlabel('Time (ms)','Fontsize',15)
ylabel('Distractor Decoding Accuracy','Fontsize',15)
xticks([-500,0,152,500,1000,1148,1300,1500,2000,2500,3000,3300,3500,3800,4000])
xticklabels({'-0.5','0','','0.5','1','','','1.5','2','2.5','3','','3.5','','4'})

box off;


% saveas(fig1,fullfile(resultsSave,['Task_timepoint_Final_TwoTail_Smooth','.svg']))
% close(fig1)



predictAUC = squeeze(mean(dat(:,find(time==1300):find(time==3300)),2));

fig1 = figure;
b = bar([mean(predictAUC)]);
b.FaceColor = 'flat';
b.CData(1,:) = colors(1,:);
stdBar = [std(predictAUC)/sqrt(size(predictAUC,1))];
hold on
er = errorbar([mean(predictAUC)],stdBar,"LineStyle","none");
er.Color = [0,0,0];
ylim([0.5 0.8])

[h,p,ci,stat] = ttest(predictAUC-0.5);

if p<0.001 
    text(1,std(predictAUC)/sqrt(size(predictAUC,1))+mean(predictAUC)+0.02,'***','HorizontalAlignment','center','VerticalAlignment','bottom','FontSize',14);
elseif p<0.01 
    text(1,std(predictAUC)/sqrt(size(predictAUC,1))+mean(predictAUC)+0.02,'**','HorizontalAlignment','center','VerticalAlignment','bottom','FontSize',14);
elseif p<0.05
    text(1,std(predictAUC)/sqrt(size(predictAUC,1))+mean(predictAUC)+0.02,'*','HorizontalAlignment','center','VerticalAlignment','bottom','FontSize',14);
end

box off;
% saveas(fig1,fullfile(resultsSave,['Task_timepoint_Final_Bar','.svg']))
% close(fig1)



end