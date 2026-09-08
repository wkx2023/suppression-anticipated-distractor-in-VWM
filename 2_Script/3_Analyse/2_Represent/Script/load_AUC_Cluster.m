%% 2025-12-16

%% load AUC
function [predict,predict_Diag] = load_AUC_Cluster(predict_mat_file,matFiles,TimeLength,N)
if ~isempty(matFiles)
    predict = NaN(TimeLength,TimeLength,N);
    predict_Diag = NaN(TimeLength,N);
    for k = 1:length(matFiles)
        fileName = fullfile(predict_mat_file,matFiles(k).name);
        data = load(fileName);
        disp(fileName)
        AUC = data.AUC_all; % 400 * 3 * 400
        AUC = squeeze(mean(AUC,2)); % 400 * 400
        predict(:,:,k) = AUC; % 400 * 400 * 30
        predict_Diag(:,k) = diag(AUC); % 400 * 1 * 30
    end
end
end