function PlotCorr_Predict_Dynamicism_Reactive_BeHa(Predict_Dy_task_All,Predict_task_All,Dynamic_task_All,Cluster_BeHa, color_Point,resultsSave)


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

saveas(fig1,fullfile(resultsSave,['PreDy_PostDy','.svg']))
close(fig1)


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

saveas(fig1,fullfile(resultsSave,['PrePredict_PreDy','.svg']))
close(fig1)


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

saveas(fig1,fullfile(resultsSave,['RrePredict_PostDynamic','.svg']))
close(fig1)


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

saveas(fig1,fullfile(resultsSave,['PreDy_Beha','.svg']))
close(fig1)



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

saveas(fig1,fullfile(resultsSave,['PostDynamic_Beha','.svg']))
close(fig1)



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

saveas(fig1,fullfile(resultsSave,['PrePredict_Beha','.svg']))
close(fig1)




%% 偏相关
data = [Predict_task_All Dynamic_task_All Cluster_BeHa];
[r, p] = partialcorr(data);
fprintf('偏相关系数 r = %.3f\n', r);
fprintf('显著性 p值 = %.3f\n', p);



