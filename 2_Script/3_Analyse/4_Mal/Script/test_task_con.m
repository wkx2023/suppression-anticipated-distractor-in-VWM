% 获取训练集和测试集
% 格式为时间* 特征* 试次
% 获取所有的trial对应的角度
clear

del_files = 'F:\WMD_Script\del_trial\';
control_files = 'E:\WM_Dis\data_EEG\';
behavior_files = 'E:\WM_Dis\data_EEG_day\';
file_all ='F:\EEG\Data\analyse\processing';



del_filesa = 'F:\WMD_Script\del_trial_control\';
control_filesa = 'E:\WM_Dis\data_control\';
behavior_filesa = 'F:\WMD_Script\Behavioral\Participants_EEG_control\';
file_alla ='F:\EEG\Data\analyse_con\processing';


save_files = 'F:\WM_analyse\angle_decoing\result_0225_tc\';
save_files1 = 'F:\WM_analyse\angle_decoing\result_tune_0225_tc\';


warning('off', 'all');
setpath=[file_all,filesep];
setpatha=[file_alla,filesep];
Sube = [2:8,10:17,19,20,22:34];
Subj = [1012,1014:1019,1021,1023:1029,1032,1034,1036:1041,1043:1049];

for i=1:length(Subj)

    [data_task,theta_task] = pre_task(Sube(i),setpath,Subj(i),behavior_files,control_files,del_files);
    [data_con,theta_con] = pre_con(Sube(i),setpatha,Subj(i),behavior_filesa,control_filesa,del_filesa);


    angspace=(-pi:pi/6:pi)'; % angular space for tuning curve (in radians)
    angspace(end)=[];
    bin_width=pi/6; % width of each angle bin of the tuning curve (in radians)
    [cos_amp, d_tune] = mahalTune_func_new(data_con,data_task,theta_con,theta_task,angspace,bin_width);

    save_fileName = strcat(save_files,'Angle_',num2str(Sube(i)),'.mat');
    save(save_fileName,'cos_amp');
    save_fileName1 = strcat(save_files1,'Angle_',num2str(Sube(i)),'.mat');
    save(save_fileName1,'d_tune');
end



function [data_new,theta]=pre_task(Sube,setpath,Subj,behavior_files,control_files,del_files)
setname=strcat('S',num2str(Sube),'_WM.set');
EEG= pop_loadset('filename',setname,'filepath',setpath);
EEG= eeg_checkset( EEG );
data= EEG.data;
times = EEG.times;
startTime = find(times==2700);
endTime = length(times);
data_new = permute(data,[3,1,2]);
data_new = data_new(:,:,startTime:endTime);
%——————————————————————————————————————%
[trial_type,all_distraction,trial_index] = angle_task_choose(Subj,behavior_files,control_files,del_files);
data_new = data_new(trial_index,:,:);
theta = deg2rad(all_distraction)*2;

end

function [data_new,theta] = pre_con(Sube,setpath,Subj,behavior_files,control_files,del_files)
setname=strcat('S',num2str(Sube),'_WM.set');
EEG= pop_loadset('filename',setname,'filepath',setpath);
EEG= eeg_checkset( EEG );
data= EEG.data;

data_new = permute(data,[3,1,2]);
[trial_type,all_distraction,trial_index] = angle_choose(Subj,behavior_files,control_files,del_files);
theta = deg2rad(all_distraction)*2;

end

