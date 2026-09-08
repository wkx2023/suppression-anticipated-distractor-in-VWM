
%% The function of this code is to preprocess EEG data
%% Author:kangkang

function EEG = preprocessStep2_filter(sub_number,setpath,save_path,channelDel)

par_len = length(sub_number);

for sub = 1:par_len
   
    EEG = pop_loadset('filename',strcat('S',num2str(sub_number(sub)),'_filter','.set'),'filepath',setpath);
    EEG = eeg_checkset( EEG );

    
    EEG = pop_interp(EEG, channelDel, 'spherical'); %插值
    EEG = eeg_checkset( EEG );
    if strcmp(sub_number,'21_1')
        EEG = pop_saveset( EEG, 'filename',strcat('S',sub_number,'_interp','.set'),'filepath',save_path);
        EEG = eeg_checkset( EEG );
    else
        EEG = pop_saveset( EEG, 'filename',strcat('S',num2str(sub_number(sub)),'_interp','.set'),'filepath',save_path);
        EEG = eeg_checkset( EEG );
    end

    EEG = pop_select( EEG, 'rmchannel',{'IO'});  %去除无关电极
    EEG = eeg_checkset( EEG );

    EEG = pop_select( EEG, 'rmchannel',{'EOG'});  %去除无关电极
    EEG = eeg_checkset( EEG );


    EEG  = pop_creabasiceventlist( EEG , 'AlphanumericCleaning', 'on', 'BoundaryNumeric', { -99 }, 'BoundaryString', { 'boundary' }, 'Eventlist', 'F:\Data\task_ERP.txt' ); % GUI: 12-Jul-2024 11:06:08
    EEG  = pop_binlister( EEG , 'BDF', 'F:\Data\Bin.txt', 'ExportEL', 'F:\Data\task_Bin.txt', 'IndexEL',  1, 'SendEL2', 'EEG&Text', 'Voutput', 'EEG' ); % GUI: 12-Jul-2024 11:07:19
    EEG = pop_epochbin( EEG , [-600.0  4300.0],  'none'); % GUI: 12-Jul-2024 11:09:45


    EEG = pop_rmbase( EEG, [-600 0] ,[]);
    EEG = eeg_checkset( EEG );
    if strcmp(sub_number,'21_1')
        EEG = pop_saveset( EEG, 'filename',strcat('S',sub_number,'.set'),'filepath',save_path);
        EEG = eeg_checkset( EEG );
    else
        EEG = pop_saveset( EEG, 'filename',strcat('S',num2str(sub_number(sub)),'.set'),'filepath',save_path);
        EEG = eeg_checkset( EEG );
    end

end