% 获取训练集和测试集
% 格式为时间* 特征* 试次
% 获取所有的trial对应的角度
clear

del_files = 'F:\WMD_Script\del_trial_control\';
control_files = 'E:\WM_Dis\data_control\';
behavior_files = 'F:\WMD_Script\Behavioral\Participants_EEG_control\';
file_all ='F:\EEG\Data\analyse_con\processing';
save_files = 'F:\WM_analyse\angle_decoing\result_0219\';
save_files1 = 'F:\WM_analyse\angle_decoing\result_tune_0219\';

warning('off', 'all');
setpath=[file_all,filesep];
Sube = [2:8,10:17,19,20,22:34];
Subj = [1012,1014:1019,1021,1023:1029,1032,1034,1036:1041,1043:1049];
% Sube = [3];
% Subj = [1014];

% Sube = [2];
% Subj = [1012];
% 
% 


% Sube = [24:29];
% Subj = [1038:1041,1043,1044];
for i=1:length(Subj)

    setname=strcat('S',num2str(Sube(i)),'_WM.set');
    EEG= pop_loadset('filename',setname,'filepath',setpath);
    EEG= eeg_checkset( EEG );
    sample_rate=EEG.srate;
    data= EEG.data;
    times = EEG.times;

    data_new = permute(data,[3,1,2]);

    %——————————————————————————————————————%

    [trial_type,all_distraction,trial_index] = angle_choose(Subj(i),behavior_files,control_files,del_files);

    theta = deg2rad(all_distraction)*2;

    angspace=(-pi:pi/6:pi)'; % angular space for tuning curve (in radians)

    angspace(end)=[];
    bin_width=pi/6; % width of each angle bin of the tuning curve (in radians)

    [cos_amp, d_tune] = mahalTune_func(data_new,theta,angspace,bin_width);

    save_fileName = strcat(save_files,'Angle_',num2str(Sube(i)),'.mat');
    save(save_fileName,'cos_amp');
    save_fileName1 = strcat(save_files1,'Angle_',num2str(Sube(i)),'.mat');
    save(save_fileName1,'d_tune');

end

%% 不取绝对值：如果您想保留解码精度与马氏距离之间的直接关系，
% 即高马氏距离对应低解码精度（因为您已经通过负号调整了符号），
% 那么您可以直接使用 cos_amp 的值来画图。
% 这样，图表上的峰值将表示最低的解码精度，这在某些情况下可能是有意义的，特别是当您希望强调解码精度的降低时。

% 取绝对值：如果您更关心解码精度的大小而不是其符号，或者您希望图表上的峰值表示最高的解码精度，
% 那么您可以取 cos_amp 的绝对值来画图。这样，图表将显示解码精度的绝对大小，峰值将表示最高的解码精度。