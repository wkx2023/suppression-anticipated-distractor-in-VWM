function test_muti_NoErp(Subj,Cond,file_all,labels,file_path_all,time_phase)

setpath=[file_all,filesep]; 

for Subi=1:length(Subj)
  
    setname=strcat('S',num2str(Subj(Subi)),'_WM.set'); 
    EEG= pop_loadset('filename',setname,'filepath',setpath); 
    EEG= eeg_checkset( EEG );

    for ff = 20
    
    disp(ff);
    freqRange = [ff-2,ff+2];
    srate=EEG.srate;

    data_original = EEG.data;
    data_ERP = mean(data_original,3);
    data_original = data_original-data_ERP;
    
    data_new = hilbert_eeg(data_original, freqRange, srate);
    EEG.data = data_new;
    
    
    numOfVal =100;
    superTrial =2;
    times = EEG.times;

    file_path=strcat(file_path_all,'S',num2str(Subj(Subi)),'_predict_',num2str(ff),'.mat');
    file_path1=strcat(file_path_all,'S',num2str(Subj(Subi)),'_predictAccForTrainSet_',num2str(ff),'.mat');
    file_path2=strcat(file_path_all,'S',num2str(Subj(Subi)),'_AUC_',num2str(ff),'.mat');
    file_path3=strcat(file_path_all,'S',num2str(Subj(Subi)),'_Beta_',num2str(ff),'.mat');

    % file_path=strcat(file_path_all,'S',num2str(Subj(Subi)),'_predict','.mat');
    % file_path1=strcat(file_path_all,'S',num2str(Subj(Subi)),'_predictAccForTrainSet','.mat');
    % file_path2=strcat(file_path_all,'S',num2str(Subj(Subi)),'_AUC','.mat');
    % file_path3=strcat(file_path_all,'S',num2str(Subj(Subi)),'_Beta','.mat');


    
    mutiClassSvm_ERP_Diag(EEG,labels, times, numOfVal,superTrial,file_path,file_path1,file_path2,file_path3,time_phase,Cond);

    end
end