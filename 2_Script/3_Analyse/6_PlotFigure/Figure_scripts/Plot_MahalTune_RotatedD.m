function Plot_MahalTune_RotatedD(cos_amp_Ori,cos_amp_Rot,time,resultsSave)

color_DT = [180, 206, 158]/255;
color_RotatedT = [238,61,17]/255;
colors = [color_DT;color_RotatedT];



fig1 = figure;
set(gcf,'Position',[200,200,1200,600])

h1 = Figure(cos_amp_Ori,time,colors(1,:),0.0002);
h2 = Figure(cos_amp_Rot,time,colors(2,:),0.0002);

plot([-600,996],[0,0],'Color','k','LineStyle','--')
plot([0,0],[-0.0008,0.002],'Color','k','LineStyle','--')

lh = legend([h1,h2],{'Train T Test D','Train T Test Rotated D'},'Location', 'bestoutside');
ylim([-0.0008,0.002])
xticks([-400,-200,0,200,400,500,600,800,996])
xticklabels({'-0.4','-0.2','0','0.2','0.4','','0.6','0.8','1'})

lh.Box = 'off';
lpos = lh.Position;
lh.Position = lpos;

xlabel('Time from distractor/target onset (s)','Fontsize',10)
ylabel('Decoding Accuracy','Fontsize',10)
box off;
saveas(fig1,fullfile(resultsSave,['FinalMahalTune_RotatedDecoding','.svg']))
close(fig1)



end



function h = Figure(cos_amp,time,colors,lineHigh)


[datobs, datrnd] = cluster_test_helper(cos_amp(:,:)', 50000);
[h_mem, p_mem, ~] = cluster_test(datobs,datrnd,0,0.05,0.05);
pclustu = unique(p_mem);
npclust = nnz(pclustu < 0.05);

s=shadedErrorBar(time,mean(cos_amp,1),std(cos_amp,0,1)/sqrt(length(cos_amp(:,1))),'lineProps',{'markerfacecolor',colors,'color',colors},'transparent',1);
s.patch.FaceColor = colors;
s.patch.EdgeColor = colors;

hold on       
h = plot(time,mean(cos_amp,1),'Color',colors,'LineStyle','-','LineWidth',3);
hold on

for ipclust = 1:npclust % extract time range of each significant cluster and show in figure
    currind  = p_mem == pclustu(ipclust);
    fill([min(time(currind)),min(time(currind)),max(time(currind)),max(time(currind))],[lineHigh,lineHigh+0.00005,lineHigh+0.00005,lineHigh],colors,'EdgeColor','none')
    hold on
    % h=fill([min(time(currind)),min(time(currind)),max(time(currind)),max(time(currind))],[0,0.00325,0.00325,0],[58 181 179]/255,'EdgeColor','none');
    % set(h,'facealpha',0.1);
end

hold on

end