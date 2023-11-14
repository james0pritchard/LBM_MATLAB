%% Plotting of Benchamrk 1 with different grid sizes
%% Read variables from file
x_1024 = readmatrix("1b_x1024.txt");
y_1024 = readmatrix("1b_y1024.txt");
ux_1024 = readmatrix("1b_ux1024.txt");
uy_1024 = readmatrix("1b_uy1024.txt");
C_BGK_1024 = readmatrix("1b_c1024.txt");

x_0512 = readmatrix("1b_x512.txt");
y_0512 = readmatrix("1b_y512.txt");
ux_0512 = readmatrix("1b_ux512.txt");
uy_0512 = readmatrix("1b_uy512.txt");
C_BGK_0512 = readmatrix("1b_c512.txt");

x_0256 = readmatrix("1b_x256.txt");
y_0256 = readmatrix("1b_y256.txt");
ux_0256 = readmatrix("1b_ux256.txt");
uy_0256 = readmatrix("1b_uy256.txt");
C_BGK_0256 = readmatrix("1b_c256.txt");

x_0128 = readmatrix("1b_x128.txt");
y_0128 = readmatrix("1b_y128.txt");
ux_0128 = readmatrix("1b_ux128.txt");
uy_0128 = readmatrix("1b_uy128.txt");
C_BGK_0128 = readmatrix("1b_c128.txt");

x_0064 = readmatrix("1b_x64.txt");
y_0064 = readmatrix("1b_y64.txt");
ux_0064 = readmatrix("1b_ux64.txt");
uy_0064 = readmatrix("1b_uy64.txt");
C_BGK_0064 = readmatrix("1b_c64.txt");


%% Grid Independant Variables
C_0 = 1;
D = 0.0043;
omega_0sqr = 10^2;
x_0_all = [400 200 100 50 25];
y_0_all = [400 200 100 50 25];
t_all = [400 200 100 50 25];%[100 200 400 800 1600]; %[50 200 800 2400 9600]


%% Grid size 1024
% Set variables for analytical solution
x_0_1024 = x_0_all(1);
y_0_1024 = y_0_all(1);
t_1024 = t_all(1);
omega_Dsqr_1024 = 2*D*t_1024;

% Find analytical solution for C
omega_term_1024 = omega_0sqr / (omega_0sqr + omega_Dsqr_1024);
xsqr_1024 = (x_1024 - x_0_1024 - ux_1024 * t_1024).^2;
ysqr_1024 = transpose((y_1024 - y_0_1024 - uy_1024 * t_1024).^2);
C_exact_1024 = omega_term_1024 * C_0 * exp( - (xsqr_1024 + ysqr_1024) / ...
    (2 * (omega_0sqr+omega_Dsqr_1024)));


%% Grid size 512
% Set variables for analytical solution
x_0_0512 = x_0_all(2);
y_0_0512 = y_0_all(2);
t_0512 = t_all(2);
omega_Dsqr_0512 = 2*D*t_0512;

% Find analytical solution for C
omega_term_0512 = omega_0sqr / (omega_0sqr + omega_Dsqr_0512);
xsqr_0512 = (x_0512 - x_0_0512 - ux_0512 * t_0512).^2;
ysqr_0512 = transpose((y_0512 - y_0_0512 - uy_0512 * t_0512).^2);
C_exact_0512 = omega_term_0512 * C_0 * exp( - (xsqr_0512 + ysqr_0512) / ...
    (2 * (omega_0sqr+omega_Dsqr_0512)));


%% Grid size 256
% Set variables for analytical solution
x_0_0256 = x_0_all(3);
y_0_0256 = y_0_all(3);
t_0256 = t_all(3);
omega_Dsqr_0256 = 2*D*t_0256;

% Find analytical solution for C
omega_term_0256 = omega_0sqr / (omega_0sqr + omega_Dsqr_0256);
xsqr_0256 = (x_0256 - x_0_0256 - ux_0256 * t_0256).^2;
ysqr_0256 = transpose((y_0256 - y_0_0256 - uy_0256 * t_0256).^2);
C_exact_0256 = omega_term_0256 * C_0 * exp( - (xsqr_0256 + ysqr_0256) / ...
    (2 * (omega_0sqr+omega_Dsqr_0256)));


%% Grid size 128
% Set variables for analytical solution
x_0_0128 = x_0_all(4);
y_0_0128 = y_0_all(4);
t_0128 = t_all(4);
omega_Dsqr_0128 = 2*D*t_0128;

