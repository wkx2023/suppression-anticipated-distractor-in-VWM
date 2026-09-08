function Plot_MahalTuneImagesc(File_Ori,File_Rotated,Sube,Angle,Index_Angle,time,resultsSave,saveName)

s_factor = 4;

cos_amp_all = NaN(length(Angle),length(time));

for filei = 1:length(Angle)

    filei_Index = Index_Angle(filei);

    if filei_Index == 0

        cos_amp_Sub = zeros(length(Sube),400);

        for subj = 1:length(Sube)
            matName = strcat(File_Ori,'\Angle_',num2str(Sube(subj)),'.mat');
            mat = load(matName);
            cos_amp = mat.cos_amp;
            cos_amp=imgaussfilt(mean(cos_amp,1),s_factor);
            cos_amp_Sub(subj,:) =  cos_amp;
        end

    else

        filename = strcat(File_Rotated,num2str(filei_Index),'\');
        cos_amp_Sub = zeros(length(Sube),400);

        for subj = 1:length(Sube)
            matName = strcat(filename,'Angle_',num2str(Sube(subj)),'.mat');
            mat = load(matName);
            cos_amp = mat.cos_amp;
            cos_amp = imgaussfilt(mean(cos_amp,1),s_factor);
            cos_amp_Sub(subj,:) =  cos_amp;
        end
      
    end

    cos_amp_all(filei,:) = mean(cos_amp_Sub,1);
end

fig1 = figure(1);

imagesc(time,Angle,cos_amp_all)
%colormap('jet')
colorbar;


hold on
%yticks([1,2,3,4,5,6,7,8,9,10,11,12,13])
yticks([-90,-75,-60,-45,-30,-15,0,15,30,45,60,75,90])
yticklabels({'90','','60','','30','','0','','-30','','-60','','-90'})

xticks([-400,-200,0,200,400,500,600,800,996])
xticklabels({'-0.4','-0.2','0','0.2','0.4','','0.6','0.8','1'})

clim([-0.0025,0.0025])
hold on
plot([0,0],[-100,100],'--','Color','k','LineWidth',1)
xlabel('Time from onset (s)','Fontsize',10)
ylabel('Orientation (degrees)','Fontsize',10)

% saveas(fig1,fullfile(resultsSave,saveName))
% close(fig1)



end