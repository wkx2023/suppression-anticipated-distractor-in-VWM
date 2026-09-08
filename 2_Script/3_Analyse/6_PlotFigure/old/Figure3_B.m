%% Beta_Diatractor_Diag 2026/01/14

clear 
resultsSave = 'G:\Function_Matlab\WM_Distractor\Figure_E1\';
filename ='G:\Function_Matlab\SVM\OneDay\Result_Diag_1225\';


file_all = 'G:\EEG_data\Task';
setpath=[file_all,filesep];
setname=strcat('S',num2str(101),'_WM.set');
EEG = pop_loadset('filename',setname,'filepath',setpath);
EEG = eeg_checkset( EEG );
times = [-600:4:4296];

Subj = [101:105,107:111,113:116,118:120,122:128,130:135];


beta_values = NaN(length(Subj),3,1225,64);
for j =1:length(Subj)
    matName = strcat(filename,'S',num2str(Subj(j)),'_Beta');
    data = load(matName);
    disp(matName)
    var_name = 'transformWeight';
    Beta = data.(var_name);
    for m =1:3
        Beta_value = squeeze(Beta(:,m,:));
        beta_values(j,m,:,:) = (Beta_value) - mean(Beta_value(find(times==-600):find(times==0),:),1);
    end
end


beta_values = squeeze(mean(beta_values,2));


timeTable = [find(times==1300):find(times==3300)];
FigureName = ['Predict_Beta_Final','.svg'];

PlotEEG_Beta(EEG,beta_values,timeTable,resultsSave,FigureName)

    

timeTable = [find(times==3400):find(times==3800)];
FigureName = ['Reactive_Beta_Final','.svg'];

PlotEEG_Beta(EEG,beta_values,timeTable,resultsSave,FigureName)
