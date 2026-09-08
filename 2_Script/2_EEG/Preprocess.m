%% 第一步 预处理
clear;
sub_number = [22:34];
% setpath = 'F:\EEG_data\Task';
% save_path = 'F:\EEG_data\propresscing\task';
setpath = 'F:\Data\task';
%setpath='E:\EEG\Data\task';

save_path = 'F:\EEG\New_Data\Task';
%save_path='C:\Users\huawei\Desktop\Re';
EEG = preprocess_filter(sub_number,setpath,save_path);

%% 预处理第二步
save_path = 'F:\EEG\New_Data\Task';
%save_path='C:\Users\huawei\Desktop\Re';
preprocessStep2_filter([32],save_path,save_path,[25]);


%% 第二步 手动剔除所有的坏段


%% 第三步 ICA（记得修改一下）
sub_number = [32,27];
setpath = 'F:\EEG\New_Data\Task';
save_path = 'F:\EEG\New_Data\Task';
EEG = ICA(sub_number,setpath,save_path);


%% 第四步 手动剔除坏段


%% 第五步 重参考
sub_number = [135];
setpath = 'F:\EEG_data\propresscing\task';
save_path = 'F:\EEG_data\NoEye\task';
EEG = REF(sub_number,setpath,save_path);


%% 拉普拉斯变换
sub_number = [135];
setpath = 'F:\EEG_data\NoEye\task';
save_path = 'F:\EEG_data\Laplacian_Task';
Laplacian(sub_number,setpath,save_path)


% %% 三天被试
% % 第五步 重参考
% sub_number = [2];
% save_number = [101];
% setpath = 'F:\EEG\New_Data\Task';
% save_path = 'F:\EEG\New_Data\NoEye';
% EEG = REF_Three(sub_number,save_number,setpath,save_path);
% 
% 
% % 拉普拉斯变换
% sub_number = [101];
% setpath = 'F:\EEG\New_Data\NoEye';
% save_path = 'F:\EEG\New_Data\Laplacian_Task';
% Laplacian(sub_number,setpath,save_path)