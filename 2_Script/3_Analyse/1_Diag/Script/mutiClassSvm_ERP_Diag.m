function [predictAccForTrainSet,predictAcc,times] = mutiClassSvm_ERP_Diag(EEG,labels, times, numOfVal,superTrial,file_path,file_path1,file_path2,file_path3,time_phase,Cond)

% 只留下通道 时间和 trial

for j=1:length(Cond)
    disp(Cond(j))
    if j == labels(1)
        data1EEG = pop_epoch( EEG, Cond(j), time_phase, 'newname', 'Merged datasets pruned with ICA   epochs epochs', 'epochinfo', 'yes');
        data1EEG = eeg_checkset( data1EEG );
    end
    if j== labels(2)
        data2EEG = pop_epoch( EEG, Cond(j), time_phase, 'newname', 'Merged datasets pruned with ICA   epochs epochs', 'epochinfo', 'yes');
        data2EEG = eeg_checkset( data2EEG );
    end
    if j== labels(3)
        data3EEG = pop_epoch( EEG, Cond(j), time_phase, 'newname', 'Merged datasets pruned with ICA   epochs epochs', 'epochinfo', 'yes');
        data3EEG = eeg_checkset( data3EEG );
    end
end


data1 = data1EEG.data;
data2 = data2EEG.data;
data3 = data3EEG.data;

timeCourse = size(data1,2);

disp(size(data1));
disp(size(data2));
disp(size(data3));


predictAccForTrainSet = zeros(numOfVal,timeCourse);
predictAcc = zeros(timeCourse,1,numOfVal);
AUC_all = zeros(timeCourse,3,1,numOfVal);
transformWeight = zeros(timeCourse,3,64,numOfVal);




for ii = 1:numOfVal
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

    allLabels = [ones(size(dataSup1,3),1); ones(size(dataSup2,3),1)*2; ones(size(dataSup3,3),1)*3];
    allTrials = cat(3,dataSup1,dataSup2,dataSup3);

    if isempty(dataSup1) || isempty(dataSup2) || isempty(dataSup3)
        error('超级 trial 数据为空！');
    end
   

    classOrder = unique(allLabels);
    t = templateSVM('Standardize',1);
    

    %------------------------------
    for trainTime = 1:timeCourse
        %predictAcc4TimeX = zeros(1,timeCourse);
        AUCs = zeros(3,1);
        transformWeight_an = zeros(3,64);
        cv = cvpartition(allLabels, 'HoldOut', 0.20, 'Stratify', true);

        CVMdl = fitcecoc(allLabels,allLabels,'CVPartition', cv,'Learners',t,'ClassNames',classOrder);%相当于59行
       
        
        %CVMdl = fitcecoc(allLabels,allLabels,'Holdout',0.20,'Learners',t,'ClassNames',classOrder);%øS59L
        
        trainingInds = training(CVMdl.Partition); % Extract the training indices
        testInds = test(CVMdl.Partition);  % Extract the test indices
        
        
        
        if sum(trainingInds) == 0
            error('训练集索引为空！');
        end

        
        trials4training = allTrials(:,trainTime,trainingInds);
        trials4training = squeeze(trials4training);
        trainSample = trials4training';
        disp(size(trials4training));


        disp(['Number of training samples: ', num2str(sum(trainingInds))]);
        disp(['Number of test samples: ', num2str(sum(testInds))]);


        trainC = allLabels(trainingInds);
        testC = allLabels(testInds);


        Mdl = fitcecoc(trainSample,trainC,'Learners',t,'ClassNames',classOrder);% 相当于73行 t就相当于是否要标准化
        disp(size(trainSample))
        
        for betai =1:3
            % w = Mdl.BinaryLearners{betai,1}.Beta;
            % X_centered = trainSample - mean(trainSample, 1);  % 按行中心化（每列对应一个通道）
            % Value_Beta = cov(trainSample) * w * pinv(cov(X_centered*w));
            % Value_Beta = Value_Beta ./ sqrt(sum(Value_Beta.^2, 1));  % 按列标准化（可选，根据需求关闭）
            % transformWeight_an(betai,:) = Value_Beta;

            w = Mdl.BinaryLearners{betai,1}.Beta;
            transformWeight_an(betai,:) = cov(trainSample) * w * inv(cov(trainSample*w));
            
        end

        transformWeight(trainTime,:,:,ii) = transformWeight_an;

        [label,score] = predict(Mdl,trainSample);
        predictAccForTrainSet(ii,trainTime) = sum(trainC == label)/length(trainC);
        

        currentTestTime = trainTime % test for all time points

        trials4testing = allTrials(:,currentTestTime,testInds);
        trials4testing = squeeze(trials4testing);
        testSample = trials4testing';

        [label,score] = predict(Mdl,testSample);
        predictAcc4TimeX = sum(testC == label)/length(testC);



        for aui = 1:3
            [X,Y,T,AUCi] = perfcurve(testC,score(:,aui),aui);
            AUCs(aui,1) = AUCi;
        end
       
       
        
       
        disp([num2str(times(trainTime)), '.  The mean prediction for the training set is ' num2str(predictAccForTrainSet(ii,trainTime)) '. The mean prediction is  ' num2str(predictAcc4TimeX) ])
        predictAcc(trainTime,:,ii) = predictAcc4TimeX;
        AUC_all(trainTime,:,:,ii) = AUCs;
        
    end


end



%predictAcc = mean(predictAcc,3);
%predictAccForTrainSet = mean(predictAccForTrainSet,1);
%AUC_all = mean(AUC_all,4);
%transformWeight = mean(transformWeight,4);

save(file_path,"predictAcc");
%save(file_path1,"predictAccForTrainSet");
save(file_path2,"AUC_all");
%save(file_path3,"transformWeight");


clear predictAcc predictAccForTrainSet AUC_all transformWeight_an



