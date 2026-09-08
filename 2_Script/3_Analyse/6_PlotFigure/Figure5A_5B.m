%% Figure5A_5B Corr_Between_Predict_Dynamic_Reactive 2026/01/14

clear all

resultsSave = 'G:\Function_Matlab\WM_Distractor\Figure_E1\';


%% 所有的结果文件
mat_files = 'G:\Function_Matlab\SVM\CorrRand\Cluster_task_Rand_Final_0707_1.mat';
load(mat_files);

Cluster_task_Dynamic_Fianl = Cluster_task_Dynamic;
Cluster_reactive_Diag_Final = Cluster_reactive_Diag;
Cluster_predict_Diag_Final = Cluster_predict_Diag;
Cluster_BeHa_Res_Final = Cluster_BeHa_Res;
Cluster_BeHa_Key_Final = Cluster_BeHa_Key;
Cluster_BeHa_Error_Final = Cluster_BeHa_Error;

mat_files = 'G:\Function_Matlab\SVM\CorrRand\Cluster_task_Rand_Final_0707_2.mat';
load(mat_files);


Cluster_task_Dynamic_Fianl = cat(1,Cluster_task_Dynamic_Fianl,Cluster_task_Dynamic);
Cluster_reactive_Diag_Final = cat(1,Cluster_reactive_Diag_Final,Cluster_reactive_Diag);
Cluster_predict_Diag_Final = cat(1,Cluster_predict_Diag_Final,Cluster_predict_Diag);
Cluster_BeHa_Res_Final = cat(1,Cluster_BeHa_Res_Final,Cluster_BeHa_Res);
Cluster_BeHa_Key_Final = cat(1,Cluster_BeHa_Key_Final,Cluster_BeHa_Key);
Cluster_BeHa_Error_Final = cat(1,Cluster_BeHa_Error_Final,Cluster_BeHa_Error);


mat_files = 'G:\Function_Matlab\SVM\CorrRand\Cluster_task_Rand_Final_0707_3.mat';
load(mat_files);


Cluster_task_Dynamic_Fianl = cat(1,Cluster_task_Dynamic_Fianl,Cluster_task_Dynamic);
Cluster_reactive_Diag_Final = cat(1,Cluster_reactive_Diag_Final,Cluster_reactive_Diag);
Cluster_predict_Diag_Final = cat(1,Cluster_predict_Diag_Final,Cluster_predict_Diag);
Cluster_BeHa_Res_Final = cat(1,Cluster_BeHa_Res_Final,Cluster_BeHa_Res);
Cluster_BeHa_Key_Final = cat(1,Cluster_BeHa_Key_Final,Cluster_BeHa_Key);
Cluster_BeHa_Error_Final = cat(1,Cluster_BeHa_Error_Final,Cluster_BeHa_Error);


mat_files = 'G:\Function_Matlab\SVM\CorrRand\Cluster_task_Rand_Final_0707_4.mat';
load(mat_files);


Cluster_task_Dynamic_Fianl = cat(1,Cluster_task_Dynamic_Fianl,Cluster_task_Dynamic);
Cluster_reactive_Diag_Final = cat(1,Cluster_reactive_Diag_Final,Cluster_reactive_Diag);
Cluster_predict_Diag_Final = cat(1,Cluster_predict_Diag_Final,Cluster_predict_Diag);
Cluster_BeHa_Res_Final = cat(1,Cluster_BeHa_Res_Final,Cluster_BeHa_Res);
Cluster_BeHa_Key_Final = cat(1,Cluster_BeHa_Key_Final,Cluster_BeHa_Key);
Cluster_BeHa_Error_Final = cat(1,Cluster_BeHa_Error_Final,Cluster_BeHa_Error);



mat_files = 'G:\Function_Matlab\SVM\CorrRand\Cluster_task_Rand_Final_0707_5.mat';
load(mat_files);

