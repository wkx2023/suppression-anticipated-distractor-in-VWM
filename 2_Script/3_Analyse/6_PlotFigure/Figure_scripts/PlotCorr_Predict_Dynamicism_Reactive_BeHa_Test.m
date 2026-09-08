function PlotCorr_Predict_Dynamicism_Reactive_BeHa_Test(Predict_Dy_task_All,Predict_task_All,Dynamic_task_All,Cluster_BeHa, color_Point,resultsSave)


%% PreDy_PostDy
[r, pValue] = corr(Predict_Dy_task_All, Dynamic_task_All);
disp(['相关系数: ', num2str(r)]);
disp(['p 值: ', num2str(pValue)]);

fig1 = figure;
scatter(Predict_Dy_task_All, Dynamic_task_All, 'MarkerFaceColor',color_Point,'MarkerEdgeColor',color_Point,...
    'MarkerFaceAlpha',.3,'MarkerEdgeAlpha',0);
hold on;
xlabel('Pre Dynamicism Index');
ylabel('post Dynamicism Index');


p = polyfit(Predict_Dy_task_All, Dynamic_task_All, 1); % 1表示线性拟合
x_fit = linspace(min(Predict_Dy_task_All), max(Predict_Dy_task_All), 100); % 生成更密集的 x 值用于绘制曲线
y_fit = polyval(p, x_fit); 

plot(x_fit, y_fit, 'k-', 'LineWidth', 3); 


ax = gca;
ax.Box = 'off';  
ax.YAxisLocation = 'left'; 
ax.XAxisLocation = 'bottom';

if pValue<0.001
    annotation('textbox', [0.15, 0.85, 0.2, 0.1], ...
        'String', {['R = ', num2str(r, '%.4f')], ['P < 0.001']}, ...
        'BackgroundColor', 'white', ...
        'EdgeColor', 'none', ...
        'FontSize', 10);
else
    annotation('textbox', [0.15, 0.85, 0.2, 0.1], ...
        'String', {['R = ', num2str(r, '%.4f')], ['P = ', num2str(pValue, '%.4e')]}, ...
        'BackgroundColor', 'white', ...
        'EdgeColor', 'none', ...
        'FontSize', 10);
end

% saveas(fig1,fullfile(resultsSave,['PreDy_PostDy','.svg']))
% close(fig1)




%% PrePredict_PreDy
[r, pValue] = corr(Predict_task_All,Predict_Dy_task_All );
disp(['相关系数: ', num2str(r)]);
disp(['p 值: ', num2str(pValue)]);

fig1 = figure;
color_Point = [181,181,181]/255;
scatter(Predict_task_All,Predict_Dy_task_All, 'MarkerFaceColor',color_Point,'MarkerEdgeColor',color_Point,...
    'MarkerFaceAlpha',.3,'MarkerEdgeAlpha',0);
hold on; 
xlabel('Pre AUC');
ylabel('pre Dynamicism Index');


p = polyfit(Predict_task_All,Predict_Dy_task_All, 1); 
x_fit = linspace(min(Predict_task_All), max(Predict_task_All), 100);
y_fit = polyval(p, x_fit); 
plot(x_fit, y_fit, 'k-', 'LineWidth', 3); 


ax = gca;
ax.Box = 'off';  
ax.YAxisLocation = 'left';  
ax.XAxisLocation = 'bottom';


if pValue<0.001
    annotation('textbox', [0.15, 0.85, 0.2, 0.1], ...
        'String', {['R = ', num2str(r, '%.4f')], ['P < 0.001']}, ...
        'BackgroundColor', 'white', ...
        'EdgeColor', 'none', ...
        'FontSize', 10);
else
    annotation('textbox', [0.15, 0.85, 0.2, 0.1], ...
        'String', {['R = ', num2str(r, '%.4f')], ['P = ', num2str(pValue, '%.4e')]}, ...
        'BackgroundColor', 'white', ...
        'EdgeColor', 'none', ...
        'FontSize', 10);
end

% saveas(fig1,fullfile(resultsSave,['PrePredict_PreDy','.svg']))
% close(fig1)

r_Ori = r;

