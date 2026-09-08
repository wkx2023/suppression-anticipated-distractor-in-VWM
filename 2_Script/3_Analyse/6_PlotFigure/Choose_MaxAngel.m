function [FileIndex_Sub,MaxAngle_sub,Decodvalue_Sub] = Choose_MaxAngel(Sube,OriFile,Angle,Angle_Shift,Index_Angle,time)

FileIndex_Sub = NaN(1,length(Sube));
MaxAngle_sub = NaN(1,length(Sube));
Decodvalue_Sub = NaN(1,length(Sube));

for subj = 1:length(Sube)

    cos_amp_Sub = zeros(length(Angle),length(time));

    for filei = 1:length(Angle)

        filei_Index = Index_Angle(filei);
        filename = strcat(OriFile,num2str(filei_Index),'\');

        matName = strcat(filename,'Angle_',num2str(Sube(subj)),'.mat');
        mat = load(matName);
        cos_amp = mat.cos_amp;
        cos_amp = mean(cos_amp,1);
        cos_amp_Sub(filei,:) =  cos_amp;

    end

    cos_max_Sub = cos_amp_Sub(:,find(time==100):find(time==500));
    cos_max_Sub = mean(cos_max_Sub,2);
    [m,p] = max(cos_max_Sub); % m: max_Value; p: max_Index

    FileIndex_Sub(subj) = Index_Angle(p); % max File Index
    MaxAngle_sub(subj) = Angle_Shift(p); % max orientation Angle
    Decodvalue_Sub(subj) = m; % max Decoding value

end


end