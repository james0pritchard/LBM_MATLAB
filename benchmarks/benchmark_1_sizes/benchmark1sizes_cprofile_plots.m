%% Plotting of Benchamrk 1 with different grid sizes
%% Read variables from file
x_512 = readmatrix("1b_x512.txt");
y_512 = readmatrix("1b_y512.txt");
ux_512 = readmatrix("1b_ux512.txt");
uy_512 = readmatrix("1b_uy512.txt");
C_BGK_512 = readmatrix("1b_c512.txt");

x_256 = readmatrix("1b_x256.txt");
y_256 = readmatrix("1b_y256.txt");
ux_256 = readmatrix("1b_ux256.txt");
uy_256 = readmatrix("1b_uy256.txt");
C_BGK_256 = readmatrix("1b_c256.txt");

x_128 = readmatrix("1b_x128.txt");
y_128 = readmatrix("1b_y128.txt");
ux_128 = readmatrix("1b_ux128.txt");
uy_128 = readmatrix("1b_uy128.txt");
C_BGK_128 = readmatrix("1b_c128.txt");

x_064 = readmatrix("1b_x064.txt");
y_064 = readmatrix("1b_y064.txt");
ux_064 = readmatrix("1b_ux064.txt");
uy_064 = readmatrix("1b_uy064.txt");
C_BGK_064 = readmatrix("1b_c064.txt");

x_032 = readmatrix("1b_x032.txt");
y_032 = readmatrix("1b_y032.txt");
ux_032 = readmatrix("1b_ux032.txt");
uy_032 = readmatrix("1b_uy032.txt");
C_BGK_032 = readmatrix("1b_c032.txt");


%% Grid Independant Variables
C_0 = 1;
D = 0.0043;
omega_0sqr = 10^2;
x_0_all = [256 128 64 32 16];
y_0_all = [256 128 64 32 16];
t_all = [768 192 48 12 3];
nx_all = [512 256 128 64 32];


%% Grid size 512
% Set variables for analytical solution
x_0_512 = x_0_all(1);
y_0_512 = y_0_all(1);
t_512 = t_all(1);
omega_Dsqr_512 = 2*D*t_512;
omega_0sqr_512 = omega_0sqr * (nx_all(1)/nx_all(1))^2;

% Find analytical solution for C
omega_term_512 = omega_0sqr_512 / (omega_0sqr_512 + omega_Dsqr_512);
xsqr_512 = (x_512 - x_0_512 - ux_512 * t_512).^2;
ysqr_512 = transpose((y_512 - y_0_512 - uy_512 * t_512).^2);
C_exact_512 = omega_term_512 * C_0 * exp( - (xsqr_512 + ysqr_512) / ...
    (2 * (omega_0sqr_512+omega_Dsqr_512)));


%% Grid size 256
% Set variables for analytical solution
x_0_256 = x_0_all(2);
y_0_256 = y_0_all(2);
t_256 = t_all(2);
omega_Dsqr_256 = 2*D*t_256;
omega_0sqr_256 = omega_0sqr * (nx_all(2)/nx_all(1))^2;

% Find analytical solution for C
omega_term_256 = omega_0sqr_256 / (omega_0sqr_256 + omega_Dsqr_256);
xsqr_256 = (x_256 - x_0_256 - ux_256 * t_256).^2;
ysqr_256 = transpose((y_256 - y_0_256 - uy_256 * t_256).^2);
C_exact_256 = omega_term_256 * C_0 * exp( - (xsqr_256 + ysqr_256) / ...
    (2 * (omega_0sqr_256+omega_Dsqr_256)));


%% Grid size 128
% Set variables for analytical solution
x_0_128 = x_0_all(3);
y_0_128 = y_0_all(3);
t_128 = t_all(3);
omega_Dsqr_128 = 2*D*t_128;
omega_0sqr_128 = omega_0sqr * (nx_all(3)/nx_all(1))^2;

% Find analytical solution for C
omega_term_128 = omega_0sqr_128 / (omega_0sqr_128 + omega_Dsqr_128);
xsqr_128 = (x_128 - x_0_128 - ux_128 * t_128).^2;
ysqr_128 = transpose((y_128 - y_0_128 - uy_128 * t_128).^2);
C_exact_128 = omega_term_128 * C_0 * exp( - (xsqr_128 + ysqr_128) / ...
    (2 * (omega_0sqr_128+omega_Dsqr_128)));


