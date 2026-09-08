function test_muti_Diag(Subj,Cond,file_all,labels,file_path_all,time_phase)

setpath=[file_all,filesep]; 

for Subi=1:length(Subj)
  
    setname=strcat('S',num2str(Subj(Subi)),'_WM.set'); 
    EEG= pop_loadset('filename',setname,'filepath',setpath); 
    EEG= eeg_checkset( EEG );
    
    
    numOfVal =100;
    superTrial =2;
    times = EEG.times;


    file_path=strcat(file_path_all,'S',num2str(Subj(Subi)),'_predict','.mat');
    file_path1=strcat(file_path_all,'S',num2str(Subj(Subi)),'_predictAccForTrainSet','.mat');
    file_path2=strcat(file_path_all,'S',num2str(Subj(Subi)),'_AUC','.mat');
    file_path3=strcat(file_path_all,'S',num2str(Subj(Subi)),'_Beta','.mat');



    mutiClassSvm_ERP_Diag(EEG,labels, times, numOfVal,superTrial,file_path,file_path1,file_path2,file_path3,time_phase,Cond);

end


end