for RandInd = 1:1000


    shuffled_Predict = randperm(length(Predict_task_All));
    Predict_task_All_Rand = Predict_task_All(shuffled_Predict);

    [r, pValue] = corr(Predict_task_All_Rand, Predict_Dy_task_All);

    RandInd_R(RandInd) = r;
    RandInd_P(RandInd) = pValue;

end

[counts, bins] = histcounts(RandInd_R);
binWidth = bins(2)-bins(1);
bin_centers = (bins(1:end-1) + bins(2:end)) / 2;
hold on;


x_min = min([RandInd_R, r_Ori]) - 0.1;
x_max = max([RandInd_R, r_Ori]) + 0.1; 
x_kde = linspace(x_min, x_max, 1000);


[kde, ~] = ksdensity(RandInd_R, x_kde);
alpha = 0.05;
ci = prctile(RandInd_R, [100*alpha/2, 100*(1-alpha/2)]);
ci_low = ci(1);
ci_high = ci(2); 

cdf_target = ksdensity(RandInd_R, r_Ori, 'Function', 'cdf');
probability = min(cdf_target, 1 - cdf_target); 

fig1 = figure;
set(gcf, 'Position', [100, 100, 1000, 600]); 
hold on; grid off; box off;
plot(x_kde, kde, 'LineWidth', 2, 'Color', 'red');
idx_ci = x_kde >= ci_low & x_kde <= ci_high;
area(x_kde(idx_ci), kde(idx_ci), 'FaceColor', [0.9, 0.9, 0.9], ...
    'EdgeColor', 'none', 'FaceAlpha', 0.5);

idx_low = x_kde <= ci_low;
area(x_kde(idx_low), kde(idx_low), 'FaceColor', [1, 0.8, 0.8], ...
    'EdgeColor', 'none', 'FaceAlpha', 0.7);

idx_high = x_kde >= ci_high;
area(x_kde(idx_high), kde(idx_high), 'FaceColor', [1, 0.8, 0.8], ...
    'EdgeColor', 'none', 'FaceAlpha', 0.7);

plot(r_Ori, 0, 'ko', 'MarkerSize', 10, 'MarkerFaceColor', 'yellow');
text(r_Ori, max(kde)*1.05, sprintf('目标值: %.1f\n概率: %.4f', ...
    r_Ori, probability), 'HorizontalAlignment', 'center');


plot([ci_low, ci_low], [0, interp1(x_kde, kde, ci_low)], 'g--', 'LineWidth', 1.5);
plot([ci_high, ci_high], [0, interp1(x_kde, kde, ci_high)], 'g--', 'LineWidth', 1.5);
text(ci_low, interp1(x_kde, kde, ci_low)*1.05, '2.5%', 'Color', 'green');
text(ci_high, interp1(x_kde, kde, ci_high)*1.05, '97.5%', 'Color', 'green');


xlabel('Correlation value', 'FontSize', 12);
ylabel('Probability density', 'FontSize', 12);
title('Random data distribution', 'FontSize', 14);
xlim([x_min, x_max]);
ylim([0, max(kde)*1.2]);

ax = gca;
ax.XAxisLocation = 'bottom'; 

hold off;
box off;

fprintf('目标值 %.1f 的统计分析:\n', r_Ori);
fprintf('95%%置信区间: [%.4f, %.4f]\n', ci_low, ci_high);
fprintf('目标值位于小概率区域内，双侧概率: %.4f (%.2f%%)\n', ...
    probability, probability*100);



%% RrePredict_PostDynamic
[r, pValue] = corr(Predict_task_All, Dynamic_task_All);
disp(['相关系数: ', num2str(r)]);
disp(['p 值: ', num2str(pValue)]);

fig1 = figure;
color_Point = [181,181,181]/255;
scatter(Predict_task_All, Dynamic_task_All, 'MarkerFaceColor',color_Point,'MarkerEdgeColor',color_Point,...
    'MarkerFaceAlpha',.3,'MarkerEdgeAlpha',0);
hold on;
xlabel('Pre AUC');
ylabel('post Dynamicism Index');

p = polyfit(Predict_task_All, Dynamic_task_All, 1); 
x_fit = linspace(min(Predict_task_All), max(Predict_task_All), 100); 
y_fit = polyval(p, x_fit);
plot(x_fit, y_fit, 'k-', 'LineWidth', 3); 


