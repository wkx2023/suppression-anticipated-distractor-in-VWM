function [trial_type,all_distraction,trial_index] = angle_choose(Subj,behavior_files,control_files,del_files)
disp(Subj);
% 知道每个block是什么
% 读取文件夹
behave_file = strcat(behavior_files,num2str(Subj),'_data.mat');
behave_data = load(behave_file);
index_dis = behave_data.sti1.errorlab;
% 序列号
trial_index = [1:330];
% 类型号
trial_type = [];
for io = 1:length(index_dis)
    trial_type = [trial_type,ones(1,55)*index_dis(io)];
end

% 获取所有的角度

%% 获取所有的干扰角度对应的trial数
% 开始遍历所有的blk文件

files = dir(fullfile(control_files, '*.mat'));
FileDates = [files.datenum]';  % 提取文件的时间信息
[~, sortedIndex] = sort(FileDates);  % 根据时间信息排序文件索引

name_par = strcat('control_',num2str(Subj));
filename_participant = fullfile(control_files,name_par);
all_distraction = [];

for filesi = 1:length(files)
    filename = fullfile(control_files, files(sortedIndex(filesi)).name);
    if startsWith(filename, filename_participant)
        data = load(filename); % 加载 .mat 文件
        var_name = 'stim';
        if isfield(data, var_name) % 检查是否存在指定的变量
            error = data.(var_name);
            tiltInDegrees = error.distilt;
            all_distraction = [all_distraction,tiltInDegrees];
        end
    end
end

% 读取要删除的trial数量
trial_file = strcat(del_files,num2str(Subj),'_trials.mat');
trial_data = load(trial_file);
del_trials = trial_data.trials;

trial_index(del_trials) = NaN;
trial_type(del_trials) = NaN;
all_distraction(del_trials) = NaN;

trial_type = trial_type(~isnan(trial_type));
all_distraction = all_distraction(~isnan(all_distraction));
trial_index = trial_index(~isnan(trial_index));

% 将角度分为-90-90°的四种类型
for ai = 1:length(all_distraction)
    if all_distraction(ai)>90
        all_distraction(ai) = all_distraction(ai) - 180;
    elseif all_distraction(ai) <=-90
        all_distraction(ai) = all_distraction(ai) + 180;
    end
end


% angspace = [-75,-60,-45,-30,-15,0,15,30,45,60,75,90];

% for ai = 1:length(all_distraction)
%     if all_distraction(ai) <=90&&all_distraction(ai)>60
%         all_distraction(ai) = 75;
%     elseif all_distraction(ai) <=60&&all_distraction(ai)>30
%         all_distraction(ai) = 45;
%     elseif all_distraction(ai) <=30&&all_distraction(ai)>0
%         all_distraction(ai) = 15;
%     elseif all_distraction(ai) <=0&&all_distraction(ai)>-30
%         all_distraction(ai) = -15;
%     elseif all_distraction(ai) <=-30&&all_distraction(ai)>-60
%         all_distraction(ai) = -45;
%     elseif all_distraction(ai) <=-60&&all_distraction(ai)>-90
%         all_distraction(ai) = -75;
%     end
% end


