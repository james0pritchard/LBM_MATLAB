%% Plotting of Benchmark 1a: advection-diffusion of a Gaussian hill
%% Finding analytical solution
% Load vars from simulation 
x = readmatrix("1b_x.txt");
y = readmatrix("1b_y.txt");
ux = readmatrix("1b_ux.txt");
uy = readmatrix("1b_uy.txt");
C_BGK = readmatrix("1b_c.txt");

% Set variables for analytical solution
x_0 = 200;
y_0 = 200;
t = 200;
D = 0.0043;
C_0 = 1;
omega_0sqr = 10^2;
omega_Dsqr = 2*D*t;

% Find analytical solution for C
omega_term = omega_0sqr / (omega_0sqr + omega_Dsqr);
xsqr = (x - x_0 - ux * t).^2;
ysqr = transpose((y - y_0 - uy * t).^2);
C_exact = omega_term * C_0 * exp( - (xsqr + ysqr) / (2 * (omega_0sqr+omega_Dsqr)));

% Error in C
Error = norm(C_BGK - C_exact, 'fro')/norm(C_exact, 'fro');


%% Plotting
% Plotting C against x
figure;
axes('FontSize',16, 'NextPlot', 'add');
plot(x, C_exact(220,:), 'k', x,C_BGK(220,:), 'k--')
% title("Concentration profile 1b", FontSize=20)
xlabel('${x/\Delta x}$','interpreter','latex', fontsize=26) 
ylabel('${C/C_0}$','interpreter','latex', fontsize=26)
xlim([180 260])
leg = legend('Analytical', 'BGK', 'interpreter','latex', fontsize = 18);
leg.ItemTokenSize = [25,25,25];


% Plotting concentration contour plot 
figure;
axes('FontSize',16, 'NextPlot', 'add');
plot(1:2,1:2,'k');
plot(1:2,1:2,'k--');
contour(C_exact, [0.2 0.4 0.6 0.8], 'k', LineWidth=0.7)
[C,h] = contour(C_BGK, [0.2 0.4 0.6 0.8], 'k--', LineWidth=0.7);
clabel(C,h,'FontSize',18, 'LabelSpacing',1000)
% title("Concentration contour plot 1b", FontSize=20)
xlabel('${x/\Delta x}$','interpreter','latex', fontsize=26) 
ylabel('${y/\Delta x}$','interpreter','latex', fontsize=26)
axis equal
xlim([195 245])
ylim([195 245])
leg = legend({'Analytical', 'BGK', '', ''}, 'interpreter','latex', ...
    fontsize = 18);
leg.ItemTokenSize = [25,25,25];





