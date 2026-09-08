function PlotCorr_Predict_Dynamicism_Reactive(Predict_task_All,Predict_reactive_All,Dynamic_task_All, color_Point,resultsSave)


% Predict_Dynamic
[r, pValue] = corr(Predict_task_All, Dynamic_task_All);
disp(['相关系数: ', num2str(r)]);
disp(['p 值: ', num2str(pValue)]);

fig1 = figure;
scatter(Predict_task_All, Dynamic_task_All, 'MarkerFaceColor',color_Point,'MarkerEdgeColor',color_Point,...
    'MarkerFaceAlpha',.3,'MarkerEdgeAlpha',0);
hold on; % 保持当前图形，用于添加拟合曲线
xlabel('Proactive AUC');
ylabel('Dynamicism Index');

%选择拟合方式：线性拟合（1次多项式）
p = polyfit(Predict_task_All, Dynamic_task_All, 1); % 1表示线性拟合

% 生成拟合曲线的 x 和 y 值
x_fit = linspace(min(Predict_task_All), max(Predict_task_All), 100); % 生成更密集的 x 值用于绘制曲线
y_fit = polyval(p, x_fit); % 计算对应的 y 值

% 绘制拟合曲线
plot(x_fit, y_fit, 'k-', 'LineWidth', 3); % 使用红色实线绘制拟合曲线

% 获取当前坐标轴
ax = gca;

% 隐藏左边和顶部的边框
ax.Box = 'off';  % 关闭默认边框
ax.YAxisLocation = 'left';  % 将Y轴移到右边
ax.XAxisLocation = 'bottom'; % 将X轴放在底部
%set(ax, 'YTickLabel', []);   % 移除左边Y轴刻度标签

if pValue<0.001
 
% 在图上标注 R 和 P 值
annotation('textbox', [0.15, 0.85, 0.2, 0.1], ...
    'String', {['R = ', num2str(r, '%.4f')], ['P < 0.001']}, ...
    'BackgroundColor', 'white', ...
    'EdgeColor', 'none', ...
    'FontSize', 10);
else
    % 在图上标注 R 和 P 值
annotation('textbox', [0.15, 0.85, 0.2, 0.1], ...
    'String', {['R = ', num2str(r, '%.4f')], ['P = ', num2str(pValue, '%.4e')]}, ...
    'BackgroundColor', 'white', ...
    'EdgeColor', 'none', ...
    'FontSize', 10);
end

% saveas(fig1,fullfile(resultsSave,['Predict_Dynamic_RT_100_500','.svg']))
% close(fig1)


% Predict_Reactive
[r, pValue] = corr(Predict_task_All, Predict_reactive_All);
disp(['相关系数: ', num2str(r)]);
disp(['p 值: ', num2str(pValue)]);

fig1 = figure;
color_Point = [181,181,181]/255;
scatter(Predict_task_All, Predict_reactive_All, 'MarkerFaceColor',color_Point,'MarkerEdgeColor',color_Point,...
    'MarkerFaceAlpha',.3,'MarkerEdgeAlpha',0);
hold on; % 保持当前图形，用于添加拟合曲线
xlabel('Proactive AUC');
ylabel('Reactive AUC');

%选择拟合方式：线性拟合（1次多项式）
p = polyfit(Predict_task_All, Predict_reactive_All, 1); % 1表示线性拟合

% 生成拟合曲线的 x 和 y 值
x_fit = linspace(min(Predict_task_All), max(Predict_task_All), 100); % 生成更密集的 x 值用于绘制曲线
y_fit = polyval(p, x_fit); % 计算对应的 y 值

% 绘制拟合曲线
plot(x_fit, y_fit, 'k-', 'LineWidth', 3); % 使用红色实线绘制拟合曲线

% 获取当前坐标轴
ax = gca;

% 隐藏左边和顶部的边框
ax.Box = 'off';  % 关闭默认边框
ax.YAxisLocation = 'left';  % 将Y轴移到右边
ax.XAxisLocation = 'bottom'; % 将X轴放在底部
%set(ax, 'YTickLabel', []);   % 移除左边Y轴刻度标签

if pValue<0.001
 
% 在图上标注 R 和 P 值
annotation('textbox', [0.15, 0.85, 0.2, 0.1], ...
    'String', {['R = ', num2str(r, '%.4f')], ['P < 0.001']}, ...
    'BackgroundColor', 'white', ...
    'EdgeColor', 'none', ...
    'FontSize', 10);
