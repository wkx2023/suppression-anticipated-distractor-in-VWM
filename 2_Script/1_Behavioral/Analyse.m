%% 整理被试脑电数据

%% 整理成四个类型各自的数据
participants = [1101:1105,1107:1111,1113:1116,1118:1120,1122:1128,1130:1135];
inputDir ="F:\Behavioral_Data\data_EEG"; % 脑电实验数据
for p =1:length(participants)
    [index_type_all] = Analyse_data(inputDir,participants(p));
end


%% 按试次顺序进行整理，仅剔除未反应试次
participants = [1101:1105,1107:1111,1113:1116,1118:1120,1122:1128,1130:1135];
sube = [101:105,107:111,113:116,118:120,122:128,130:135];
inputDir ="F:\Behavioral_Data\data_EEG"; % 脑电实验数据
for p =1:length(participants)
    Analyse20260320_data(inputDir,participants(p),sube(p))
end


%% 按试次顺序进行整理，剔除未反应试次及脑电剔除试次
participants = [1101:1105,1107:1111,1113:1116,1118:1120,1122:1128,1130:1135];
sube = [101:105,107:111,113:116,118:120,122:128,130:135];
inputDir ="F:\Behavioral_Data\data_EEG"; % 脑电实验数据
for p =1:length(participants)
    AnalyseEEG_data(inputDir,participants(p),sube(p))
end
