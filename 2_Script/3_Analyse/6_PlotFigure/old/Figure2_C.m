%% MahalTune Rotated Train Target and Test Distarctor

clear 

s_factor = 4;

Index_Angle = [6,5,4,3,2,1,11,10,9,8,7];
Angle_Shift = [90,75,60,45,30,15,-15,-30,-45,-60,-75];
Sube = [101:105,107:111,113:116,118:120,122:128,130:135];
time = [-600:4:996];
Angle = [1:1:11];
File_Rotated = 'G:\Function_Matlab\MahalTune\OneDay\Task_OffSet\Cos_amp_';
File_Ori = 'G:\Function_Matlab\MahalTune\OneDay\Con_Task\cos';
resultsSave = 'G:\Function_Matlab\WM_Distractor\Figure_E1\';


[FileIndex_Sub,MaxAngle_sub,Decodvalue_Sub] = Choose_MaxAngel(Sube,File_Rotated,Angle,Angle_Shift,Index_Angle,time);


cos_amp_Ori = NaN(length(Sube),length(time));
cos_amp_Rot = NaN(length(Sube),length(time));

for subj = 1:length(Sube)

    matName = strcat(File_Ori,'\Angle_',num2str(Sube(subj)),'.mat');
    mat = load(matName);
    cos_amp = mat.cos_amp;

    cos_amp_new = imgaussfilt(mean(cos_amp,1),s_factor); % smooth
    cos_amp_Ori(subj,:) = cos_amp_new; % smooth

end


for subj = 1:length(Sube)

    filename = strcat(File_Rotated,num2str(FileIndex_Sub(subj)),'\'); % Find Max Rotated
    matName = strcat(filename,'Angle_',num2str(Sube(subj)),'.mat'); % Find Max Rotated Sub
    disp(matName);
    mat = load(matName);
    cos_amp = mat.cos_amp;

    cos_amp = imgaussfilt(mean(cos_amp,1),s_factor);
    cos_amp_Rot(subj,:) =  cos_amp;

end



%% Result_File 
Sube = [101:105,107:111,113:116,118:120,122:128,130:135];
filename = 'G:\Function_Matlab\SVM\OneDay\mat\Final\mat\';
resultsSave = 'G:\Function_Matlab\WM_Distractor\Figure_E1\';
matName = strcat(filename,'predict_task_Final.mat');
mat = load(matName);
time_Task = [-600:4:4296];
predict_task = mat.predict_task; % 1225 * 1 * 30
predict_task = squeeze(predict_task); % 1225 * 30

predict_task_all = NaN(length(Sube),length(time_Task));
predict_task_dat = NaN(length(Sube),length(time_Task));

for subj = 1:length(Sube)
    predict_task_subj = imgaussfilt(predict_task(:,subj),s_factor);
    predict_task_all(subj,:) = predict_task_subj;
    predict_task_dat(subj,:) = predict_task(:,subj);
end


predict_task_dat = mean(predict_task_dat(:,find(time_Task==2300):find(time_Task==3300)),2);


% Plot_MahalTune_RotatedD(cos_amp_Ori,cos_amp_Rot,time,resultsSave)

Behavior_files = 'G:\EEG_data\EEG_Behavioral_1022\';
data = NaN(length(Sube),4);
 
data(:,4) = predict_task_dat;

for subj = 1:length(Sube)

    [sub_Angle,Error_Behavioral] = Behavioral_Performance(Sube(subj),Behavior_files,File_Rotated,Angle,Index_Angle,time,Angle_Shift);

    trial_num = length(sub_Angle);

    data(subj,1) = Sube(subj);
    data(subj,2) = mean(abs(abs(sub_Angle)-90));
    %data(subj,2) = mean(sub_Angle);
    data(subj,3) = mean(Error_Behavioral);

end

dataTable = array2table(data, 'VariableNames', {'Subject','Angle', 'Performance','Predict'});
% 构建并拟合混合线性模型
% 'b ~ 1 + a + (1 + a | SubjectID)'
formula = 'Performance ~  Angle  + (1|Subject)';
model = fitglme(dataTable, formula);
%model = glmfit(data(subj,2), [data(subj,3) data(subj,1)],'normal');
disp(model)

% 绘制散点图
figure;
scatter(dataTable.Angle, dataTable.Performance, 'filled', 'MarkerFaceColor', [0.2 0.2 0.8]);
xlabel('Deviation from 90°');
ylabel('Error value');

% 获取固定效应部分的预测值

[Yhat, xx, Stats] = predict(model, dataTable, 'Alpha', 0.05);
Yhat_lo = Yhat - 1.96*Stats.StdErr;
Yhat_hi = Yhat + 1.96*Stats.StdErr;

plot(dataTable.Angle, Yhat, 'LineWidth', 2)
fill([dataTable.Angle; flipud(dataTable.Angle)], [Yhat_hi; flipud(Yhat_lo)], ...
     'b', 'FaceAlpha', 0.2, 'EdgeColor', 'none')
%fixed_effects_fitted_values = predict(model, dataTable, 'Conditional', false);

% 绘制总体拟合线
hold on;
%plot(dataTable.Angle, fixed_effects_fitted_values, 'r-', 'LineWidth', 2);
legend('数据点', '总体拟合线');
hold off;