% Find analytical solution for C
omega_term_0128 = omega_0sqr / (omega_0sqr + omega_Dsqr_0128);
xsqr_0128 = (x_0128 - x_0_0128 - ux_0128 * t_0128).^2;
ysqr_0128 = transpose((y_0128 - y_0_0128 - uy_0128 * t_0128).^2);
C_exact_0128 = omega_term_0128 * C_0 * exp( - (xsqr_0128 + ysqr_0128) / ...
    (2 * (omega_0sqr+omega_Dsqr_0128)));


%% Grid size 64
% Set variables for analytical solution
x_0_0064 = x_0_all(5);
y_0_0064 = y_0_all(5);
t_0064 = t_all(5);
omega_Dsqr_0064 = 2*D*t_0064;

% Find analytical solution for C
omega_term_0064 = omega_0sqr / (omega_0sqr + omega_Dsqr_0064);
xsqr_0064 = (x_0064 - x_0_0064 - ux_0064 * t_0064).^2;
ysqr_0064 = transpose((y_0064 - y_0_0064 - uy_0064 * t_0064).^2);
C_exact_0064 = omega_term_0064 * C_0 * exp( - (xsqr_0064 + ysqr_0064) / ...
    (2 * (omega_0sqr+omega_Dsqr_0064)));


%% Plotting
% Parameters to pre set
xpos_all = [440 220 110 55 27];  %[410 220 140 110 27]; %
xlims = [[360 180  90 45 23]     %[[370 180 100  80 23]    %
         [540 260 130 65 33]];   % [450 260 180 140 33]];  % 

% Grid size 1024
figure;
axes('FontSize',16, 'NextPlot', 'add');
plot(x_1024, C_exact_1024(xpos_all(1),:), 'k', ...
     x_1024,C_BGK_1024(xpos_all(1),:), 'k--')
title("Concentration profile Grid 1024", FontSize=20)
xlabel('${x}$','interpreter','latex', fontsize=26) 
ylabel('${C}$','interpreter','latex', fontsize=26)
xlim([xlims(1,1) xlims(2,1)])
legend('Analytical', 'BGK', fontsize = 18)

% Grid size 512
figure;
axes('FontSize',16, 'NextPlot', 'add');
plot(x_0512, C_exact_0512(xpos_all(2),:), 'k', ...
     x_0512,C_BGK_0512(xpos_all(2),:), 'k--')
title("Concentration profile Grid 512", FontSize=20)
xlabel('${x}$','interpreter','latex', fontsize=26) 
ylabel('${C}$','interpreter','latex', fontsize=26)
xlim([xlims(1,2) xlims(2,2)])
legend('Analytical', 'BGK', fontsize = 18)

% Grid size 256
figure;
axes('FontSize',16, 'NextPlot', 'add');
plot(x_0256, C_exact_0256(xpos_all(3),:), 'k', ...
     x_0256,C_BGK_0256(xpos_all(3),:), 'k--')
title("Concentration profile Grid 256", FontSize=20)
xlabel('${x}$','interpreter','latex', fontsize=26) 
ylabel('${C}$','interpreter','latex', fontsize=26)
xlim([xlims(1,3) xlims(2,3)])
legend('Analytical', 'BGK', fontsize = 18)

% Grid size 128
figure;
axes('FontSize',16, 'NextPlot', 'add');
plot(x_0128, C_exact_0128(xpos_all(4),:), 'k', ...
     x_0128,C_BGK_0128(xpos_all(4),:), 'k--')
title("Concentration profile Grid 128", FontSize=20)
xlabel('${x}$','interpreter','latex', fontsize=26) 
ylabel('${C}$','interpreter','latex', fontsize=26)
xlim([xlims(1,4) xlims(2,4)])
legend('Analytical', 'BGK', fontsize = 18)

% Grid size 64
figure;
axes('FontSize',16, 'NextPlot', 'add');
plot(x_0064, C_exact_0064(xpos_all(5),:), 'k', ...
     x_0064,C_BGK_0064(xpos_all(5),:), 'k--')
title("Concentration profile Grid 64", FontSize=20)
xlabel('${x}$','interpreter','latex', fontsize=26) 
ylabel('${C}$','interpreter','latex', fontsize=26)
xlim([xlims(1,5) xlims(2,5)])
legend('Analytical', 'BGK', fontsize = 18)