ax = gca;
ax.Box = 'off'; 
ax.YAxisLocation = 'left';  
ax.XAxisLocation = 'bottom';


if pValue<0.001
    annotation('textbox', [0.15, 0.85, 0.2, 0.1], ...
        'String', {['R = ', num2str(r, '%.4f')], ['P < 0.001']}, ...
        'BackgroundColor', 'white', ...
        'EdgeColor', 'none', ...
        'FontSize', 10);
else
    annotation('textbox', [0.15, 0.85, 0.2, 0.1], ...
        'String', {['R = ', num2str(r, '%.4f')], ['P = ', num2str(pValue, '%.4e')]}, ...
        'BackgroundColor', 'white', ...
        'EdgeColor', 'none', ...
        'FontSize', 10);
end

% saveas(fig1,fullfile(resultsSave,['RrePredict_PostDynamic','.svg']))
% close(fig1)

r_Ori = r;

for RandInd = 1:1000


    shuffled_Predict = randperm(length(Predict_task_All));
    Predict_task_All_Rand = Predict_task_All(shuffled_Predict);

    [r, pValue] = corr(Predict_task_All_Rand, Dynamic_task_All);

    RandInd_R(RandInd) = r;
    RandInd_P(RandInd) = pValue;

end

[counts, bins] = histcounts(RandInd_R);
binWidth = bins(2)-bins(1);
bin_centers = (bins(1:end-1) + bins(2:end)) / 2;
hold on;


x_min = min([RandInd_R, r_Ori]) - 0.1;
x_max = max([RandInd_R, r_Ori]) + 0.1; 
x_kde = linspace(x_min, x_max, 1000);


[kde, ~] = ksdensity(RandInd_R, x_kde);
alpha = 0.05;
ci = prctile(RandInd_R, [100*alpha/2, 100*(1-alpha/2)]);
ci_low = ci(1);
ci_high = ci(2); 

cdf_target = ksdensity(RandInd_R, r_Ori, 'Function', 'cdf');
probability = min(cdf_target, 1 - cdf_target); 

fig1 = figure;
set(gcf, 'Position', [100, 100, 1000, 600]); 
hold on; grid off; box off;
plot(x_kde, kde, 'LineWidth', 2, 'Color', 'red');
idx_ci = x_kde >= ci_low & x_kde <= ci_high;
area(x_kde(idx_ci), kde(idx_ci), 'FaceColor', [0.9, 0.9, 0.9], ...
    'EdgeColor', 'none', 'FaceAlpha', 0.5);

idx_low = x_kde <= ci_low;
area(x_kde(idx_low), kde(idx_low), 'FaceColor', [1, 0.8, 0.8], ...
    'EdgeColor', 'none', 'FaceAlpha', 0.7);

idx_high = x_kde >= ci_high;
area(x_kde(idx_high), kde(idx_high), 'FaceColor', [1, 0.8, 0.8], ...
    'EdgeColor', 'none', 'FaceAlpha', 0.7);

plot(r_Ori, 0, 'ko', 'MarkerSize', 10, 'MarkerFaceColor', 'yellow');
text(r_Ori, max(kde)*1.05, sprintf('目标值: %.1f\n概率: %.4f', ...
    r_Ori, probability), 'HorizontalAlignment', 'center');


plot([ci_low, ci_low], [0, interp1(x_kde, kde, ci_low)], 'g--', 'LineWidth', 1.5);
plot([ci_high, ci_high], [0, interp1(x_kde, kde, ci_high)], 'g--', 'LineWidth', 1.5);
text(ci_low, interp1(x_kde, kde, ci_low)*1.05, '2.5%', 'Color', 'green');
text(ci_high, interp1(x_kde, kde, ci_high)*1.05, '97.5%', 'Color', 'green');


xlabel('Correlation value', 'FontSize', 12);
ylabel('Probability density', 'FontSize', 12);
title('Random data distribution', 'FontSize', 14);
xlim([x_min, x_max]);
ylim([0, max(kde)*1.2]);

ax = gca;
ax.XAxisLocation = 'bottom'; 

hold off;
box off;

fprintf('目标值 %.1f 的统计分析:\n', r_Ori);
fprintf('95%%置信区间: [%.4f, %.4f]\n', ci_low, ci_high);
fprintf('目标值位于小概率区域内，双侧概率: %.4f (%.2f%%)\n', ...
    probability, probability*100);



