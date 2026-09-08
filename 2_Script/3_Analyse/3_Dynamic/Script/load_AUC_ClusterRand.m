%% load AUC
function [predict] = load_AUC_ClusterRand(predict_mat_file,matFiles,TimeLength,N)
if ~isempty(matFiles)
    predict = zeros(TimeLength,TimeLength,10,N);
    for k = 1:length(matFiles)
        fileName = fullfile(predict_mat_file,matFiles(k).name);
        data = load(fileName);
        disp(fileName)
        AUC = data.AUC_all;
        AUC = squeeze(mean(AUC,2));
        predict(:,:,:,k) = AUC;
    end
end
end