
function PlotCorr_Rand(Predict_task_All,Predict_reactive_All,Dynamic_task_All,resultsSave)

NameFile = ['Rand_PredictDynamic','.svg'];
Corr_Rand(Predict_task_All,Dynamic_task_All,resultsSave,NameFile)

NameFile = ['Rand_PredictReactive','.svg'];
Corr_Rand(Predict_task_All,Predict_reactive_All,resultsSave,NameFile)

NameFile = ['Rand_ReactiveDynamic','.svg'];
Corr_Rand(Predict_reactive_All,Dynamic_task_All,resultsSave,NameFile)

end


function Corr_Rand(A_Value,B_Value,resultsSave,NameFile)

% Predict_Dynamic
[r_Ori, pValue_Ori] = corr(A_Value, B_Value);
disp(['相关系数: ', num2str(r_Ori)]);
disp(['p 值: ', num2str(pValue_Ori)]);

RandInd_R = NaN(1,1000);
RandInd_P = NaN(1,1000);

for RandInd = 1:1000

    rng shuffle;  % 重置随机数种子（可选，增强随机性）
    shuffled_Predict = randperm(length(A_Value));
    Rand = A_Value(shuffled_Predict);

    [r, pValue] = corr(Rand, B_Value);

    RandInd_R(RandInd) = r;
    RandInd_P(RandInd) = pValue;

end

fig1 = figure;

% 绘制直方图并归一化
[counts, bins] = histcounts(RandInd_R);
counts = counts / sum(counts); % 归一化到概率
bin_centers = (bins(1:end-1) + bins(2:end)) / 2;
bar(bin_centers, counts, 'FaceColor', [0.8, 0.9, 1], 'EdgeColor', 'blue');
hold on;

% 计算四分位数（25%和75%位置）
q25 = prctile(RandInd_R, 25);  % 下四分位数（25%位置）
q75 = prctile(RandInd_R, 75);  % 上四分位数（75%位置）

% 绘制核密度估计曲线，更平滑地展示分布
kde = ksdensity(RandInd_R);
x_kde = linspace(min(RandInd_R), max(RandInd_R), length(kde));
plot(x_kde, kde, 'LineWidth', 2, 'Color', 'red');

hold on

% 标记25%位置
% 找到25%分位数在x_kde中的对应索引
idx25 = find(x_kde >= q25, 1);
% 绘制垂直线
plot([q25, q25], [0, kde(idx25)], 'g--', 'LineWidth', 1.5);
% 标记点和文本
plot(q25, kde(idx25), 'go', 'MarkerSize', 8, 'MarkerFaceColor', 'g');
text(q25, kde(idx25) + 0.05, '25%位置', 'Color', 'green', ...
    'HorizontalAlignment', 'center');

hold on

% 标记75%位置
idx75 = find(x_kde >= q75, 1);
plot([q75, q75], [0, kde(idx75)], 'b--', 'LineWidth', 1.5);
plot(q75, kde(idx75), 'bo', 'MarkerSize', 8, 'MarkerFaceColor', 'b');
text(q75, kde(idx75) + 0.05, '75%位置', 'Color', 'blue', ...
    'HorizontalAlignment', 'center');

newVal = r_Ori;               
p_kde = interp1(x_kde, kde, newVal, 'linear', 'extrap');  % 用 extrap 替代 NaN

% 1) 垂直参考线
xline(newVal, 'Color','r','LineStyle','--','LineWidth',1.2);

% 2) 文字标签
text(newVal, p_kde*1.15, ...
     sprintf('新值 %.1f', newVal), ...
     'Color','r','HorizontalAlignment','center');

% 标记目标值
plot([r_Ori, r_Ori], [0, max(kde)*1.1], 'k--', 'LineWidth', 1.5);
text(r_Ori, max(kde)*1.05, sprintf('Empirical result: %.2f', r_Ori), ...
    'HorizontalAlignment', 'center', 'Color', 'black');

% 图形美化
xlabel('Correlation value');
ylabel('Probability histogram');
title('数据分布与小概率事件判断');
grid on;
box on;
hold off;


% 计算p值（双侧检验）
count = sum(abs(RandInd_R) >= abs(r_Ori));
p_value = count / 1000;
disp(p_value)


saveas(fig1,fullfile(resultsSave,NameFile))
close(fig1)

end