%% 偏相关
data = [Predict_Dy_task_All Dynamic_task_All Predict_task_All];
[r, p] = partialcorr(data);
fprintf('偏相关系数 r = %.3f\n', r);
fprintf('显著性 p值 = %.3f\n', p);



%% PreDy_Beha
[r, pValue] = corr(Predict_Dy_task_All, Cluster_BeHa);
disp(['相关系数: ', num2str(r)]);
disp(['p 值: ', num2str(pValue)]);

fig1 = figure;
scatter(Predict_Dy_task_All, Cluster_BeHa, 'MarkerFaceColor',color_Point,'MarkerEdgeColor',color_Point,...
    'MarkerFaceAlpha',.3,'MarkerEdgeAlpha',0);
hold on;
xlabel('Pre Dynamicism Index');
ylabel('Behavioral');


p = polyfit(Predict_Dy_task_All, Cluster_BeHa, 1); 
x_fit = linspace(min(Predict_Dy_task_All), max(Predict_Dy_task_All), 100); 
y_fit = polyval(p, x_fit);
plot(x_fit, y_fit, 'k-', 'LineWidth', 3); 


ax = gca;
ax.Box = 'off';  
ax.YAxisLocation = 'left';  
ax.XAxisLocation = 'bottom';


if pValue<0.001
    annotation('textbox', [0.15, 0.85, 0.2, 0.1], ...
        'String', {['R = ', num2str(r, '%.4f')], ['P < 0.001']}, ...
        'BackgroundColor', 'white', ...
        'EdgeColor', 'none', ...
        'FontSize', 10);
else
    annotation('textbox', [0.15, 0.85, 0.2, 0.1], ...
        'String', {['R = ', num2str(r, '%.4f')], ['P = ', num2str(pValue, '%.4e')]}, ...
        'BackgroundColor', 'white', ...
        'EdgeColor', 'none', ...
        'FontSize', 10);
end

% saveas(fig1,fullfile(resultsSave,['PreDy_Beha','.svg']))
% close(fig1)



%% PostDynamic_Beha
[r, pValue] = corr(Dynamic_task_All, Cluster_BeHa);
disp(['相关系数: ', num2str(r)]);
disp(['p 值: ', num2str(pValue)]);

fig1 = figure;
scatter(Dynamic_task_All, Cluster_BeHa, 'MarkerFaceColor',color_Point,'MarkerEdgeColor',color_Point,...
    'MarkerFaceAlpha',.3,'MarkerEdgeAlpha',0);
hold on; 
xlabel('Dynamicism Index');
ylabel('Behavioral');

p = polyfit(Dynamic_task_All, Cluster_BeHa, 1); 
x_fit = linspace(min(Dynamic_task_All), max(Dynamic_task_All), 100); 
y_fit = polyval(p, x_fit); 
plot(x_fit, y_fit, 'k-', 'LineWidth', 3);


ax = gca;
ax.Box = 'off';
ax.YAxisLocation = 'left'; 
ax.XAxisLocation = 'bottom';


if pValue<0.001
    annotation('textbox', [0.15, 0.85, 0.2, 0.1], ...
        'String', {['R = ', num2str(r, '%.4f')], ['P < 0.001']}, ...
        'BackgroundColor', 'white', ...
        'EdgeColor', 'none', ...
        'FontSize', 10);
else
    annotation('textbox', [0.15, 0.85, 0.2, 0.1], ...
        'String', {['R = ', num2str(r, '%.4f')], ['P = ', num2str(pValue, '%.4e')]}, ...
        'BackgroundColor', 'white', ...
        'EdgeColor', 'none', ...
        'FontSize', 10);
end

% saveas(fig1,fullfile(resultsSave,['PostDynamic_Beha','.svg']))
% close(fig1)

r_Ori = r;

for RandInd = 1:1000


    shuffled_Predict = randperm(length(Dynamic_task_All));
    Dynamic_task_All_Rand = Dynamic_task_All(shuffled_Predict);

    [r, pValue] = corr(Dynamic_task_All_Rand, Cluster_BeHa);

    RandInd_R(RandInd) = r;
    RandInd_P(RandInd) = pValue;

end

