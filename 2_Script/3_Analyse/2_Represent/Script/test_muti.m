function test_muti(Subj,Cond,file_all,labels,file_path_all,time_phase)

setpath=[file_all,filesep]; 

for Subi=1:length(Subj)
  
    setname=strcat('S',num2str(Subj(Subi)),'_WM.set'); 
    EEG= pop_loadset('filename',setname,'filepath',setpath); 
    EEG= eeg_checkset( EEG );

    
    numOfVal = 10;
    times = EEG.times;

    file_path=strcat(file_path_all,'S',num2str(Subj(Subi)),'_predict''.mat');
    file_path1=strcat(file_path_all,'S',num2str(Subj(Subi)),'_TrailNumber','.mat');
    file_path2=strcat(file_path_all,'S',num2str(Subj(Subi)),'_AUC','.mat');

    
    mutiClassSvm_ERP_Rand(EEG,labels, times, numOfVal,file_path,file_path1,file_path2,time_phase,Cond);

    clear EEG
 end