%% Figure2C_3B


% load mat
predict_files = 'G:\Function_Matlab\SVM\OneDay\mat\Final\Cluster\';

selectTime_con =[-600:4:996]; % time
timeDim_con = length(selectTime_con);

[Cluster_D,Predict_Mean_D] = Load_Mat(predict_files,'Cluster_task.mat','predict_task_Cluster.mat');
[Cluster_T,Predict_Mean_T] = Load_Mat(predict_files,'Cluster_con.mat','predict_con_Cluster.mat');
[Cluster_DT,Predict_Mean_DT] = Load_Mat(predict_files,'Cluster_tc.mat','predict_tc_Cluster.mat');
[Cluster_TD,Predict_Mean_TD] = Load_Mat(predict_files,'Cluster_ct.mat','predict_ct_Cluster.mat');


Plot_Mat(Predict_Mean_D,Cluster_D,selectTime_con,'Distractor-Distractor')
Plot_Mat(Predict_Mean_T,Cluster_T,selectTime_con,'Target-Target')
Plot_Mat(Predict_Mean_DT,Cluster_DT,selectTime_con,'Distractor-Target')
Plot_Mat(Predict_Mean_TD,Cluster_TD,selectTime_con,'Target-Distractor')



function [Cluster,Predict_Mean] = Load_Mat(predict_files,Cluster_Name,Predict_Name)

predict_mat = strcat(predict_files,Cluster_Name);
predict_mat = load(predict_mat);
Cluster = predict_mat.Cluster_5;

predict_mat = strcat(predict_files,Predict_Name);
predict_mat = load(predict_mat);
Predict = predict_mat.predict;

Predict_Mean = mean(Predict,3);

end



function Plot_Mat(Predict_Mean,Cluster,selectTime,Name_Figure)


figure;
imagesc(Predict_Mean')
set(gca, 'ydir', 'normal');
axis square;
runBoundary(Cluster(:,:))
plot([find(selectTime==0),find(selectTime==0)],[find(selectTime==-600),find(selectTime==996)],'Color','w')
plot([find(selectTime==-600),find(selectTime==996)],[find(selectTime==0),find(selectTime==0)],'Color','w')
plot([find(selectTime==500),find(selectTime==500)],[find(selectTime==0),find(selectTime==500)],'Color','w')
plot([find(selectTime==0),find(selectTime==500)],[find(selectTime==500),find(selectTime==500)],'Color','w')

xticks([find(selectTime==-400),find(selectTime==-200),find(selectTime==0),find(selectTime==200),find(selectTime==400),find(selectTime==500),find(selectTime==600),find(selectTime==800),find(selectTime==996)])
xticklabels({'-0.4','-0.2','0','0.2','0.4','','0.6','0.8','1'})
yticks([find(selectTime==-400),find(selectTime==-200),find(selectTime==0),find(selectTime==200),find(selectTime==400),find(selectTime==500),find(selectTime==600),find(selectTime==800),find(selectTime==996)])
yticklabels({'-0.4','-0.2','0','0.2','0.4','','0.6','0.8','1'})

handles = colorbar;
caxis([0.4 0.6])
handles.TickDirection = 'out';
handles.Box = 'off';
handles.Label.String = '% Decoding accuracy';
handles.Label.FontSize = 10;
drawnow;
title(Name_Figure,'Fontsize',12)
ylabel('Test time (ms)','Fontsize',10)
xlabel('Train time (ms)','Fontsize',10)


end

