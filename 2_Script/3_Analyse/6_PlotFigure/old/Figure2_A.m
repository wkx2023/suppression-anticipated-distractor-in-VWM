%% Figure2A 2026-01-06 wkx

clear
s_factor = 4;
resultsSave = 'G:\Function_Matlab\WM_Distractor\Figure_E1\';

color_D =[149 79 151]/255;
color_T =[58 181 179]/255;
color_DT = [180, 206, 158]/255;
color_TD = [214, 220, 158]/255;
colors = [color_D;color_T;color_DT;color_TD];

time = [-600:4:996];
Sube = [101:105,107:111,113:116,118:120,122:128,130:135];

cosAmp_T_all = NaN(length(Sube),length(time));
cosAmp_T_dat = NaN(length(Sube),length(time));

cosAmp_D_all = NaN(length(Sube),length(time));
cosAmp_D_dat = NaN(length(Sube),length(time));

cosAmp_TD_all = NaN(length(Sube),length(time));
cosAmp_TD_dat = NaN(length(Sube),length(time));

cosAmp_DT_all = NaN(length(Sube),length(time));
cosAmp_DT_dat = NaN(length(Sube),length(time));


filename = 'G:\Function_Matlab\MahalTune\OneDay\Task_Task\cos\';
for subj = 1:length(Sube)
    matName = strcat(filename,'Angle_',num2str(Sube(subj)),'.mat');
    mat = load(matName);
    cos_amp = mat.cos_amp;
    cos_amp_new=imgaussfilt(mean(cos_amp,1),s_factor);
    cos_amp = mean(cos_amp,1);
    cosAmp_D_all(subj,:) = cos_amp_new;
    cosAmp_D_dat(subj,:) = cos_amp;
end

filename = 'G:\Function_Matlab\MahalTune\OneDay\Con_Con\cos\';
for subj = 1:length(Sube)
    matName = strcat(filename,'Angle_',num2str(Sube(subj)),'.mat');
    mat = load(matName);
    cos_amp = mat.cos_amp;
    cos_amp_new=imgaussfilt(mean(cos_amp,1),s_factor);
    cos_amp = mean(cos_amp,1);
    cosAmp_T_all(subj,:) = cos_amp_new;
    cosAmp_T_dat(subj,:) = cos_amp;
end


filename = 'G:\Function_Matlab\MahalTune\OneDay\Task_Con\cos\';
for subj = 1:length(Sube)
    matName = strcat(filename,'Angle_',num2str(Sube(subj)),'.mat');
    mat = load(matName);
    cos_amp = mat.cos_amp;
    cos_amp_new=imgaussfilt(mean(cos_amp,1),s_factor);
    cos_amp = mean(cos_amp,1);
    cosAmp_TD_all(subj,:) = cos_amp_new;
    cosAmp_TD_dat(subj,:) = cos_amp;
end


filename = 'G:\Function_Matlab\MahalTune\OneDay\Con_Task\cos\';
for subj = 1:length(Sube)
    matName = strcat(filename,'Angle_',num2str(Sube(subj)),'.mat');
    mat = load(matName);
    cos_amp = mat.cos_amp;
    cos_amp_new=imgaussfilt(mean(cos_amp,1),s_factor);
    cos_amp = mean(cos_amp,1);
    cosAmp_DT_all(subj,:) = cos_amp_new;
    cosAmp_DT_dat(subj,:) = cos_amp;
end


plot_MahalTune_Diag(cosAmp_D_dat,cosAmp_D_all,cosAmp_T_dat,cosAmp_T_all,cosAmp_DT_dat,cosAmp_DT_all,cosAmp_TD_dat,cosAmp_TD_all,time,colors,resultsSave)