Cluster_task_Dynamic_Fianl = cat(1,Cluster_task_Dynamic_Fianl,Cluster_task_Dynamic);
Cluster_reactive_Diag_Final = cat(1,Cluster_reactive_Diag_Final,Cluster_reactive_Diag);
Cluster_predict_Diag_Final = cat(1,Cluster_predict_Diag_Final,Cluster_predict_Diag);
Cluster_BeHa_Res_Final = cat(1,Cluster_BeHa_Res_Final,Cluster_BeHa_Res);
Cluster_BeHa_Key_Final = cat(1,Cluster_BeHa_Key_Final,Cluster_BeHa_Key);
Cluster_BeHa_Error_Final = cat(1,Cluster_BeHa_Error_Final,Cluster_BeHa_Error);



mat_files = 'G:\Function_Matlab\SVM\CorrRand\Cluster_task_Rand_Final_0707_6.mat';
load(mat_files);


Cluster_task_Dynamic_Fianl = cat(1,Cluster_task_Dynamic_Fianl,Cluster_task_Dynamic);
Cluster_reactive_Diag_Final = cat(1,Cluster_reactive_Diag_Final,Cluster_reactive_Diag);
Cluster_predict_Diag_Final = cat(1,Cluster_predict_Diag_Final,Cluster_predict_Diag);
Cluster_BeHa_Res_Final = cat(1,Cluster_BeHa_Res_Final,Cluster_BeHa_Res);
Cluster_BeHa_Key_Final = cat(1,Cluster_BeHa_Key_Final,Cluster_BeHa_Key);
Cluster_BeHa_Error_Final = cat(1,Cluster_BeHa_Error_Final,Cluster_BeHa_Error);



mat_files = 'G:\Function_Matlab\SVM\CorrRand\Cluster_task_Rand_Final_0707_7.mat';
load(mat_files);


Cluster_task_Dynamic_Fianl = cat(1,Cluster_task_Dynamic_Fianl,Cluster_task_Dynamic);
Cluster_reactive_Diag_Final = cat(1,Cluster_reactive_Diag_Final,Cluster_reactive_Diag);
Cluster_predict_Diag_Final = cat(1,Cluster_predict_Diag_Final,Cluster_predict_Diag);
Cluster_BeHa_Res_Final = cat(1,Cluster_BeHa_Res_Final,Cluster_BeHa_Res);
Cluster_BeHa_Key_Final = cat(1,Cluster_BeHa_Key_Final,Cluster_BeHa_Key);
Cluster_BeHa_Error_Final = cat(1,Cluster_BeHa_Error_Final,Cluster_BeHa_Error);



mat_files = 'G:\Function_Matlab\SVM\CorrRand\Cluster_task_Rand_Final_0707_8.mat';
load(mat_files);


Cluster_task_Dynamic_Fianl = cat(1,Cluster_task_Dynamic_Fianl,Cluster_task_Dynamic);
Cluster_reactive_Diag_Final = cat(1,Cluster_reactive_Diag_Final,Cluster_reactive_Diag);
Cluster_predict_Diag_Final = cat(1,Cluster_predict_Diag_Final,Cluster_predict_Diag);
Cluster_BeHa_Res_Final = cat(1,Cluster_BeHa_Res_Final,Cluster_BeHa_Res);
Cluster_BeHa_Key_Final = cat(1,Cluster_BeHa_Key_Final,Cluster_BeHa_Key);
Cluster_BeHa_Error_Final = cat(1,Cluster_BeHa_Error_Final,Cluster_BeHa_Error);



mat_files = 'G:\Function_Matlab\SVM\CorrRand\Cluster_task_Rand_Final_0707_9.mat';
load(mat_files);


Cluster_task_Dynamic_Fianl = cat(1,Cluster_task_Dynamic_Fianl,Cluster_task_Dynamic);
Cluster_reactive_Diag_Final = cat(1,Cluster_reactive_Diag_Final,Cluster_reactive_Diag);
Cluster_predict_Diag_Final = cat(1,Cluster_predict_Diag_Final,Cluster_predict_Diag);
Cluster_BeHa_Res_Final = cat(1,Cluster_BeHa_Res_Final,Cluster_BeHa_Res);
Cluster_BeHa_Key_Final = cat(1,Cluster_BeHa_Key_Final,Cluster_BeHa_Key);
Cluster_BeHa_Error_Final = cat(1,Cluster_BeHa_Error_Final,Cluster_BeHa_Error);



