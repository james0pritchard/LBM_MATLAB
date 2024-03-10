%% Plotting of Benchamrk 1 with different grid sizes
%% Read C_BGK from file
load /Users/jpritch/Documents/MATLAB/benchmarks/benchmark_heat/T1


%% Setting Variables
% Scalars
nx = 64;
ny = 64;
T_0 = 0.5; % This is average between 0ºC and 20ºC ie 10ºC 
T_c = 0.45; % Set to non-dim and find proper non-dim later
T_h = 0.55;

% Vectors
x = 0:nx-2;
y = 0:ny-2;
% x = 0:nx-1;
% y = 0:ny-1;

% Finding L_2 error (only works for x = 0:nx-1)
Error = norm((T(32,1:nx-1)-T_c)/(T_h-T_c) - (1-x/(ny-2)), 'fro')/norm(x/(ny-1), 'fro');


%% Plotting T
% Initial setup
% figure;
% axes('FontSize',11.5, 'NextPlot', 'add');
% plot([0 1],[0 0],'k', LineWidth=1);
% plot([0 1],[1 1],'k', LineWidth=1);
% plot([0 0],[0 1],'k', LineWidth=1);
% plot([1 1],[0 1],'k', LineWidth=1);
% % xlabel('Periodic T, ${u = 0}$','interpreter','latex', fontsize=19)
% % ylabel('${T=T_h}$, ${u=0}$','interpreter','latex', fontsize=19)
% axis equal
% xlim([0 1])
% ylim([0 1])
% box off

% Temperature contour
figure;
axes('FontSize',11.5, 'NextPlot', 'add');
plot(1:2,1:2,'k--');
% [C,h] = contour(x/(ny-2),y/(ny-2),T(1:ny-1,1:nx-1), 0.45:0.01:0.55, ...
[C,h] = contour(x/(ny-1),y/(ny-1),T(1:ny,1:nx), 0.45:0.01:0.55, ...
                'k--', LineWidth=0.9);
clabel(C,h, 'FontSize',12, 'LabelSpacing',502)
xlabel('${x/N_x}$','interpreter','latex', fontsize=19)
ylabel('${y/N_y}$','interpreter','latex', fontsize=19)
axis equal
xlim([0 1])
ylim([0 1])
leg = legend({'Numerical', ''}, 'interpreter','latex', ...
    fontsize = 14);
leg.ItemTokenSize = [25,25,25];
box on

% x = 0:nx-2;
% y = 0:ny-2;
x = 0:nx-1;
y = 0:ny-1;
% Temperature cross section
% T_plot = (T(32,1:nx-1)-T_c)/(T_h-T_c);
T_plot = (T(32,1:nx)-T_c)/(T_h-T_c);
figure;
axes('FontSize',18, 'NextPlot', 'add');
% plot(x/(ny-2),1-y/(ny-2),'k', ...
     % x/(ny-2),T_plot,'ok', LineWidth=0.9);
plot(x/(ny-1),1-y/(ny-1),'k', ...
     x/(ny-1),T_plot,'ok', LineWidth=0.9);
xlabel('${x/N_x}$','interpreter','latex', fontsize=25)
ylabel('${\frac{T-T_c}{T_h-T_c}}$','interpreter','latex', fontsize=30)
axis equal
xlim([0 1])
% ylim([-7e-4 1])
ylim([-0.06 1])
leg = legend({'Expected', 'Numerical'}, 'interpreter','latex', ...
    fontsize = 18);
leg.ItemTokenSize = [12,12,12];
box on











