%% Lattice Boltzmann method code: advection-diffusion of a Gaussian hill
%% Setting Grid Independant Variables
% Simulation parameters - input
niter_all = [768 192 48 12 3];
nx_all = [512 256 128 64 32];
ny_all = [512 256 128 64 32];
tau = 0.513;

% D2Q9 velocity set parameters
ndir = 9;
cssq = 1/3;
cx = [0, 1, -1, 0, 0, 1, -1, -1, 1];
cy = [0, 0, 0, 1, -1, 1, 1, -1, -1];
w = [4/9, 1/9, 1/9, 1/9, 1/9, 1/36, 1/36, 1/36, 1/36];

% Simulation parameters - built
cssqinv = 1/cssq;
omega = 1/tau;
omomega = 1 - omega;

% Initialisation of the concentration and velocity field at time t = 0
omega_0 = 10;
C_0 = 1;
x_0_all = [256 128 64 32 16];
y_0_all = [256 128 64 32 16];
ux_all = [0.0125 0.025 0.05 0.1 0.2]; 
uy_all = [0.0125 0.025 0.05 0.1 0.2];


%% Grid size 512
% Simulation parameters - input
niter = niter_all(1);                                                               
nx = nx_all(1);
ny = nx_all(1);
omega_0_512 = omega_0 * nx_all(1)/nx_all(1);

% Initialisation of the concentration field at time t = 0
x = 1:nx;
y = 1:ny;
x_0 = zeros(nx, ny) + x_0_all(1);
y_0 = zeros(nx, ny) + x_0_all(1);

squaredterm = (x - x_0 + zeros(nx, ny)).^2 + transpose((y - y_0 + zeros(nx, ny)).^2);
C = C_0 * exp( - squaredterm / (2 * omega_0_512^2));

% Initialisation of the velocity field at time t = 0
ux = zeros(nx, ny) + ux_all(1);
uy = zeros(nx, ny) + ux_all(1);

% Initialisation of the particle distribution function
geq = zeros(nx, ny, ndir);
for k = 1:ndir
    cdotu = cx(k)*ux + cy(k)*uy;
    udotu = ux.^2 + uy.^2;
    geq(:, :, k) = w(k)*C.*(1 + cssqinv*cdotu + 0.5*cssqinv^2*cdotu.^2 - 0.5*cssqinv*udotu);
end
g = geq;
gcol = zeros(nx, ny, ndir);

% Simulation loop
fprintf('Starting simulation 512\n');
tic
for t = 1:niter
    % Collision
    gcol = omomega*g + omega*geq;

    % Streaming - Explicit version
    % This streaming implementation automatically applies periodic boundary
    % conditions in all edges of the computational domain.
    for k = 1:ndir
        for j = 1:ny
            for i = 1:nx
                xstreamed = mod(i + cx(k), nx);
                if xstreamed == 0
                    xstreamed = nx;
                end
                ystreamed = mod(j + cy(k), ny);
                if ystreamed == 0
                    ystreamed = ny;
                end
                g(xstreamed, ystreamed, k) = gcol(i, j, k);
            end
        end
    end

    % Boundary conditions
    

    % Macroscopic variables
    C = g(:, :, 1) + g(:, :, 2) + g(:, :, 3) + g(:, :, 4) + g(:, :, 5)...
        + g(:, :, 6) + g(:, :, 7) + g(:, :, 8) + g(:, :, 9);

    % Equilibrium distribution function
    for k = 1:ndir
        cdotu = cx(k)*ux + cy(k)*uy;
        udotu = ux.^2 + uy.^2;
        geq(:, :, k) = w(k)*C.*(1 + cssqinv*cdotu + 0.5*cssqinv^2*cdotu.^2 - 0.5*cssqinv*udotu);
    end

    if mod(t, 20) == 0
        fprintf('Iteration: %d, Time: %f \n', t, toc);
    end

end

% Saving the objects:
writematrix(x,'/Users/jpritch/Documents/MATLAB/benchmarks/benchmark_1_sizes/1b_x512.txt')
writematrix(y,'/Users/jpritch/Documents/MATLAB/benchmarks/benchmark_1_sizes/1b_y512.txt')
writematrix(ux,'/Users/jpritch/Documents/MATLAB/benchmarks/benchmark_1_sizes/1b_ux512.txt')
writematrix(uy,'/Users/jpritch/Documents/MATLAB/benchmarks/benchmark_1_sizes/1b_uy512.txt')
writematrix(C,'/Users/jpritch/Documents/MATLAB/benchmarks/benchmark_1_sizes/1b_c512.txt')