[counts, bins] = histcounts(RandInd_R);
binWidth = bins(2)-bins(1);
bin_centers = (bins(1:end-1) + bins(2:end)) / 2;
hold on;


x_min = min([RandInd_R, r_Ori]) - 0.1;
x_max = max([RandInd_R, r_Ori]) + 0.1; 
x_kde = linspace(x_min, x_max, 1000);


[kde, ~] = ksdensity(RandInd_R, x_kde);
alpha = 0.05;
ci = prctile(RandInd_R, [100*alpha/2, 100*(1-alpha/2)]);
ci_low = ci(1);
ci_high = ci(2); 

cdf_target = ksdensity(RandInd_R, r_Ori, 'Function', 'cdf');
probability = min(cdf_target, 1 - cdf_target); 

fig1 = figure;
set(gcf, 'Position', [100, 100, 1000, 600]); 
hold on; grid off; box off;
plot(x_kde, kde, 'LineWidth', 2, 'Color', 'red');
idx_ci = x_kde >= ci_low & x_kde <= ci_high;
area(x_kde(idx_ci), kde(idx_ci), 'FaceColor', [0.9, 0.9, 0.9], ...
    'EdgeColor', 'none', 'FaceAlpha', 0.5);

idx_low = x_kde <= ci_low;
area(x_kde(idx_low), kde(idx_low), 'FaceColor', [1, 0.8, 0.8], ...
    'EdgeColor', 'none', 'FaceAlpha', 0.7);

idx_high = x_kde >= ci_high;
area(x_kde(idx_high), kde(idx_high), 'FaceColor', [1, 0.8, 0.8], ...
    'EdgeColor', 'none', 'FaceAlpha', 0.7);

plot(r_Ori, 0, 'ko', 'MarkerSize', 10, 'MarkerFaceColor', 'yellow');
text(r_Ori, max(kde)*1.05, sprintf('目标值: %.1f\n概率: %.4f', ...
    r_Ori, probability), 'HorizontalAlignment', 'center');


plot([ci_low, ci_low], [0, interp1(x_kde, kde, ci_low)], 'g--', 'LineWidth', 1.5);
plot([ci_high, ci_high], [0, interp1(x_kde, kde, ci_high)], 'g--', 'LineWidth', 1.5);
text(ci_low, interp1(x_kde, kde, ci_low)*1.05, '2.5%', 'Color', 'green');
text(ci_high, interp1(x_kde, kde, ci_high)*1.05, '97.5%', 'Color', 'green');


xlabel('Correlation value', 'FontSize', 12);
ylabel('Probability density', 'FontSize', 12);
title('Random data distribution', 'FontSize', 14);
xlim([x_min, x_max]);
ylim([0, max(kde)*1.2]);

ax = gca;
ax.XAxisLocation = 'bottom'; 

hold off;
box off;

fprintf('目标值 %.1f 的统计分析:\n', r_Ori);
fprintf('95%%置信区间: [%.4f, %.4f]\n', ci_low, ci_high);
fprintf('目标值位于小概率区域内，双侧概率: %.4f (%.2f%%)\n', ...
    probability, probability*100);







%% PrePredict_Beha
[r, pValue] = corr(Predict_task_All, Cluster_BeHa);
disp(['相关系数: ', num2str(r)]);
disp(['p 值: ', num2str(pValue)]);

fig1 = figure;
scatter(Predict_task_All, Cluster_BeHa, 'MarkerFaceColor',color_Point,'MarkerEdgeColor',color_Point,...
    'MarkerFaceAlpha',.3,'MarkerEdgeAlpha',0);
hold on; 
xlabel('Pre AUC');
ylabel('Behavioral');


p = polyfit(Predict_task_All, Cluster_BeHa, 1); 
x_fit = linspace(min(Predict_task_All), max(Predict_task_All), 100); 
y_fit = polyval(p, x_fit); 
plot(x_fit, y_fit, 'k-', 'LineWidth', 3); 


ax = gca;
ax.Box = 'off';  
ax.YAxisLocation = 'left';  
ax.XAxisLocation = 'bottom';


if pValue<0.001
    annotation('textbox', [0.15, 0.85, 0.2, 0.1], ...
        'String', {['R = ', num2str(r, '%.4f')], ['P < 0.001']}, ...
        'BackgroundColor', 'white', ...
        'EdgeColor', 'none', ...
        'FontSize', 10);
