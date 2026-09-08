% 获取训练集和测试集
% 格式为时间* 特征* 试次
% 获取所有的trial对应的角度
clear all


behavior_files = 'G:\EEG_data\Behavioral\Task\';
file_all ='G:\EEG_data\Task';
save_files = 'G:\Function_Matlab\MahalTune\Result_mal\Task\Ori\cos\';
save_files1 = 'G:\Function_Matlab\MahalTune\Result_mal\Task\Ori\dune\';

warning('off', 'all');
setpath=[file_all,filesep];
Sube = [103:105,107:114];
Subj = [1103:1105,1107:1114];


for i=1:length(Subj)

    setname=strcat('S',num2str(Sube(i)),'_WM.set');
    EEG= pop_loadset('filename',setname,'filepath',setpath);
    EEG= eeg_checkset( EEG );
    sample_rate=EEG.srate;
    

    times = EEG.times;
    startTime = find(times==2700);
    endTime = length(times);

    

    %——————————————————————————————————————%

    all_distraction = angle_task_choose(Subj(i),behavior_files); % 整理每个trial的角度

    CondDis = {'B1(S11)' ,'B2(S11)' ,'B4(S11)' };
    time_phase = [-0.6,4.3];
    EEG = pop_epoch( EEG, CondDis, time_phase, 'newname', 'Merged datasets pruned with ICA   epochs epochs', 'epochinfo', 'yes');
    EEG = eeg_checkset( EEG );
    data= EEG.data; % 只获取干扰脑电

    data_new = permute(data(:,:,:),[3,1,2]);% 整理为trial*channel*time
    data_new = data_new(:,:,startTime:endTime);


    theta = deg2rad(all_distraction)*2;
    angspace=(-pi:pi/6:pi)'; % angular space for tuning curve (in radians)
    angspace(end)=[];
    bin_width=pi/6; % width of each angle bin of the tuning curve (in radians)
    [cos_amp, d_tune] = mahalTune_func(data_new,theta,angspace,bin_width);
    save_fileName = strcat(save_files,'Angle_',num2str(Sube(i)),'.mat');
    save(save_fileName,'cos_amp');
    save_fileName1 = strcat(save_files1,'Angle_',num2str(Sube(i)),'.mat');
    save(save_fileName1,'d_tune');
    clear d_tune cos_amp EEG data data_new all_distraction theta

end