%% Grid Size 256
% Simulation parameters - input
niter = niter_all(2);                                                               
nx = nx_all(2);
ny = nx_all(2);
omega_0_256 = omega_0 * nx_all(2)/nx_all(1);

% Initialisation of the concentration field at time t = 0
x = 1:nx;
y = 1:ny;
x_0 = zeros(nx, ny) + x_0_all(2);
y_0 = zeros(nx, ny) + x_0_all(2);

squaredterm = (x - x_0 + zeros(nx, ny)).^2 + transpose((y - y_0 + zeros(nx, ny)).^2);
C = C_0 * exp( - squaredterm / (2 * omega_0_256^2));

% Initialisation of the velocity field at time t = 0
ux = zeros(nx, ny) + ux_all(2);
uy = zeros(nx, ny) + ux_all(2);

% Initialisation of the particle distribution function
geq = zeros(nx, ny, ndir);
for k = 1:ndir
    cdotu = cx(k)*ux + cy(k)*uy;
    udotu = ux.^2 + uy.^2;
    geq(:, :, k) = w(k)*C.*(1 + cssqinv*cdotu + 0.5*cssqinv^2*cdotu.^2 - 0.5*cssqinv*udotu);
end
g = geq;
gcol = zeros(nx, ny, ndir);

% Simulation loop
fprintf('Starting simulation 256\n');
tic
for t = 1:niter
    % Collision
    gcol = omomega*g + omega*geq;

    % Streaming - Explicit version
    % This streaming implementation automatically applies periodic boundary
    % conditions in all edges of the computational domain.
    for k = 1:ndir
        for j = 1:ny
            for i = 1:nx
                xstreamed = mod(i + cx(k), nx);
                if xstreamed == 0
                    xstreamed = nx;
                end
                ystreamed = mod(j + cy(k), ny);
                if ystreamed == 0
                    ystreamed = ny;
                end
                g(xstreamed, ystreamed, k) = gcol(i, j, k);
            end
        end
    end

    % Boundary conditions
    

    % Macroscopic variables
    C = g(:, :, 1) + g(:, :, 2) + g(:, :, 3) + g(:, :, 4) + g(:, :, 5)...
        + g(:, :, 6) + g(:, :, 7) + g(:, :, 8) + g(:, :, 9);

    % Equilibrium distribution function
    for k = 1:ndir
        cdotu = cx(k)*ux + cy(k)*uy;
        udotu = ux.^2 + uy.^2;
        geq(:, :, k) = w(k)*C.*(1 + cssqinv*cdotu + 0.5*cssqinv^2*cdotu.^2 - 0.5*cssqinv*udotu);
    end

    if mod(t, 10) == 0
        fprintf('Iteration: %d, Time: %f \n', t, toc);
    end

end

% Saving the objects:
writematrix(x,'/Users/jpritch/Documents/MATLAB/benchmarks/benchmark_1_sizes/1b_x256.txt')
writematrix(y,'/Users/jpritch/Documents/MATLAB/benchmarks/benchmark_1_sizes/1b_y256.txt')
writematrix(ux,'/Users/jpritch/Documents/MATLAB/benchmarks/benchmark_1_sizes/1b_ux256.txt')
writematrix(uy,'/Users/jpritch/Documents/MATLAB/benchmarks/benchmark_1_sizes/1b_uy256.txt')
writematrix(C,'/Users/jpritch/Documents/MATLAB/benchmarks/benchmark_1_sizes/1b_c256.txt')


%% Grid Size 128
% Simulation parameters - input
niter = niter_all(3);                                                               
nx = nx_all(3);
ny = nx_all(3);
omega_0_128 = omega_0 * nx_all(3)/nx_all(1);

% Initialisation of the concentration field at time t = 0
x = 1:nx;
y = 1:ny;
x_0 = zeros(nx, ny) + x_0_all(3);
y_0 = zeros(nx, ny) + x_0_all(3);

squaredterm = (x - x_0 + zeros(nx, ny)).^2 + transpose((y - y_0 + zeros(nx, ny)).^2);
C = C_0 * exp( - squaredterm / (2 * omega_0_128^2));

% Initialisation of the velocity field at time t = 0
ux = zeros(nx, ny) + ux_all(3);
uy = zeros(nx, ny) + ux_all(3);

% Initialisation of the particle distribution function
geq = zeros(nx, ny, ndir);
for k = 1:ndir
    cdotu = cx(k)*ux + cy(k)*uy;
    udotu = ux.^2 + uy.^2;
    geq(:, :, k) = w(k)*C.*(1 + cssqinv*cdotu + 0.5*cssqinv^2*cdotu.^2 - 0.5*cssqinv*udotu);