else
    annotation('textbox', [0.15, 0.85, 0.2, 0.1], ...
        'String', {['R = ', num2str(r, '%.4f')], ['P = ', num2str(pValue, '%.4e')]}, ...
        'BackgroundColor', 'white', ...
        'EdgeColor', 'none', ...
        'FontSize', 10);
end

% saveas(fig1,fullfile(resultsSave,['PrePredict_Beha','.svg']))
% close(fig1)

r_Ori = r;

for RandInd = 1:1000


shuffled_Predict = randperm(length(Predict_task_All));
Predict_task_All_Rand = Predict_task_All(shuffled_Predict);

[r, pValue] = corr(Predict_task_All_Rand, Cluster_BeHa);

RandInd_R(RandInd) = r;
RandInd_P(RandInd) = pValue;

end

[counts, bins] = histcounts(RandInd_R);
binWidth = bins(2)-bins(1);
bin_centers = (bins(1:end-1) + bins(2:end)) / 2;
hold on;


x_min = min([RandInd_R, r_Ori]) - 0.1;
x_max = max([RandInd_R, r_Ori]) + 0.1; 
x_kde = linspace(x_min, x_max, 1000);


[kde, ~] = ksdensity(RandInd_R, x_kde);
alpha = 0.05;
ci = prctile(RandInd_R, [100*alpha/2, 100*(1-alpha/2)]);
ci_low = ci(1);
ci_high = ci(2); 

cdf_target = ksdensity(RandInd_R, r_Ori, 'Function', 'cdf');
probability = min(cdf_target, 1 - cdf_target); 

fig1 = figure;
set(gcf, 'Position', [100, 100, 1000, 600]); 
hold on; grid off; box off;
plot(x_kde, kde, 'LineWidth', 2, 'Color', 'red');
idx_ci = x_kde >= ci_low & x_kde <= ci_high;
area(x_kde(idx_ci), kde(idx_ci), 'FaceColor', [0.9, 0.9, 0.9], ...
    'EdgeColor', 'none', 'FaceAlpha', 0.5);

idx_low = x_kde <= ci_low;
area(x_kde(idx_low), kde(idx_low), 'FaceColor', [1, 0.8, 0.8], ...
    'EdgeColor', 'none', 'FaceAlpha', 0.7);

idx_high = x_kde >= ci_high;
area(x_kde(idx_high), kde(idx_high), 'FaceColor', [1, 0.8, 0.8], ...
    'EdgeColor', 'none', 'FaceAlpha', 0.7);

plot(r_Ori, 0, 'ko', 'MarkerSize', 10, 'MarkerFaceColor', 'yellow');
text(r_Ori, max(kde)*1.05, sprintf('目标值: %.1f\n概率: %.4f', ...
    r_Ori, probability), 'HorizontalAlignment', 'center');


plot([ci_low, ci_low], [0, interp1(x_kde, kde, ci_low)], 'g--', 'LineWidth', 1.5);
plot([ci_high, ci_high], [0, interp1(x_kde, kde, ci_high)], 'g--', 'LineWidth', 1.5);
text(ci_low, interp1(x_kde, kde, ci_low)*1.05, '2.5%', 'Color', 'green');
text(ci_high, interp1(x_kde, kde, ci_high)*1.05, '97.5%', 'Color', 'green');


xlabel('Correlation value', 'FontSize', 12);
ylabel('Probability density', 'FontSize', 12);
title('Random data distribution', 'FontSize', 14);
xlim([x_min, x_max]);
ylim([0, max(kde)*1.2]);

ax = gca;
ax.XAxisLocation = 'bottom'; 

hold off;
box off;

fprintf('目标值 %.1f 的统计分析:\n', r_Ori);
fprintf('95%%置信区间: [%.4f, %.4f]\n', ci_low, ci_high);
fprintf('目标值位于小概率区域内，双侧概率: %.4f (%.2f%%)\n', ...
    probability, probability*100);



%% 偏相关
data = [Predict_task_All Dynamic_task_All Cluster_BeHa];
[r, p] = partialcorr(data);
fprintf('偏相关系数 r = %.3f\n', r);
fprintf('显著性 p值 = %.3f\n', p);



