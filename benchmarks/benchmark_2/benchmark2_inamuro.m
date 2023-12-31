%% Lattice Boltzmann method code: advection-diffusion of Cylinder without flow
%% Setting Grid Independant Variables
% Simulation parameters - input
% Scalars
grids = 2;
C_c = 1;
tau = 0.516;
a = 40;
nx = 129;
ny = 129;

% Vectors
niter = [16830 33692];
x = (1:nx) - 64.5;
y = (1:ny) - 64.5;
r = zeros(nx,ny);
for i=1:nx
    for j=1:ny
        r(i,j) = sqrt(x(i)^2+y(j)^2);
    end
end

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
D = cssq*(tau - 0.5);

% Initialisation of the concentration and velocity field at time t = 0
mask = zeros(nx, ny);
C_BGK_inamuro = zeros(nx, ny, grids);
[row,col] = find(abs(r-a)<1.4 & r>a); % Finding layer mask for C = 1
for i = 1:length(row)
    mask(row(i), col(i)) = 1;
end
mask64row = mask(1:65,1:65);
mask64col = mask(1:65,1:65);
for i=1:64
    for j=1:64
        if mask64row(i,j) == 1 && mask64row(i+1,j) == 1
            mask64row(i,j) = 0;
        end
        if mask64col(i,j) == 1 && mask64col(i,j+1) == 1
            mask64col(i,j) = 0;
        end
    end
end
mask64 = mask64col(1:64,1:64)+mask64row(1:64,1:64);
for i=1:64
    for j=1:64
        if mask64(i,j) == 2
            mask64(i,j) = 1;
        end
    end
end

mask(1:64,1:64) = mask64(1:64,1:64);
mask(1:64,65:128) = mask64(1:64,64:-1:1);
mask(65:128,1:64) = mask64(64:-1:1,1:64);
mask(65:128,65:128) = mask64(64:-1:1,64:-1:1);

C_BGK_inamuro(:,:,1) = mask;
C_BGK_inamuro(:,:,2) = C_BGK_inamuro(:,:,1);

[row,col] = find(mask == 1);

heatmap(mask)

ux = zeros(nx, ny);
uy = zeros(nx, ny);


%% Simulating using LBM
% Initialisation of the particle distribution function
for l = 1:grids
    geq = zeros(nx, ny, ndir);
    for k = 1:ndir
        cdotu = cx(k)*ux + cy(k)*uy;
        udotu = ux.^2 + uy.^2;
        geq(:, :, k) = w(k)*C_BGK_inamuro(:,:,l).*(1 + cssqinv*cdotu + 0.5*cssqinv^2*cdotu.^2 - 0.5*cssqinv*udotu);
    end
    g = geq;
    gcol = zeros(nx, ny, ndir);
    
    % Simulation loop
    fprintf('Starting simulation \n');
    tic
    for t = 1:niter(l)
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
        for i = 1:length(row)
            if mask(col(i)-1,row(i)-1) == 0 && mask(col(i)-1,row(i)  ) == 0 && ...
               mask(col(i)-1,row(i)+1) == 0 && mask(col(i)  ,row(i)-1) == 0 && ...
               mask(col(i)  ,row(i)  ) == 0 && mask(col(i)  ,row(i)+1) == 0 && ...
               mask(col(i)+1,row(i)-1) == 0 && mask(col(i)+1,row(i)  ) == 0 && ...
               mask(col(i)+1,row(i)+1) == 0
                k_in = [];
                k_out = [];
            end
            for k = 1:ndir
                % g(col(i),row(i),opp(k)+1) = -gcol(col(i),row(i),k) + 2*w(k) * C_c;
                % C_dash = (C_c-gsum)/wsum;
            end
        end
    
        % Macroscopic variables
        C_BGK_inamuro(:,:,l) = g(:, :, 1) + g(:, :, 2) + g(:, :, 3) + g(:, :, 4) + g(:, :, 5)...
            + g(:, :, 6) + g(:, :, 7) + g(:, :, 8) + g(:, :, 9);
    
        % Equilibrium distribution function
        for k = 1:ndir
            cdotu = cx(k)*ux + cy(k)*uy;
            udotu = ux.^2 + uy.^2;
            geq(:, :, k) = w(k)*C_BGK_inamuro(:,:,l).*(1 + cssqinv*cdotu + 0.5*cssqinv^2*cdotu.^2 - 0.5*cssqinv*udotu);
        end
    
        if mod(t, 150) == 0
            fprintf('Iteration: %d, Time: %f \n', t, toc);
        end
    
    end

end


%% Saving C to file:
save /Users/jpritch/Documents/MATLAB/benchmarks/benchmark_2/C_inamuro C_BGK_inamuro


