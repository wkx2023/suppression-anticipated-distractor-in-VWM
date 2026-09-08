
%% The function of this code is to preprocess EEG data
%% Author:kangkang

function EEG = preprocess_filter(sub_number,setpath,save_path)
if strcmp(sub_number,'21_1')
    par_len = 1;
else
    par_len = length(sub_number);
end

for sub = 1:par_len
    if sub_number(sub)==3
        %EEG = pop_loadset('filename',strcat('S',num2str(sub_number(sub)),'.set'),'filepath',setpath);
        %EEG = eeg_checkset( EEG );
        EEG = pop_loadbv(setpath, strcat('S',num2str(sub_number(sub)),'.vhdr'), [], [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64]);
        EEG = eeg_checkset( EEG );
    elseif strcmp(sub_number,'21_1')
        EEG = pop_loadbv(setpath, strcat('S',sub_number,'.vhdr'), [], [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64]);
        EEG = eeg_checkset( EEG );
    else
        EEG = pop_loadbv(setpath, strcat('S',num2str(sub_number(sub)),'.vhdr'), [], [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64]);
        EEG = eeg_checkset( EEG );
    end

    pop_expevents(EEG, 'F:\Data\task.txt', 'samples');

    if sub_number(sub)==3
        marker;
    else
        mark_usual;
    end

    EEG = pop_importevent( EEG, 'append','no','event','F:\\Data\\event_task.txt','fields',{'latency','type'},'skipline',1,'timeunit',0.001,'align',0);
    EEG = eeg_checkset( EEG );

    if strcmp(sub_number,'21_1')
        EEG = pop_saveset( EEG, 'filename',strcat('S',sub_number,'_newCon','.set'),'filepath',save_path);
        EEG = eeg_checkset( EEG );
    else
        EEG = pop_saveset( EEG, 'filename',strcat('S',num2str(sub_number(sub)),'_newCon','.set'),'filepath',save_path);
        EEG = eeg_checkset( EEG );
    end



    EEG=pop_chanedit(EEG, 'lookup','D:\\AppGallery\\Downloads\\matlab\\toolbox\\eeglab\\eeglab2024.0\\plugins\\dipfit\\standard_BEM\\elec\\standard_1005.elc','append',1,'changefield',{2,'labels','FCz'},'lookup','D:\\AppGallery\\Downloads\\matlab\\toolbox\\eeglab\\eeglab2024.0\\plugins\\dipfit\\standard_BEM\\elec\\standard_1005.elc');
    EEG = eeg_checkset( EEG );


    EEG = pop_resample( EEG, 250);
    EEG = eeg_checkset( EEG );


    EEG = pop_eegfiltnew(EEG, 'locutoff',0.5,'plotfreqz',1);
    EEG = eeg_checkset( EEG );
    EEG = pop_eegfiltnew(EEG, 'locutoff',47,'hicutoff',53,'revfilt',1,'plotfreqz',1);
    EEG = eeg_checkset( EEG );

    

    if strcmp(sub_number,'21_1')
        EEG = pop_saveset( EEG, 'filename',strcat('S',sub_number,'_filter','.set'),'filepath',save_path);
        EEG = eeg_checkset( EEG );
    else
        EEG = pop_saveset( EEG, 'filename',strcat('S',num2str(sub_number(sub)),'_filter','.set'),'filepath',save_path);
        EEG = eeg_checkset( EEG );
    end




end