%% 2025-12-19

clear
% load存储的mat文件 
predict_files = '/home/ChenQi_05/Analyse_Result/1_SVM/Cluster/Result/';
save_files = '/home/ChenQi_05/Analyse_Result/1_SVM/Cluster/Result/Dynamic/Final_Task/';


N_Num = 30;
selectTime_con =[-600:4:996];
timeDim_con = length(selectTime_con);
startTime = find(selectTime_con==-600);


%% 主任务
%load File_mat
predict_mat_task_file = strcat(predict_files,'Task');
predict_mat_task = fullfile(predict_mat_task_file,'*_AUC*.mat');
matFiles_task = dir(predict_mat_task);

predict_task = load_AUC_ClusterRand(predict_mat_task_file,matFiles_task,timeDim_con,N_Num);
predict_task = predict_task(startTime:end,startTime:end,:,:);

random_Index = 30;

Cluster_task_P5 = zeros(random_Index,timeDim_con,timeDim_con);
Cluster_task_P1 = zeros(random_Index,timeDim_con,timeDim_con);


parfor cir = 1:random_Index

    predict_task_Rand = [];
    for Subp = 1:N_Num
        rng shuffle;  % 重置随机数种子（可选，增强随机性）
        random_nums = randperm(10, 5);
        predict_task_Rand(:,:,Subp) = squeeze(mean(predict_task(:,:,random_nums,Subp),3));
    end

    [Cluster_task_5,Cluster_task_1]=permutationTest_cluster_psvr_v2(predict_task_Rand-0.5);

    Cluster_task_P5(cir,:,:) = Cluster_task_5;
    Cluster_task_P1(cir,:,:) = Cluster_task_1;

end

dynamic_FileName = strcat(save_files,'Dynamic_task_Rand','_Final.mat');
save(dynamic_FileName,'Cluster_task_P5','Cluster_task_P1');