%% Figure4B MahalTune Matrix Train Target and Test Distarctor

clear all

Index_Angle = [6,5,4,3,2,1,0,11,10,9,8,7,6];
Angle = [-90:15:90];
time = [-600:4:996];

resultsSave = 'G:\Function_Matlab\WM_Distractor\Figure_E1\';



File_Ori = 'G:\Function_Matlab\MahalTune\OneDay\Con_Task\cos';
File_Rotated = 'G:\Function_Matlab\MahalTune\OneDay\Task_OffSet\Cos_amp_';
Sube = [127];
saveName = ['MahalTune_Imagesc_TD','.svg'];
Plot_MahalTuneImagesc(File_Ori,File_Rotated,Sube,Angle,Index_Angle,time,resultsSave,saveName);



File_Ori = 'G:\Function_Matlab\MahalTune\OneDay\Con_Con\cos';
File_Rotated = 'G:\Function_Matlab\MahalTune\OneDay\Con_OffSet\Cos_amp_';
Sube = [127];
saveName = ['MahalTune_Imagesc_D','.svg'];

Plot_MahalTuneImagesc(File_Ori,File_Rotated,Sube,Angle,Index_Angle,time,resultsSave,saveName);



