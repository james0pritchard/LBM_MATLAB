%% Plotting of Benchmark 3
%% Read C_BGK from file
load /Users/jpritch/Documents/MATLAB/benchmarks/benchmark_3/C
C_BGK = C;


%% Setting Variables
% Scalars
C_p = 1;
D = 0.07407;
u_0 = 0.05;
nx = 1600;
ny = 160;

% Vectors
x = (1:nx);
y = (1:ny);
C_exact = zeros(ny,nx);


%% Finding Analytical Solution for C
for i = 1:ny
    for j = 1:nx
        C_exact(i,j) = C_p * (1-erf(y(i)/sqrt(4*D*x(j)/u_0))) ;
    end
end

% Error in C
Error = norm(C_BGK - C_exact, 'fro')/norm(C_exact, 'fro');


%% Plotting C contours
% Plotting setup
% figure;
% axes('FontSize',11.5, 'NextPlot', 'add');
% plot([0 3],[0 0],'k', LineWidth=1);
% plot([0 3],[1 1],'k:', LineWidth=1);
% plot([0 0],[0 1],'k:', LineWidth=1);
% plot([3 3],[0 1],'k:', LineWidth=1);
% axis equal
% xlim([0 3])
% ylim([0 1])
% box off
% axis off

% Plotting C_exact and C_BGK Concentration contours 
figure;
axes('FontSize',13, 'NextPlot', 'add');
plot(1:2,1:2,'k');
plot(1:2,1:2,'k--');
contour(x/ny,y/ny,C_exact, [0.2 0.4 0.6 0.8], 'k', LineWidth=0.9)
[C,h] = contour(x/ny,y/ny,C_BGK, [0.2 0.4 0.6 0.8], 'k--', LineWidth=0.9);
clabel(C,h,'manual', 'FontSize',14, 'LabelSpacing',502, 'Rotation',0)
xlabel('${x/N_y}$','interpreter','latex', fontsize=22)
ylabel('${y/N_y}$','interpreter','latex', fontsize=22)
xlim([0 10])
ylim([0 1])
leg = legend({'Analytical', 'Numerical', '', ''}, 'interpreter','latex', ...
    fontsize = 16);
leg.ItemTokenSize = [25,25,25];
box on

% Plotting C_BGK
% figure;
% contour(C_BGK)






