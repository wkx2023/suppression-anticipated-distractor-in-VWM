
function mutiClassSvm_ERP_3svm(EEG_T,EEG_C,labels1,labels2, times,superTrial,file_path,file_path1,file_path2,type)

timeCourse = size(times,2);

predictAccForTrainSet = zeros(timeCourse);
predictAcc = zeros(timeCourse,timeCourse);
AUC_all = zeros(timeCourse,3,timeCourse);

if type == 1
    time_phase_T = [-0.6 1];%时频分析全段时间
    Cond_T = {'B1(S45)' ,'B2(S46)' ,'B3(S48)' };

    time_phase_C = [2.7 4.3];%时频分析全段时间
    Cond_C = {'B1(S11)' ,'B2(S11)' ,'B3(S11)','B4(S11)' };
elseif type==2
    time_phase_C = [-0.6 1];%时频分析全段时间
    Cond_C = {'B1(S45)' ,'B2(S46)' ,'B3(S48)' };

    time_phase_T = [2.7 4.3];%时频分析全段时间
    Cond_T = {'B1(S11)' ,'B2(S11)' ,'B3(S11)','B4(S11)' };
end


for j=1:length(Cond_T)
    disp(Cond_T(j))
    if j == labels1(1)
        data1EEG = pop_epoch( EEG_T, Cond_T(j), time_phase_T, 'newname', 'Merged datasets pruned with ICA   epochs epochs', 'epochinfo', 'yes');
        data1EEG = eeg_checkset( data1EEG );
    end
    if j== labels1(2)
        data2EEG = pop_epoch( EEG_T, Cond_T(j), time_phase_T, 'newname', 'Merged datasets pruned with ICA   epochs epochs', 'epochinfo', 'yes');
        data2EEG = eeg_checkset( data2EEG );
    end
    if j== labels1(3)
        data3EEG = pop_epoch( EEG_T, Cond_T(j), time_phase_T, 'newname', 'Merged datasets pruned with ICA   epochs epochs', 'epochinfo', 'yes');
        data3EEG = eeg_checkset( data3EEG );
    end
end

data1 = data1EEG.data;
data2 = data2EEG.data;
data3 = data3EEG.data;



for j=1:length(Cond_C)
    disp(Cond_C(j))
    if j == labels2(1)
        data4EEG = pop_epoch( EEG_C, Cond_C(j), time_phase_C, 'newname', 'Merged datasets pruned with ICA   epochs epochs', 'epochinfo', 'yes');
        data4EEG = eeg_checkset( data4EEG );
    end
    if j== labels2(2)
        data5EEG = pop_epoch( EEG_C, Cond_C(j), time_phase_C, 'newname', 'Merged datasets pruned with ICA   epochs epochs', 'epochinfo', 'yes');
        data5EEG = eeg_checkset( data5EEG );
    end
    if j== labels2(3)
        data6EEG = pop_epoch( EEG_C, Cond_C(j), time_phase_C, 'newname', 'Merged datasets pruned with ICA   epochs epochs', 'epochinfo', 'yes');
        data6EEG = eeg_checkset( data6EEG );
    end
end
data4 = data4EEG.data;
data5 = data5EEG.data;
data6 = data6EEG.data;





    %------------------------------ randomly sample trials to make
    %super trials
    if superTrial > 1
        % make super trials
        dataSup1 = func_make_superTrials(data1,superTrial);
        dataSup2 = func_make_superTrials(data2,superTrial);
        dataSup3 = func_make_superTrials(data3,superTrial);
    else
        dataSup1 = data1;
        dataSup2 = data2;
        dataSup3 = data3;
    end

    allLabels_train = [ones(size(dataSup1,3),1); ones(size(dataSup2,3),1)*2; ones(size(dataSup3,3),1)*3];
    allTrials_train = cat(3,dataSup1,dataSup2,dataSup3);


    if superTrial > 1
        % make super trials
        dataSup4 = func_make_superTrials(data4,superTrial);
        dataSup5 = func_make_superTrials(data5,superTrial);
        dataSup6 = func_make_superTrials(data6,superTrial);
    else
        dataSup4 = data4;
        dataSup5 = data5;
        dataSup6 = data6;
    end

    allLabels_test = [ones(size(dataSup4,3),1); ones(size(dataSup5,3),1)*2; ones(size(dataSup6,3),1)*3];
    allTrials_test = cat(3,dataSup4,dataSup5,dataSup6);


    classOrder = unique(allLabels_train);
    t = templateSVM('Standardize',1);


    %------------------------------
    parfor trainTime = 1:timeCourse
        predictAcc4TimeX = zeros(1,timeCourse);
        % CVMdl = fitcecoc(allLabels,allLabels,'Holdout',0.20,'Learners',t,'ClassNames',classOrder);%相当于59行
        AUCs = zeros(3,timeCourse);

        trials4training = allTrials_train(:,trainTime,:);
        trials4training = squeeze(trials4training);
        trainSample = trials4training';


        trainC = allLabels_train;
        testC = allLabels_test;


        Mdl = fitcecoc(trainSample,trainC,'Learners',t,'ClassNames',classOrder);% 相当于73行 t就相当于是否要标准化
        
       

        [label,score] = predict(Mdl,trainSample);
        predictAccForTrainSet(trainTime) = sum(trainC == label)/length(trainC);
        

        for currentTestTime = 1:timeCourse % test for all time points

            trials4testing = allTrials_test(:,currentTestTime,:);
            trials4testing = squeeze(trials4testing);
            testSample = trials4testing';
            [label,score] = predict(Mdl,testSample);
            predictAcc4TimeX(currentTestTime) = sum(testC == label)/length(testC);

            for aui = 1:3
                %label =categorical(label);
                %aui_new = categorical(aui);
                [X,Y,T,AUCi] = perfcurve(testC,score(:,aui),aui);
                AUCs(aui,currentTestTime) = AUCi;
            end
       

 
        end
        
        

        disp([num2str(times(trainTime)), '.  The mean prediction for the training set is ' num2str(predictAccForTrainSet(trainTime)) '. The mean prediction is  ' num2str(predictAcc4TimeX(trainTime)) ])
        predictAcc(trainTime,:) = predictAcc4TimeX;
        AUC_all(trainTime,:,:) = AUCs;
        
    end




% predictAcc = mean(predictAcc,3);
% predictAccForTrainSet = mean(predictAccForTrainSet,1);


save(file_path,"predictAcc");
save(file_path1,"predictAccForTrainSet");
save(file_path2,"AUC_all");

disp('ok!')