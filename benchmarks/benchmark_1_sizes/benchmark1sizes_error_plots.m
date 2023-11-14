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
t_all = [50 200 800 2400 9600];


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

% Finding L_2 error
Error_1024 = norm(C_BGK_1024-C_exact_1024, 'fro')/norm(C_exact_1024, 'fro');


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

% Finding L_2 error
Error_0512 = norm(C_BGK_0512-C_exact_0512, 'fro')/norm(C_exact_0512, 'fro');


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

% Finding L_2 error
Error_0256 = norm(C_BGK_0256-C_exact_0256, 'fro')/norm(C_exact_0256, 'fro');


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

% Finding L_2 error
Error_0128 = norm(C_BGK_0128-C_exact_0128, 'fro')/norm(C_exact_0128, 'fro');


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

% Finding L_2 error
Error_0064 = norm(C_BGK_0064-C_exact_0064, 'fro')/norm(C_exact_0064, 'fro');


%% Plotting
x = 1:1024;
figure;
loglog([64 128 256 512 1024], [Error_0064 Error_0128 Error_0256 Error_0512 Error_1024], ...
    'ko', x,x.^-1, 'k', x,x.^-2, 'k--')
xlabel('Side Length of Square Domain (l.u.)','interpreter','latex', fontsize=26) 
ylabel('${L_2}$ error in ${C}$','interpreter','latex', fontsize=26)
xlim([50 2000])
ylim([10e-7 10e-2])







