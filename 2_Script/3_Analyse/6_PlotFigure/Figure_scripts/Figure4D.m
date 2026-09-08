%% Figure_4D MahalTune Rotated Train Target and Test Distarctor

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




Plot_MahalTune_RotatedD(cos_amp_Ori,cos_amp_Rot,time,resultsSave)

