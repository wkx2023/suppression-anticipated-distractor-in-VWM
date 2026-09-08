Subj=[118:125];%填入被试数目

Cond_T = {'B1(S11)' ,'B2(S11)' ,'B3(S11)','B4(S11)' };
Cond_C = {'B1(S45)' ,'B2(S46)' ,'B3(S48)' };

file_all_C = '/home/ChenQi_05/Analyse_Result/1_SVM/EEG/ThreeDay/Control_Task';
setpath_C=[file_all_C,filesep];

file_all_T = '/home/ChenQi_05/Analyse_Result/1_SVM/EEG/ThreeDay/EEG';
setpath_T=[file_all_T,filesep];

file_path_all = '/home/ChenQi_05/Analyse_Result/1_SVM/Result/Represent/NewThree_ConTask/';
% file_path_all = '/sharehome/ChenQi_05/EEG_home/Analyse_Result/task_con_3SVM/';
%对于每个被试
for Subi=1:length(Subj)

    setname=strcat('S',num2str(Subj(Subi)),'_WM.set');
    EEG_C= pop_loadset('filename',setname,'filepath',setpath_C);
    EEG_C= eeg_checkset( EEG_C );
    times = EEG_C.times;


    EEG_T= pop_loadset('filename',setname,'filepath',setpath_T);
    EEG_T= eeg_checkset( EEG_T );


    superTrial =2;

    labels1 = [1,2,4];
    labels2 = [1,2,3];

    file_path=strcat(file_path_all,'S',num2str(Subj(Subi)),'_predict','.mat');
    file_path1=strcat(file_path_all,'S',num2str(Subj(Subi)),'_predictAccForTrainSet','.mat');
    file_path2=strcat(file_path_all,'S',num2str(Subj(Subi)),'_AUC','.mat');

    type = 1; % 1即为控制任务训练 2即为主任务训练
    % %% 控制任务训练
    mutiClassSvm_ERP_3svm(EEG_C,EEG_T,labels2,labels1, times,superTrial,file_path,file_path1,file_path2,type);

    % type = 2;
    %% 主任务训练
    % mutiClassSvm_ERP_3svm(EEG_T,EEG_C,labels1,labels2, times,superTrial,file_path,file_path1,file_path2,type);

end