% 该文档用作提取出被试的所有数据信息
% 要存储的内容：剔除标准误和未反应试次——记忆角度、干扰偏转、反应误差、反应角度、反应时间、有效试次序号
% folder_new 是整理之后要存储的位置，folder是原始数据存储的位置
% 把trial的数也记录下来


%% 把被试行为数据整理到一起 剔除未反应等不纳入分析的试次
%  folder是原始数据存储的位置
%  participant 是被试的序号
function [index_type_all]=Analyse_data(folder,participant)

[sti1,sti2,sti3,sti4,index_type_all,push_trial]=Analyse_data_mat(folder,participant);
rootDir = pwd;
outputDir = [rootDir,'\Participants_EEG_1022\'];
if exist(outputDir,'dir')~=7
    mkdir(outputDir)
end
filename_mat = [outputDir,num2str(participant),'_data','.mat'];
save(filename_mat,"sti1","sti2","sti3", "sti4","push_trial");
end



function [sti1,sti2,sti3,sti4,index_type_all,push_trial]=Analyse_data_mat(folder,participant)

a=1;b=1;c=1;d=1; % 试次初始值
files = dir(fullfile(folder, '*.mat'));
FileDates = [files.datenum]';  % 提取文件的时间信息
[~, sortedIndex] = sort(FileDates);  % 根据时间信息排序文件索引
filename_participant = fullfile(folder,num2str(participant)); % 该被试的所有行为数据


% 初始化
index_type_all=[]; % 试次类型
index_num = -1;
std1_trial_num = [];
std2_trial_num = [];
std3_trial_num = [];
std4_trial_num = [];
trial_num = 1:1:24;


% 逐个读取文件
for i = 1:length(files)
    filename = fullfile(folder, files(sortedIndex(i)).name);
    if startsWith(filename, filename_participant)
        index_num = index_num + 1;
        disp(filename);

        if endsWith(filename, '_ 1.mat')
            index_type_all=[index_type_all,1];
            data = load(filename); % 加载 .mat 文件
            var_name = 'stim';

            if isfield(data, var_name) % 检查是否存在指定的变量
                error = data.(var_name);
                if a == 1
                    std1_fir = error.('firstStimOri'); % 未经过抖动处理的目标刺激
                    std1_cue = error.("cuedOri"); % 被试需要反应的线条角度
                    std1_dis = error.('tiltInDegrees'); % 干扰角度
                    std1_error = error.('errorDeg'); % 被试反应误差
                    std1_res = error.('respOri'); % 被试反应角度
                    std1_res_time=error.('respTime')-error.('respOnset'); % 被试反应时间
                    std1_key_time=error.('keyOnset')-error.('respOnset'); % 被试按键时间
                    std1_sed = error.('secondStimOri');
                    a = a+1 ;
                else
                    std1_fir = [std1_fir,error.('firstStimOri')];
                    std1_cue = [std1_cue,error.("cuedOri")];
                    std1_dis = [std1_dis, error.('tiltInDegrees')];
                    std1_error = [std1_error, error.('errorDeg')];
                    std1_res = [std1_res,error.('respOri')];
                    std1_res_time=[std1_res_time,error.('respTime')-error.('respOnset')];
                    std1_key_time=[std1_key_time,error.('keyOnset')-error.('respOnset')];
                    std1_sed = [std1_sed,error.('secondStimOri')];
                end
            end
            std1_trial_num = [std1_trial_num,trial_num+index_num*24];


        elseif endsWith(filename, '_ 2.mat')
            index_type_all=[index_type_all,2];
            data = load(filename); % 加载 .mat 文件
            var_name = 'stim';

            if isfield(data, var_name) % 检查是否存在指定的变量
                error = data.(var_name);
                if b ==1
                    std2_fir = error.('firstStimOri');
                    std2_cue = error.("cuedOri");
                    std2_dis = error.('tiltInDegrees');
                    std2_error = error.('errorDeg');
                    std2_res = error.('respOri');
                    std2_res_time=error.('respTime')-error.('respOnset');
                    std2_key_time=error.('keyOnset')-error.('respOnset');
                    std2_sed = error.('secondStimOri');
                    b = b+1 ;
                else
                    std2_fir = [std2_fir,error.('firstStimOri')];
                    std2_cue = [std2_cue,error.("cuedOri")];
                    std2_dis = [std2_dis, error.('tiltInDegrees')];
                    std2_error = [std2_error, error.('errorDeg')];
                    std2_res = [std2_res,error.('respOri')];
                    std2_res_time=[std2_res_time,error.('respTime')-error.('respOnset')];
                    std2_key_time=[std2_key_time,error.('keyOnset')-error.('respOnset')];
                    std2_sed = [std2_sed,error.('secondStimOri')];
                end
            end
            std2_trial_num = [std2_trial_num,trial_num+24*index_num];


        elseif endsWith(filename, '_ 3.mat')
            index_type_all=[index_type_all,3];
            data = load(filename); % 加载 .mat 文件
            var_name = 'stim';

            if isfield(data, var_name) % 检查是否存在指定的变量
                error = data.(var_name);
                if c ==1
                    std3_fir = error.('firstStimOri');
                    std3_cue = error.("cuedOri");
                    std3_error = error.('errorDeg');
                    std3_res = error.('respOri');
                    std3_res_time=error.('respTime')-error.('respOnset');
                    std3_key_time=error.('keyOnset')-error.('respOnset');
                    std3_sed = error.('secondStimOri');
                    c = c+ 1;
                else
                    std3_fir = [std3_fir,error.('firstStimOri')];
                    std3_cue = [std3_cue,error.("cuedOri")];
                    std3_error = [std3_error, error.('errorDeg')];
                    std3_res = [std3_res,error.('respOri')];
                    std3_res_time=[std3_res_time,error.('respTime')-error.('respOnset')];
                    std3_key_time=[std3_key_time,error.('keyOnset')-error.('respOnset')];
                    std3_sed = [std3_sed,error.('secondStimOri')];
                end
            end
            std3_trial_num = [std3_trial_num,trial_num+24*index_num];


        elseif endsWith(filename, '_ 4.mat')
            index_type_all=[index_type_all,4];
            data = load(filename); % 加载 .mat 文件
            var_name = 'stim';

            if isfield(data, var_name) % 检查是否存在指定的变量
                error = data.(var_name);
                if d ==1
                    std4_fir = error.('firstStimOri');
                    std4_cue = error.("cuedOri");
                    std4_dis = error.('tiltInDegrees');
                    std4_error = error.('errorDeg');
                    std4_res = error.('respOri');
                    std4_res_time=error.('respTime')-error.('respOnset');
                    std4_key_time=error.('keyOnset')-error.('respOnset');
                    std4_sed = error.('secondStimOri');
                    d = d+ 1;
                else
                    std4_fir = [std4_fir,error.('firstStimOri')];
                    std4_cue = [std4_cue,error.("cuedOri")];
                    std4_dis = [std4_dis, error.('tiltInDegrees')];
                    std4_error = [std4_error, error.('errorDeg')];
                    std4_res = [std4_res,error.('respOri')];
                    std4_res_time=[std4_res_time,error.('respTime')-error.('respOnset')];
                    std4_key_time=[std4_key_time,error.('keyOnset')-error.('respOnset')];
                    std4_sed = [std4_sed,error.('secondStimOri')];
                end
            end
            std4_trial_num = [std4_trial_num,trial_num+24*index_num];
        end
    end
end
%% 干扰偏转有正负
new1_dis = std1_dis;
new2_dis = std2_dis;
new4_dis = std4_dis;

% 获取有±的误差角度
new1_error = error_new(std1_res,std1_cue,std1_error);
new2_error = error_new(std2_res,std2_cue,std2_error);
new3_error = error_new(std3_res,std3_cue,std3_error);
new4_error = error_new(std4_res,std4_cue,std4_error);

disp(1)
[cue1_error_new,std1_error_new,dis1_error_new,res1_error_new,fir1_error_new,std1_key_time,push_trial1,sed1_error_new] = push_odd(std1_cue,std1_error,std1_dis,std1_res,std1_fir,1,std1_trial_num,std1_key_time,std1_sed);
disp(2)
[cue2_error_new,std2_error_new,dis2_error_new,res2_error_new,fir2_error_new,std2_key_time,push_trial2,sed2_error_new] = push_odd(std2_cue,std2_error,std2_dis,std2_res,std2_fir,2,std2_trial_num,std2_key_time,std2_sed);
disp(3)
[cue3_error_new,std3_error_new,dis3_error_new,res3_error_new,fir3_error_new,std3_key_time,push_trial3,sed3_error_new] = push_odd(std3_cue,std3_error,[],std3_res,std3_fir,3,std3_trial_num,std3_key_time,std3_sed);
disp(4)
[cue4_error_new,std4_error_new,dis4_error_new,res4_error_new,fir4_error_new,std4_key_time,push_trial4,sed4_error_new] = push_odd(std4_cue,std4_error,std4_dis,std4_res,std4_fir,4,std4_trial_num,std4_key_time,std4_sed);

push_trial = [];
push_trial = [push_trial,push_trial1,push_trial2,push_trial3,push_trial4];
push_trial = sort(push_trial);

sti1 = fuzhi(std1_error_new,cue1_error_new,dis1_error_new,res1_error_new,new1_error,fir1_error_new,new1_dis,std1_res_time,std1_trial_num,std1_key_time,sed1_error_new);
sti2 = fuzhi(std2_error_new,cue2_error_new,dis2_error_new,res2_error_new,new2_error,fir2_error_new,new2_dis,std2_res_time,std2_trial_num,std2_key_time,sed2_error_new);
sti3 = fuzhi(std3_error_new,cue3_error_new,dis3_error_new,res3_error_new,new3_error,fir3_error_new,[],std3_res_time,std3_trial_num,std3_key_time,sed3_error_new);
sti4 = fuzhi(std4_error_new,cue4_error_new,dis4_error_new,res4_error_new,new4_error,fir4_error_new,new4_dis,std4_res_time,std4_trial_num,std4_key_time,sed4_error_new);

end

% 去除极端值
% 计算所有种类下被试没有反应的试次
function [cue_type_new,errors_type_new,dis_type_new,res_type_new,fir_type_new,std_key_time,push_trial,sed_type_new] = push_odd(cue_type, errors_type,dis_type,res_type,fir_type,type,std_trial_num,std_key_time,sed_type)
sed_type_new = sed_type;
fir_type_new = fir_type;
cue_type_new = cue_type;
dis_type_new = dis_type;
res_type_new = res_type;
errors_type_new = errors_type;


errors_type_index = find(isnan(errors_type_new));

% 获取所有无效的试次序号
push_trial = std_trial_num(errors_type_index);
disp(push_trial);

if ~isnan(errors_type_index)
    fir_type_new(errors_type_index) = NaN;
    sed_type_new(errors_type_index) = NaN;
    cue_type_new(errors_type_index) = NaN;
    res_type_new(errors_type_index) = NaN;
    errors_type_new(errors_type_index) = NaN;
    % std_key_time(errors_type_index) = NaN;
    if type ~=3
        dis_type_new(errors_type_index) = NaN;
    end
end

% fir_type_new = fir_type_new(find(~isnan(fir_type_new)));
% cue_type_new = cue_type_new(find(~isnan(cue_type_new)));
% res_type_new = res_type_new(find(~isnan(res_type_new)));
% errors_type_new = errors_type_new(find(~isnan(errors_type_new)));
% if type ~=3
%     dis_type_new = dis_type_new(find(~isnan(dis_type_new)));
% end
end


% 进行赋值存储
function sti = fuzhi(error,cue,dis,res,newerror,fir,newdis,res_time,std_trial_num,std_key_time,sed)
sti.fir = fir;
sti.cue = cue;
sti.dis = dis;
sti.newdis = newdis;
sti.res = res;
sti.error = error;
sti.newerror = newerror;
sti.restime=res_time;
sti.std_trial_num = std_trial_num;
sti.key_time = std_key_time;
sti.sed  = sed;
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
end






%% 获取有效的试次
function [a,b,c,d] = error_without_nan(error,error1,error2,error3)
disp('1_type')
a = find(~isnan(error));
disp(find(isnan(error)))
disp('2_type')
b = find(~isnan(error1));
disp(find(isnan(error1)))
disp('3_type')
c = find(~isnan(error2));
disp(find(isnan(error2)))
disp('4_type')
d = find(~isnan(error3));
disp(find(isnan(error3)))
end