else
    % 在图上标注 R 和 P 值
annotation('textbox', [0.15, 0.85, 0.2, 0.1], ...
    'String', {['R = ', num2str(r, '%.4f')], ['P = ', num2str(pValue, '%.4e')]}, ...
    'BackgroundColor', 'white', ...
    'EdgeColor', 'none', ...
    'FontSize', 10);
end

%saveas(fig1,fullfile(resultsSave,['Predict_Reactive_RT_100_500','.svg']))
close(fig1)


% Reactive_Dynamic
[r, pValue] = corr(Predict_reactive_All, Dynamic_task_All);
disp(['相关系数: ', num2str(r)]);
disp(['p 值: ', num2str(pValue)]);

fig1 = figure;
color_Point = [181,181,181]/255;
scatter(Predict_reactive_All, Dynamic_task_All, 'MarkerFaceColor',color_Point,'MarkerEdgeColor',color_Point,...
    'MarkerFaceAlpha',.3,'MarkerEdgeAlpha',0);
hold on; % 保持当前图形，用于添加拟合曲线
xlabel('Reactive AUC');
ylabel('Dynamicism Index');

%选择拟合方式：线性拟合（1次多项式）
p = polyfit(Predict_reactive_All, Dynamic_task_All, 1); % 1表示线性拟合

% 生成拟合曲线的 x 和 y 值
x_fit = linspace(min(Predict_reactive_All), max(Predict_reactive_All), 100); % 生成更密集的 x 值用于绘制曲线
y_fit = polyval(p, x_fit); % 计算对应的 y 值

% 绘制拟合曲线
plot(x_fit, y_fit, 'k-', 'LineWidth', 3); % 使用红色实线绘制拟合曲线

% 获取当前坐标轴
ax = gca;

% 隐藏左边和顶部的边框
ax.Box = 'off';  % 关闭默认边框
ax.YAxisLocation = 'left';  % 将Y轴移到右边
ax.XAxisLocation = 'bottom'; % 将X轴放在底部
%set(ax, 'YTickLabel', []);   % 移除左边Y轴刻度标签

if pValue<0.001
 
% 在图上标注 R 和 P 值
annotation('textbox', [0.15, 0.85, 0.2, 0.1], ...
    'String', {['R = ', num2str(r, '%.4f')], ['P < 0.001']}, ...
    'BackgroundColor', 'white', ...
    'EdgeColor', 'none', ...
    'FontSize', 10);
else
    % 在图上标注 R 和 P 值
annotation('textbox', [0.15, 0.85, 0.2, 0.1], ...
    'String', {['R = ', num2str(r, '%.4f')], ['P = ', num2str(pValue, '%.4e')]}, ...
    'BackgroundColor', 'white', ...
    'EdgeColor', 'none', ...
    'FontSize', 10);
end

%saveas(fig1,fullfile(resultsSave,['Reactive_Dynamic_RT_100_500','.svg']))
close(fig1)



data = [Predict_task_All,Dynamic_task_All,Predict_reactive_All];
[r, p] = partialcorr(data);
% 3. 输出结果
fprintf('偏相关系数 r = %.3f\n', r);
fprintf('显著性 p值 = %.3f\n', p);



%% 控制任务
% Sube = [101:105,107:111,113:116,118:120,122:128,130:135];
% Con_time = [-600:4:996];
% filename = 'G:\Function_Matlab\SVM\OneDay\mat\';
% matName = strcat(filename,'predict_con_Cluster.mat');
% mat = load(matName);
% predict_con = mat.predict_con;
% for subj = 1:length(Sube)
%     predict_con_subj=imgaussfilt(diag(squeeze(predict_con(:,:,subj))),4);
%     predict_con_all(subj,:) = predict_con_subj;
%     predict_con_dat(subj,:) = squeeze(diag(predict_con(:,:,subj)));
% end
% 
% predict_con_dat = mean(mean(predict_con_dat(:,find(Con_time==100):find(Con_time==500)),2),1);

% [r, p] = partialcorr(Predict_task_All,Dynamic_task_All,predict_con_dat-Predict_reactive_All);
% % 3. 输出结果
% fprintf('偏相关系数 r = %.3f\n', r);
% fprintf('显著性 p值 = %.3f\n', p);