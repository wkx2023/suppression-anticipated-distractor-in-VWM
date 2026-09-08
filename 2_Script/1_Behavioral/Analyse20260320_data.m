%% 把被试行为数据整理到一起 剔除未反应等不纳入分析的试次
%  folder是原始数据存储的位置
%  participant 是被试的序号
function Analyse20260320_data(folder,participant,sube)
rootDir = pwd;
outputDir = [rootDir,'\Behavioral_20260320\'];
if exist(outputDir,'dir')~=7
    mkdir(outputDir)
end
Analyse_data_mat(folder,participant,outputDir,sube);
end



function Analyse_data_mat(folder,participant,outputDir,sube)

files = dir(fullfile(folder, '*.mat'));
FileDates = [files.datenum]';  % 提取文件的时间信息
[~, sortedIndex] = sort(FileDates);  % 根据时间信息排序文件索引
filename_participant = fullfile(folder,num2str(participant)); % 该被试的所有行为数据

% 初始化
index_type_all=[]; % 试次类型
index_num = -1;
std_trial_num = [];
trial_num = 1:1:24;

cue = [];
error =[];
res = [];
res_time =[];
key_time = [];
dis = [];
Degree = [];
noMemory = [];

% 逐个读取文件
for i = 1:length(files)
    filename = fullfile(folder, files(sortedIndex(i)).name);
    if startsWith(filename, filename_participant)
        index_num = index_num + 1;
        disp(filename);
        data = load(filename); % 加载 .mat 文件
        var_name = 'stim';
        if isfield(data, var_name) % 检查是否存在指定的变量
            stim = data.(var_name);

            cue = [cue,stim.("cuedOri")];
            noMemory = [noMemory,stim.('secondStimOri')];
            error = [error, stim.('errorDeg')];
            res = [res,stim.('respOri')];
            res_time=[res_time,stim.('respTime')-stim.('respOnset')];
            key_time=[key_time,stim.('keyOnset')-stim.('respOnset')];

        end
        std_trial_num = [std_trial_num,trial_num+index_num*24];

        if endsWith(filename, '_ 1.mat')
           dis = [dis, stim.('distilt')];
           Degree = [Degree,stim.('tiltInDegrees')];
           index_type_all=[index_type_all,ones(1,24)];

        elseif endsWith(filename, '_ 2.mat')
            dis = [dis, stim.('distilt')];
            Degree = [Degree,stim.('tiltInDegrees')];
            index_type_all=[index_type_all,ones(1,24)*2];

        elseif endsWith(filename, '_ 3.mat')
            index_type_all=[index_type_all,ones(1,24)*3];
            dis  = [dis, NaN(1,24)];
            Degree = [Degree,NaN(1,24)];

        elseif endsWith(filename, '_ 4.mat')
            index_type_all=[index_type_all,ones(1,24)*4];
            Degree = [Degree,stim.('tiltInDegrees')];
            dis  = [dis, stim.('distilt')];

        end
    end
end

% 获取有±的误差角度
new_error = error_new(res,cue,error);

absError = new_error;
for dI = 1:length(dis)
    if dis(dI)<0
        absError(dI) = -absError(dI);
    end
end

cue = cue(~isnan(new_error));
noMemory = noMemory(~isnan(new_error));

res = res(~isnan(new_error));
res_time = res_time(~isnan(new_error));
key_time = key_time(~isnan(new_error));
index_type_all = index_type_all(~isnan(new_error));
dis = dis(~isnan(dis));
absError = absError(~isnan(new_error));
Degree = Degree(~isnan(new_error));
new_error = new_error(~isnan(new_error));

filename_mat = [outputDir,num2str(participant),'_data','.mat'];
save(filename_mat,"cue","noMemory","new_error","res", "res_time","key_time","index_type_all","absError","dis","Degree");

end


%% 获取有±的误差值 输入反应、记忆角度和误差角度
function new_error = error_new(n,c,error)

n = mod(n,180);
c = mod(c,180);

new_error = [];

for i = 1:length(n)
    if isnan(error(i))
        new_error = [new_error,NaN];
    else
        if n(i)>0
            a = n(i)-c(i);
            b = n(i)-180-c(i);
        else
            a= n(i) - c(i);
            b = n(i)+180-c(i);
        end

        index = min(abs(a),abs(b));

        if index == abs(a)
            index =a;
        else
            index = b;
        end

        new_error = [new_error,index];
    end
end


for m = 1:length(new_error)
    if new_error(m)>90
        new_error(m) = new_error(m) -180;
    elseif new_error(m)<-90
        new_error(m) = new_error(m)+180;
    end

end


end