mat_files = 'G:\Function_Matlab\SVM\CorrRand\Cluster_task_Rand_Final_0707_10.mat';
load(mat_files);


Cluster_task_Dynamic_Fianl = cat(1,Cluster_task_Dynamic_Fianl,Cluster_task_Dynamic);
Cluster_reactive_Diag_Final = cat(1,Cluster_reactive_Diag_Final,Cluster_reactive_Diag);
Cluster_predict_Diag_Final = cat(1,Cluster_predict_Diag_Final,Cluster_predict_Diag);
Cluster_BeHa_Res_Final = cat(1,Cluster_BeHa_Res_Final,Cluster_BeHa_Res);
Cluster_BeHa_Key_Final = cat(1,Cluster_BeHa_Key_Final,Cluster_BeHa_Key);
Cluster_BeHa_Error_Final = cat(1,Cluster_BeHa_Error_Final,Cluster_BeHa_Error);




Cluster_task_Dynamic = Cluster_task_Dynamic_Fianl;
Cluster_reactive_Diag = Cluster_reactive_Diag_Final;
Cluster_predict_Diag = Cluster_predict_Diag_Final;
Cluster_BeHa_Res = Cluster_BeHa_Res_Final;
Cluster_BeHa_Key = Cluster_BeHa_Key_Final;
Cluster_BeHa_Error = Cluster_BeHa_Error_Final;




%% 干扰呈现后动态指数
times = [-2000:4:996];
color_Point = [181,181,181]/255;
RTS = 100;
RTE = 500;
Dynamic_task_All = NaN(size(Cluster_task_Dynamic,1),size(Cluster_task_Dynamic(:,find(times==RTS):find(times==RTE),find(times==RTS):find(times==RTE)),2));
for cir =1:size(Cluster_task_Dynamic,1)
    Cluster_task_cir = squeeze(Cluster_task_Dynamic(cir,find(times==RTS):find(times==RTE),find(times==RTS):find(times==RTE)));
    Dynamic_task = dynamicism_v2(Cluster_task_cir);
    Dynamic_task_All(cir,:) = Dynamic_task;
end
Dynamic_task_All = mean(Dynamic_task_All,2);


%% 干扰呈现前动态指数
RTS = -2000;
RTE = 0;

Predict_Dy_task_All = NaN(size(Cluster_task_Dynamic,1),size(Cluster_task_Dynamic(:,find(times==RTS):find(times==RTE),find(times==RTS):find(times==RTE)),2));
for cir =1:size(Cluster_task_Dynamic,1)
    Cluster_task_cir = squeeze(Cluster_task_Dynamic(cir,find(times==RTS):find(times==RTE),find(times==RTS):find(times==RTE)));
    Dynamic_task = dynamicism_v2(Cluster_task_cir);
    Predict_Dy_task_All(cir,:) = Dynamic_task;
end
Predict_Dy_task_All = mean(Predict_Dy_task_All,2);


%% 干扰呈现前解码结果
RTS = -2000;
RTE = 0;

time = [-2000:4:996];
timeSt = find(time==RTS);
timeEn = find(time==RTE);
pre_Cluster_task_Diag = Cluster_reactive_Diag(:,timeSt:timeEn);
Predict_task_All = NaN(size(Cluster_task_Dynamic,1),1);
for cir =1:size(Cluster_task_Dynamic,1)
    predict_task_cir = squeeze(pre_Cluster_task_Diag(cir,:));
    predict_task = mean(predict_task_cir);
    Predict_task_All(cir) = predict_task;
end




PlotCorr_Predict_Dynamicism_Reactive_BeHa_Test(Predict_Dy_task_All,Predict_task_All,Dynamic_task_All,Cluster_BeHa_Error, color_Point,resultsSave)



