function PlotEEG_Beta(EEG,beta_values,timeTable,resultsSave,FigureName)

beta_values_plot = squeeze(mean(beta_values(:,timeTable,:),2));

ttest_values = NaN(1,size(beta_values_plot,2));
p_values = NaN(1,size(beta_values_plot,2));

for channelI = 1:size(beta_values_plot,2)

    [h,p,ci,stat] = ttest(squeeze(beta_values_plot(:,channelI)));
    ttest_values(channelI) = stat.tstat;
    p_values(channelI) = p;

end

fig1 = figure;
topoplot(squeeze(ttest_values), EEG.chanlocs, 'style','both','electrodes','on','chaninfo',EEG.chaninfo);
clim([-2,2])
colorbar

saveas(fig1,fullfile(resultsSave,FigureName))
close(fig1)