%% Grid size 64
% Set variables for analytical solution
x_0_064 = x_0_all(4);
y_0_064 = y_0_all(4);
t_064 = t_all(4);
omega_Dsqr_064 = 2*D*t_064;
omega_0sqr_064 = omega_0sqr * (nx_all(4)/nx_all(1))^2;

% Find analytical solution for C
omega_term_064 = omega_0sqr_064 / (omega_0sqr_064 + omega_Dsqr_064);
xsqr_064 = (x_064 - x_0_064 - ux_064 * t_064).^2;
ysqr_064 = transpose((y_064 - y_0_064 - uy_064 * t_064).^2);
C_exact_064 = omega_term_064 * C_0 * exp( - (xsqr_064 + ysqr_064) / ...
    (2 * (omega_0sqr_064+omega_Dsqr_064)));


%% Grid size 32
% Set variables for analytical solution
x_0_032 = x_0_all(5);
y_0_032 = y_0_all(5);
t_032 = t_all(5);
omega_Dsqr_032 = 2*D*t_032;
omega_0sqr_032 = omega_0sqr * (nx_all(5)/nx_all(1))^2;

% Find analytical solution for C
omega_term_032 = omega_0sqr_032 / (omega_0sqr_032 + omega_Dsqr_032);
xsqr_032 = (x_032 - x_0_032 - ux_032 * t_032).^2;
ysqr_032 = transpose((y_032 - y_0_032 - uy_032 * t_032).^2);
C_exact_032 = omega_term_032 * C_0 * exp( - (xsqr_032 + ysqr_032) / ...
    (2 * (omega_0sqr_032+omega_Dsqr_032)));


%% Plotting
% Parameters to pre set
xpos_all = [266 133 66 33 17]; 
xlims = [[192 96  48 24 12]
         [352 176 88 44 22]];


% Grid size 512
figure;
axes('FontSize',16, 'NextPlot', 'add');
plot(x_512, C_exact_512(xpos_all(1),:), 'k', ...
     x_512, C_BGK_512(xpos_all(1),:), 'k--')
title("Concentration profile Grid 512", FontSize=20)
xlabel('${x}$','interpreter','latex', fontsize=26) 
ylabel('${C}$','interpreter','latex', fontsize=26)
xlim([xlims(1,1) xlims(2,1)])
legend('Analytical', 'BGK', fontsize = 18)

% Grid size 256
figure;
axes('FontSize',16, 'NextPlot', 'add');
plot(x_256, C_exact_256(xpos_all(2),:), 'k', ...
     x_256, C_BGK_256(xpos_all(2),:), 'k--')
title("Concentration profile Grid 256", FontSize=20)
xlabel('${x}$','interpreter','latex', fontsize=26) 
ylabel('${C}$','interpreter','latex', fontsize=26)
xlim([xlims(1,2) xlims(2,2)])
legend('Analytical', 'BGK', fontsize = 18)

% Grid size 128
figure;
axes('FontSize',16, 'NextPlot', 'add');
plot(x_128, C_exact_128(xpos_all(3),:), 'k', ...
     x_128, C_BGK_128(xpos_all(3),:), 'k--')
title("Concentration profile Grid 128", FontSize=20)
xlabel('${x}$','interpreter','latex', fontsize=26) 
ylabel('${C}$','interpreter','latex', fontsize=26)
xlim([xlims(1,3) xlims(2,3)])
legend('Analytical', 'BGK', fontsize = 18)

% Grid size 64
figure;
axes('FontSize',16, 'NextPlot', 'add');
plot(x_064, C_exact_064(xpos_all(4),:), 'k', ...
     x_064, C_BGK_064(xpos_all(4),:), 'k--')
title("Concentration profile Grid 64", FontSize=20)
xlabel('${x}$','interpreter','latex', fontsize=26) 
ylabel('${C}$','interpreter','latex', fontsize=26)
xlim([xlims(1,4) xlims(2,4)])
legend('Analytical', 'BGK', fontsize = 18)

% Grid size 32
figure;
axes('FontSize',16, 'NextPlot', 'add');
plot(x_032, C_exact_032(xpos_all(5),:), 'k', ...
     x_032, C_BGK_032(xpos_all(5),:), 'k--')
title("Concentration profile Grid 32", FontSize=20)
xlabel('${x}$','interpreter','latex', fontsize=26) 
ylabel('${C}$','interpreter','latex', fontsize=26)
xlim([xlims(1,5) xlims(2,5)])
legend('Analytical', 'BGK', fontsize = 18)




