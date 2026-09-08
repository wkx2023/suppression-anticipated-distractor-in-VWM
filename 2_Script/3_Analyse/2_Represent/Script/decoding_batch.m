% 主任务
Subj=[101:105,107:111,113:116,118:120,122:128,130:135];%填入被试数目
Cond = {'B1(S11)' ,'B2(S11)' ,'B3(S11)','B4(S11)' }; 
%file_all = '/home/ChenQi_05/Analyse_Result/1_SVM/EEG/Task';

file_all = 'G:\EEG_data\Task';

labels = [1,2,4];
file_path_all='/home/ChenQi_05/Analyse_Result/Script_2026/Cluster_Dynamic_Predict/Result/';
time_phase = [-0.6 4.3];%时频分析全段时间


% % 控制任务
%Subj=[107:111];%填入被试数目
%Subj=[101:108];%填入被试数目
%Cond = {'B1(S45)' ,'B2(S46)' ,'B3(S48)' };
%labels = [1,2,3];

% file_all = '/home/ChenQi_05/Analyse_Result/1_SVM/EEG/NoBaseline/Control';
% file_path_all='/home/ChenQi_05/Analyse_Result/1_SVM/Result/NoBaseline/Control/';

%file_all = '/home/ChenQi_05/Analyse_Result/1_SVM/EEG/Control';
%file_path_all='/home/ChenQi_05/Analyse_Result/1_SVM/Result/Represent/Control/';

% file_all = '/home/ChenQi_05/Analyse_Result/1_SVM/EEG/Control';
% file_path_all='/home/ChenQi_05/Analyse_Result/1_SVM/Result/Represent/Control/';

%time_phase = [-0.6 1];%时频分析全段时间




%% 三分类解码
test_muti(Subj,Cond,file_all,labels,file_path_all,time_phase)