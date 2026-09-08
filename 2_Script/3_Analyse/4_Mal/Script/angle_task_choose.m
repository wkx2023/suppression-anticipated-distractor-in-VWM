%对于每个被试
% 确保脑电和行为的数据序号是一一对应的
% 首先检查了剔除脑电信号后各个条件的trial数是什么
% 其次检查各个条件下剔除了多少的trial

function  Degree = angle_task_choose(Subj,behavior_files)

for i=1:length(Subj)
    disp(Subj(i));
    % 知道每个block是什么
    % 读取文件夹
    behave_file = strcat(behavior_files,num2str(Subj(i)),'_data.mat');
    load(behave_file);
    
   
    % 将角度分为-90-90°的四种类型
    for ai = 1:length(Degree)
        if Degree(ai)>90
            Degree(ai) = Degree(ai) - 180;
        elseif Degree(ai) <=-90
            Degree(ai) = Degree(ai) + 180;
        end
    end

end