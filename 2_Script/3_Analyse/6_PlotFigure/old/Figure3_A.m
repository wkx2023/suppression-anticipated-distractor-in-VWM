%% Corr_Between_Predict_Dynamic_Reactive 2026/01/14

clear

resultsSave = 'G:\Function_Matlab\WM_Distractor\Figure_E1\';

%mat_files = 'G:\Function_Matlab\SVM\OneDay\Cluster\Dynamic_Corr\Cluster_task_Rand_Final.mat';
mat_files = 'G:\Function_Matlab\SVM\OneDay\Cluster\Dynamic_Predict_Corr_Three\Cluster_task_Rand_Final.mat';
load(mat_files);

times = [0:4:996];
RTS = 100;
RTE = 500;
color_Point = [181,181,181]/255;



Dynamic_task_All = NaN(size(Cluster_task_Dynamic,1),size(Cluster_task_Dynamic(:,find(times==RTS):find(times==RTE),find(times==RTS):find(times==RTE)),2));
for cir =1:size(Cluster_task_Dynamic,1)
    Cluster_task_cir = squeeze(Cluster_task_Dynamic(cir,find(times==RTS):find(times==RTE),find(times==RTS):find(times==RTE)));
    Dynamic_task = dynamicism_v2(Cluster_task_cir);
    Dynamic_task_All(cir,:) = Dynamic_task;
end
Dynamic_task_All = mean(Dynamic_task_All,2);



time = [-600:4:3296];
timeSt = find(time==1300);
timeEn = find(time==3296);
pre_Cluster_task_Diag = Cluster_predict_Diag(:,timeSt:timeEn);
Predict_task_All = NaN(size(Cluster_task_Dynamic,1),1);
for cir =1:size(Cluster_task_Dynamic,1)
    predict_task_cir = squeeze(pre_Cluster_task_Diag(cir,:));
    predict_task = mean(predict_task_cir);
    Predict_task_All(cir) = predict_task;
end



time = [0:4:996];
timeSt = find(time==RTS);
timeEn = find(time==RTE);
pre_Cluster_reactive_Diag = Cluster_reactive_Diag(:,timeSt:timeEn);
Predict_reactive_All = NaN(size(Cluster_task_Dynamic,1),1);
for cir =1:size(Cluster_task_Dynamic,1)
    predict_task_cir = squeeze(pre_Cluster_reactive_Diag(cir,:));
    predict_task = mean(predict_task_cir);
    Predict_reactive_All(cir) = predict_task;
end



PlotCorr_Predict_Dynamicism_Reactive(Predict_task_All,Predict_reactive_All,Dynamic_task_All, color_Point,resultsSave)


PlotCorr_Rand(Predict_task_All,Predict_reactive_All,Dynamic_task_All,resultsSave)


