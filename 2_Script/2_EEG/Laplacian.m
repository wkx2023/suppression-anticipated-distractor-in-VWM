function EEG = Laplacian(sub_number,setpath,save_path)

for sub =1:length(sub_number)

    EEG = pop_loadset('filename',strcat('S',num2str(sub_number(sub)),'_WM','.set'),'filepath',setpath);
    EEG = eeg_checkset( EEG );

    X = [EEG.chanlocs.X];
    Y = [EEG.chanlocs.Y];
    Z = [EEG.chanlocs.Z];

    surf_lapP = laplacian_perrinX(EEG.data,X,Y,Z,[],1e-5); 
    EEG.data = surf_lapP;

    EEG = pop_saveset( EEG, 'filename',strcat('S',num2str(sub_number(sub)),'_Laplacian','.set'),'filepath',save_path);
    EEG = eeg_checkset( EEG );

end