end
g = geq;
gcol = zeros(nx, ny, ndir);

% Simulation loop
fprintf('Starting simulation 128\n');
tic
for t = 1:niter
    % Collision
    gcol = omomega*g + omega*geq;

    % Streaming - Explicit version
    % This streaming implementation automatically applies periodic boundary
    % conditions in all edges of the computational domain.
    for k = 1:ndir
        for j = 1:ny
            for i = 1:nx
                xstreamed = mod(i + cx(k), nx);
                if xstreamed == 0
                    xstreamed = nx;
                end
                ystreamed = mod(j + cy(k), ny);
                if ystreamed == 0
                    ystreamed = ny;
                end
                g(xstreamed, ystreamed, k) = gcol(i, j, k);
            end
        end
    end

    % Boundary conditions
    

    % Macroscopic variables
    C = g(:, :, 1) + g(:, :, 2) + g(:, :, 3) + g(:, :, 4) + g(:, :, 5)...
        + g(:, :, 6) + g(:, :, 7) + g(:, :, 8) + g(:, :, 9);

    % Equilibrium distribution function
    for k = 1:ndir
        cdotu = cx(k)*ux + cy(k)*uy;
        udotu = ux.^2 + uy.^2;
        geq(:, :, k) = w(k)*C.*(1 + cssqinv*cdotu + 0.5*cssqinv^2*cdotu.^2 - 0.5*cssqinv*udotu);
    end

    if mod(t, 5) == 0
        fprintf('Iteration: %d, Time: %f \n', t, toc);
    end

end

% Saving the objects:
writematrix(x,'/Users/jpritch/Documents/MATLAB/benchmarks/benchmark_1_sizes/1b_x128.txt')
writematrix(y,'/Users/jpritch/Documents/MATLAB/benchmarks/benchmark_1_sizes/1b_y128.txt')
writematrix(ux,'/Users/jpritch/Documents/MATLAB/benchmarks/benchmark_1_sizes/1b_ux128.txt')
writematrix(uy,'/Users/jpritch/Documents/MATLAB/benchmarks/benchmark_1_sizes/1b_uy128.txt')
writematrix(C,'/Users/jpritch/Documents/MATLAB/benchmarks/benchmark_1_sizes/1b_c128.txt')


%% Grid Size 64
% Simulation parameters - input
niter = niter_all(4);                                                               
nx = nx_all(4);
ny = nx_all(4);
omega_0_064 = omega_0 * nx_all(4)/nx_all(1);

% Initialisation of the concentration field at time t = 0
x = 1:nx;
y = 1:ny;
x_0 = zeros(nx, ny) + x_0_all(4);
y_0 = zeros(nx, ny) + x_0_all(4);

squaredterm = (x - x_0 + zeros(nx, ny)).^2 + transpose((y - y_0 + zeros(nx, ny)).^2);
C = C_0 * exp( - squaredterm / (2 * omega_0_064^2));

% Initialisation of the velocity field at time t = 0
ux = zeros(nx, ny) + ux_all(4);
uy = zeros(nx, ny) + ux_all(4);

% Initialisation of the particle distribution function
geq = zeros(nx, ny, ndir);
for k = 1:ndir
    cdotu = cx(k)*ux + cy(k)*uy;
    udotu = ux.^2 + uy.^2;
    geq(:, :, k) = w(k)*C.*(1 + cssqinv*cdotu + 0.5*cssqinv^2*cdotu.^2 - 0.5*cssqinv*udotu);
end
g = geq;
gcol = zeros(nx, ny, ndir);

% Simulation loop
fprintf('Starting simulation 64\n');
tic
for t = 1:niter
    % Collision
    gcol = omomega*g + omega*geq;

    % Streaming - Explicit version
    % This streaming implementation automatically applies periodic boundary
    % conditions in all edges of the computational domain.
    for k = 1:ndir
        for j = 1:ny
            for i = 1:nx
                xstreamed = mod(i + cx(k), nx);
                if xstreamed == 0
                    xstreamed = nx;
                end
                ystreamed = mod(j + cy(k), ny);
                if ystreamed == 0
                    ystreamed = ny;
                end
                g(xstreamed, ystreamed, k) = gcol(i, j, k);
            end
        end
    end

    % Boundary conditions
    

    % Macroscopic variables
    C = g(:, :, 1) + g(:, :, 2) + g(:, :, 3) + g(:, :, 4) + g(:, :, 5)...
        + g(:, :, 6) + g(:, :, 7) + g(:, :, 8) + g(:, :, 9);

    % Equilibrium distribution function
    for k = 1:ndir
        cdotu = cx(k)*ux + cy(k)*uy;
        udotu = ux.^2 + uy.^2;
        geq(:, :, k) = w(k)*C.*(1 + cssqinv*cdotu + 0.5*cssqinv^2*cdotu.^2 - 0.5*cssqinv*udotu);
    end

    if mod(t, 5) == 0
        fprintf('Iteration: %d, Time: %f \n', t, toc);
    end

