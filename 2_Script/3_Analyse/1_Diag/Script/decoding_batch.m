% 主任务
Subj= [122:128,130:135];%填入被试数目
labels = [1,2,4];
Cond = {'B1(S11)' ,'B2(S11)' ,'B3(S11)','B4(S11)' }; 
file_all = '/home/ChenQi_05/Analyse_Result/1_SVM/EEG/Task';
file_path_all='/home/ChenQi_05/Analyse_Result/1_SVM/Result_1117/NoERP_Hz/';
time_phase = [-0.6 4.3];%时频分析全段时间


% 控制任务
% Subj= [101:105,107:111,113:116,118:120,122:128,130:135];%填入被试数目
% Cond = {'B1(S45)' ,'B2(S46)' ,'B3(S48)' };
% file_all = '/home/ChenQi_05/Analyse_Result/1_SVM/EEG/NoBaseline/Control';
% labels = [1,2,3];
% file_path_all='/home/ChenQi_05/Analyse_Result/1_SVM/Result/NoBaseline/Control/';
% time_phase = [-0.6 1];%时频分析全段时间



%% 三分类解码
test_muti_NoErp(Subj,Cond,file_all,labels,file_path_all,time_phase)

%test_muti_Diag(Subj,Cond,file_all,labels,file_path_all,time_phase)