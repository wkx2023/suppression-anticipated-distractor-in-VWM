function EEG = REF(sub_number,setpath,save_path)

for sub =1:length(sub_number)

    EEG = pop_loadset('filename',strcat('S',num2str(sub_number(sub)),'_poptrial2','.set'),'filepath',setpath);
    EEG = eeg_checkset( EEG );

    %EEG = pop_reref( EEG, [],'refloc',struct('labels',{'FCz'},'type',{''},'theta',{0.7867},'radius',{0.095376},'X',{27.39},'Y',{-0.3761},'Z',{88.668},'sph_theta',{-0.7867},'sph_phi',{72.8323},'sph_radius',{92.8028},'urchan',{2},'ref',{''},'datachan',{0}),'exclude',20);
    EEG = pop_reref( EEG, [],'refloc',struct('labels',{'FCz'},'type',{''},'theta',{0.7867},'radius',{0.095376},'X',{27.39},'Y',{-0.3761},'Z',{88.668},'sph_theta',{-0.7867},'sph_phi',{72.8323},'sph_radius',{92.8028},'urchan',{2},'ref',{''},'datachan',{0}));
    EEG = eeg_checkset( EEG );


    EEG = pop_saveset( EEG, 'filename',strcat('S',num2str(sub_number(sub)),'_WM','.set'),'filepath',save_path);
    EEG = eeg_checkset( EEG );

end
