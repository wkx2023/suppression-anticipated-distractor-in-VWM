%% Distractor/Target_svm_Diag cluster_test 2025-12-30 wkx


clear
s_factor = 4;
test_time = [-600:4:996];
resultsSave = 'G:\Function_Matlab\WM_Distractor\Figure_E1\';

color_D =[149 79 151]/255;
color_T =[58 181 179]/255;
color_DT = [180, 206, 158]/255;
color_TD = [214, 220, 158]/255;
colors = [color_D;color_T;color_DT;color_TD];


Sube = [101:105,107:111,113:116,118:120,122:128,130:135];
filename = 'G:\Function_Matlab\SVM\OneDay\mat\Final\Cluster\';



matName = strcat(filename,'predict_task_Cluster.mat');
mat = load(matName);
predict_task = mat.predict;   % 400*400*30
predict_task_all =  NaN(length(Sube),length(test_time));
predict_task_dat =  NaN(length(Sube),length(test_time));
for subj = 1:length(Sube)
    predict_task_subj=imgaussfilt(diag(squeeze(predict_task(:,:,subj))),s_factor);
    predict_task_all(subj,:) = predict_task_subj; % 30*400
    predict_task_dat(subj,:) = diag(squeeze(predict_task(:,:,subj)));
end



matName = strcat(filename,'predict_con_Cluster.mat');
mat = load(matName);
predict_con = mat.predict;
predict_con_all =  NaN(length(Sube),length(test_time));
predict_con_dat =  NaN(length(Sube),length(test_time));
for subj = 1:length(Sube)
    predict_con_subj=imgaussfilt(diag(squeeze(predict_con(:,:,subj))),s_factor);
    predict_con_all(subj,:) = predict_con_subj;
    predict_con_dat(subj,:) = diag(squeeze(predict_con(:,:,subj)));
end



matName = strcat(filename,'predict_tc_Cluster.mat');
mat = load(matName);
predict_tc = mat.predict;
predict_DT_all =  NaN(length(Sube),length(test_time));
predict_DT_dat =  NaN(length(Sube),length(test_time));
for subj = 1:length(Sube)
    predict_tc_subj=imgaussfilt(diag(squeeze(predict_tc(:,:,subj))),s_factor);
    predict_DT_all(subj,:) = predict_tc_subj;
    predict_DT_dat(subj,:) = diag(squeeze(predict_tc(:,:,subj)));
end



matName = strcat(filename,'predict_ct_Cluster.mat');
mat = load(matName);
predict_ct = mat.predict;
predict_TD_all =  NaN(length(Sube),length(test_time));
predict_TD_dat =  NaN(length(Sube),length(test_time));
for subj = 1:length(Sube)
    predict_ct_subj=imgaussfilt(diag(squeeze(predict_ct(:,:,subj))),s_factor);
    predict_TD_all(subj,:) = predict_ct_subj;
    predict_TD_dat(subj,:) = diag(squeeze(predict_ct(:,:,subj)));
end


plot_DT_Diag(predict_task_dat,predict_task_all,predict_con_dat,predict_con_all,predict_DT_dat,predict_DT_all,predict_TD_dat,predict_TD_all,test_time,colors,resultsSave)