end

% Saving the objects:
writematrix(x,'/Users/jpritch/Documents/MATLAB/benchmarks/benchmark_1_sizes/1b_x064.txt')
writematrix(y,'/Users/jpritch/Documents/MATLAB/benchmarks/benchmark_1_sizes/1b_y064.txt')
writematrix(ux,'/Users/jpritch/Documents/MATLAB/benchmarks/benchmark_1_sizes/1b_ux064.txt')
writematrix(uy,'/Users/jpritch/Documents/MATLAB/benchmarks/benchmark_1_sizes/1b_uy064.txt')
writematrix(C,'/Users/jpritch/Documents/MATLAB/benchmarks/benchmark_1_sizes/1b_c064.txt')


%% Grid size 32
% Simulation parameters - input
niter = niter_all(5);                                                               
nx = nx_all(5);
ny = nx_all(5);
omega_0_032 = omega_0 * nx_all(5)/nx_all(1);

% Initialisation of the concentration field at time t = 0
x = 1:nx;
y = 1:ny;
x_0 = zeros(nx, ny) + x_0_all(5);
y_0 = zeros(nx, ny) + x_0_all(5);

squaredterm = (x - x_0 + zeros(nx, ny)).^2 + transpose((y - y_0 + zeros(nx, ny)).^2);
C = C_0 * exp( - squaredterm / (2 * omega_0_032^2));

% Initialisation of the velocity field at time t = 0
ux = zeros(nx, ny) + ux_all(5);
uy = zeros(nx, ny) + ux_all(5);

% Initialisation of the particle distribution function
geq = zeros(nx, ny, ndir);
for k = 1:ndir
    cdotu = cx(k)*ux + cy(k)*uy;
    udotu = ux.^2 + uy.^2;
    geq(:, :, k) = w(k)*C.*(1 + cssqinv*cdotu + 0.5*cssqinv^2*cdotu.^2 - 0.5*cssqinv*udotu);
end
g = geq;
gcol = zeros(nx, ny, ndir);

% Simulation loop
fprintf('Starting simulation 32\n');
tic
for t = 1:niter
    % Collision
    gcol = omomega*g + omega*geq;

    % Streaming - Explicit version
    % This streaming implementation automatically applies periodic boundary
    % conditions in all edges of the computational domain.
    for k = 1:ndir
        for j = 1:ny
            for i = 1:nx
                xstreamed = mod(i + cx(k), nx);
                if xstreamed == 0
                    xstreamed = nx;
                end
                ystreamed = mod(j + cy(k), ny);
                if ystreamed == 0
                    ystreamed = ny;
                end
                g(xstreamed, ystreamed, k) = gcol(i, j, k);
            end
        end
    end

    % Boundary conditions


    % Macroscopic variables
    C = g(:, :, 1) + g(:, :, 2) + g(:, :, 3) + g(:, :, 4) + g(:, :, 5)...
        + g(:, :, 6) + g(:, :, 7) + g(:, :, 8) + g(:, :, 9);

    % Equilibrium distribution function
    for k = 1:ndir
        cdotu = cx(k)*ux + cy(k)*uy;
        udotu = ux.^2 + uy.^2;
        geq(:, :, k) = w(k)*C.*(1 + cssqinv*cdotu + 0.5*cssqinv^2*cdotu.^2 - 0.5*cssqinv*udotu);
    end

    if mod(t, 1) == 0
        fprintf('Iteration: %d, Time: %f \n', t, toc);
    end

end

% Saving the objects:
writematrix(x,'/Users/jpritch/Documents/MATLAB/benchmarks/benchmark_1_sizes/1b_x032.txt')
writematrix(y,'/Users/jpritch/Documents/MATLAB/benchmarks/benchmark_1_sizes/1b_y032.txt')
writematrix(ux,'/Users/jpritch/Documents/MATLAB/benchmarks/benchmark_1_sizes/1b_ux032.txt')
writematrix(uy,'/Users/jpritch/Documents/MATLAB/benchmarks/benchmark_1_sizes/1b_uy032.txt')
writematrix(C,'/Users/jpritch/Documents/MATLAB/benchmarks/benchmark_1_sizes/1b_c032.txt')


