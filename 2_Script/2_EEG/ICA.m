function EEG = ICA(sub_number,setpath,save_path)

for sub =1:length(sub_number)

    EEG = pop_loadset('filename',strcat('S',num2str(sub_number(sub)),'_poptrial1','.set'),'filepath',setpath);
    EEG = eeg_checkset( EEG );

    %EEG = pop_runica(EEG, 'icatype', 'runica');
    EEG = pop_runica(EEG, 'icatype', 'runica', 'extended',1,'rndreset','yes','interrupt','on');
    EEG = eeg_checkset( EEG );

    EEG = pop_saveset( EEG, 'filename',strcat('S',num2str(sub_number(sub)),'_ICA','.set'),'filepath',save_path);
    EEG = eeg_checkset( EEG );

end
