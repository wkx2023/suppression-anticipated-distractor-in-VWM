%% 2025-12-16

clear all
save_files = 'G:\Function_Matlab\SVM\OneDay\mat\Final\Cluster\';
save_files = 'G:\Function_Matlab\SVM\OneDay\mat\Final\Cluster\';


% load存储的mat文件 
predict_files = 'G:\Function_Matlab\SVM\OneDay\Result_present\';

N_Num = 30;
selectTime_con =[-600:4:996];
timeDim_con = length(selectTime_con);

%% 主任务
%load File_mat
predict_mat_task_file = strcat(predict_files,'Task');
predict_mat_task = fullfile(predict_mat_task_file,'*_AUC*.mat');
matFiles_task = dir(predict_mat_task);

% load AUC_mat
[predict_task,predict_task_Diag] = load_AUC_Cluster(predict_mat_task_file,matFiles_task,timeDim_con,N_Num);
predict_task_file = strcat(save_files,'predict_task_Cluster.mat');
save(predict_task_file,'predict_task')
predict_taskDiag_file = strcat(save_files,'predict_task_Diag.mat');
save(predict_taskDiag_file,'predict_task_Diag')

% 计算聚类的显著值 
[Cluster_task_5,Cluster_task_1] = permutationTest_cluster_psvr_v2(predict_task-0.5);
Cluster_file = strcat(save_files,'Cluster_task.mat');
save(Cluster_file,'Cluster_task_5','Cluster_task_1')


%% 控制任务
% load File_mat
predict_files = 'G:\Function_Matlab\SVM\OneDay\Result_present\';

predict_mat_con_file = strcat(predict_files,'Control');
predict_mat_con = fullfile(predict_mat_con_file,'*_AUC*.mat');
matFiles_con = dir(predict_mat_con);

% load AUC_mat
[predict_con,predict_con_Diag] = load_AUC_Cluster(predict_mat_con_file,matFiles_con,timeDim_con,N_Num);
predict_con_file = strcat(save_files,'predict_con_Cluster.mat');
save(predict_con_file,'predict_con')
predict_conDiag_file = strcat(save_files,'predict_con_Diag.mat');
save(predict_conDiag_file,'predict_con_Diag')

% 2.计算聚类的显著值 
[Cluster_con_5,Cluster_con_1]=permutationTest_cluster_psvr_v2(predict_con-0.5);
Cluster_file = strcat(save_files,'Cluster_con.mat');
save(Cluster_file,'Cluster_con_5','Cluster_con_1')



%% 控制任务主任务相互
predict_files = 'G:\Function_Matlab\SVM\OneDay\';

% load File_mat
predict_mat_ct_file = strcat(predict_files,'Result_ConTask');
predict_mat_ct = fullfile(predict_mat_ct_file,'*_AUC*.mat');
matFiles_ct = dir(predict_mat_ct);

% load AUC_mat
[predict_ct,predict_ct_Diag] = load_AUC_Cluster(predict_mat_ct_file,matFiles_ct,timeDim_con,N_Num);
predict_ct_file = strcat(save_files,'predict_ct_Cluster.mat');
save(predict_ct_file,'predict_ct')
predict_ctDiag_file = strcat(save_files,'predict_ct_Diag.mat');
save(predict_ctDiag_file,'predict_ct_Diag')

% 2.计算聚类的显著值 
[Cluster_ct_5,Cluster_ct_1]=permutationTest_cluster_psvr_v2(predict_ct-0.5);
Cluster_file = strcat(save_files,'Cluster_ct.mat');
save(Cluster_file,'Cluster_ct_5','Cluster_ct_1')



predict_files = 'G:\Function_Matlab\SVM\OneDay\';
% load File_mat
predict_mat_tc_file = strcat(predict_files,'Result_TaskCon');
predict_mat_tc = fullfile(predict_mat_tc_file,'*_AUC*.mat');
matFiles_tc = dir(predict_mat_tc);

% load AUC_mat
[predict_tc,predict_tc_Diag] = load_AUC_Cluster(predict_mat_tc_file,matFiles_tc,timeDim_con,N_Num);
predict_tc_file = strcat(save_files,'predict_tc_Cluster.mat');
save(predict_tc_file,'predict_tc')
predict_tcDiag_file = strcat(save_files,'predict_tc_Diag.mat');
save(predict_tcDiag_file,'predict_tc_Diag')

% 2.计算聚类的显著值 
[Cluster_tc_5,Cluster_tc_1]=permutationTest_cluster_psvr_v2(predict_tc-0.5);
Cluster_file = strcat(save_files,'Cluster_tc.mat');
save(Cluster_file,'Cluster_tc_5','Cluster_tc_1')
