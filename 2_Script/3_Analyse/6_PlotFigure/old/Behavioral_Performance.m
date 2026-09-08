function [sub_Angle,Error_Behavioral] = Behavioral_Performance(Subj,behavior_files,OriFile,Angle,Index_Angle,time,Angle_Shift)


disp(Subj);
behave_file = strcat(behavior_files,num2str(Subj),'_data.mat');
behave_data = load(behave_file);

Index_dis = behave_data.index_type_all;
Error_Behavioral = behave_data.new_error;

Index_dis = find(Index_dis~=3);
Error_Behavioral = abs(Error_Behavioral(Index_dis));





cos_amp_Sub = zeros(length(Angle),length(Error_Behavioral),length(time));

for filei = 1:length(Angle)

    filei_Index = Index_Angle(filei);
    filename = strcat(OriFile,num2str(filei_Index),'\');

    matName = strcat(filename,'Angle_',num2str(Subj),'.mat');
    mat = load(matName);
    cos_amp = mat.cos_amp;
    cos_amp_Sub(filei,:,:) =  cos_amp;

end

    cos_max_Sub = cos_amp_Sub(:,:,find(time==100):find(time==500));
    cos_max_Sub = mean(cos_max_Sub,3);
    [m,p] = max(cos_max_Sub,[],1); % m: max_Value; p: max_Index

    sub_Angle = Angle_Shift(p);


    % 剔除极端值
    % length_First = length(Error_Behavioral);
    % Error_Behavioral = Error_Behavioral(length_First/2:end);
    % sub_Angle = sub_Angle(length_First/2:end);

    % std_val = std(Error_Behavioral);
    % threshold = 3;
    % normal_idx = abs(Error_Behavioral - mean_val) <= threshold * std_val;
    % Error_Behavioral = Error_Behavioral(normal_idx);
    % sub_Angle = sub_Angle(normal_idx);


end



