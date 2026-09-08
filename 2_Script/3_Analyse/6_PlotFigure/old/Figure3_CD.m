%% Hz_Plot (5 - 7 Hz;8 - 14 Hz; 15-30Hz)  2026/01/13


clear 

Subj = [101:105,107:111,113:116,118:120,122:128,130:135];

Hz = [5:30];
HzPlot = {[5,7],[8,14],[15,30]};

time = [-600:4:4296];

colors =[0.0392156862745098,0.113725490196078,0.541176470588235;...
    0.109803921568627,0.501960784313726,0.254901960784314;...
    0.898039215686275,0.341176470588235,0.0352941176470588];

filename = 'G:\Function_Matlab\SVM\OneDay\Result_Hz\NoERP_OneDay\';
resultsSave = 'G:\Function_Matlab\WM_Distractor\Figure_E1\';

All_AUC = NaN(length(Subj),length(Hz),length(time));

for i = 1:length(Hz)
    for j =1:length(Subj)
        matName = strcat(filename,'S',num2str(Subj(j)),'_AUC_',num2str(Hz(i)));
        AUC_mat = load(matName);
        AUC = AUC_mat.AUC_all;
        AUC = mean(AUC,2);
        AUC = imgaussfilt(AUC,4);
        All_AUC(j,i,:) = AUC;
    end
end


PlotHz_Diag(Subj,All_AUC,time,Hz,HzPlot,colors,resultsSave)