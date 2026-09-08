%% Distractor_svm_Diag cluster_test 2025-12-24 wkx

clear all

s_factor = 4; % smooth
test_time = [-600:4:4296]; % Time


%% Color
color_plot =[149 79 151]/255;
colorCon_plot =[58 181 179]/255;
colors = [color_plot;colorCon_plot];


%% Result_File 
Sube = [101:105,107:111,113:116,118:120,122:128,130:135];
filename = 'G:\Function_Matlab\SVM\OneDay\mat\Final\mat\';
resultsSave = 'G:\Function_Matlab\WM_Distractor\Figure_E1\';
matName = strcat(filename,'predict_task_Final.mat');
mat = load(matName);

predict_task = mat.predict_task; % 1225 * 1 * 30
predict_task = squeeze(predict_task); % 1225 * 30

predict_task_all = NaN(length(Sube),length(test_time));
predict_task_dat = NaN(length(Sube),length(test_time));

for subj = 1:length(Sube)
    predict_task_subj = imgaussfilt(predict_task(:,subj),s_factor);
    predict_task_all(subj,:) = predict_task_subj;
    predict_task_dat(subj,:) = predict_task(:,subj);
end


%% plot
plot_Distractor_Diag(predict_task_dat,predict_task_all,test_time,colors,resultsSave)