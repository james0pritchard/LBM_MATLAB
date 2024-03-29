%% Plotting of Benchamrk 1 with different grid sizes
%% Read variables from file
load /Users/jpritch/Documents/MATLAB/model/130x500/saved/T5000
T = T(2:129,1:468); % This removes the upper and lower rows which weren't
                    % part of the actual model
load /Users/jpritch/Documents/MATLAB/model/130x500/saved/theta1000
theta = theta(2:129,1:468);


%% Setting Variables
% Scalars
nx = 468;
ny = 128;
scale = 0.018; % 18 is closest to mm in paper
a = 404; % Centre of curve at fingertip
T_c = -30; 
T_h = 25;

% Vectors
x = 0:nx-1;
y = (0:ny-1) - (ny-1)/2;


%% Cleaning up T
xs = zeros(ny,nx);
for i = 1:nx
    xs(:,i) = x(i)+1;
end
ys = zeros(ny,nx);
for i = 1:ny
    ys(i,:) = y(i);
end
r = zeros(ny,nx);
for i = 1:ny
    for j = 1:nx
        r(i,j) = sqrt((x(j)-a)^2+(y(i)+0.5)^2);
    end
end
[row1,col1] = find(abs(r)>(32*ny/64 - 0.5) & xs >= a & ys >= 0);
for i = 1:length(row1)
    T(row1(i), col1(i)) = NaN;
    theta(row1(i), col1(i)) = NaN;
end
[row2,col2] = find(abs(r)>(32*ny/64 - 0.5) & xs >= a & ys <= 0);
for i = 1:length(row2)
    T(row2(i), col2(i)) = NaN;
    theta(row2(i), col2(i)) = NaN;
end

T = 500 * T - 273;

%% Plotting T
% Initial setup
% figure;
% axes('FontSize',11.5, 'NextPlot', 'add');
% % Plotting finger outline
% plot(zeros(ny),((0:ny-1) - (ny-1)/2)/(ny-1), 'k', LineWidth=1);
% plot((0:a)/(ny-1),(zeros(a+1) - 0.5), 'k', LineWidth=1);
% plot((0:a)/(ny-1),zeros(a+1) + 0.5, 'k', LineWidth=1);
% th = linspace( pi/2, -pi/2, 100);
% R = 1/2;
% x_c = R*cos(th) + (a)/(ny-1);
% y_c = R*sin(th) + 0;
% plot(x_c,y_c, 'k', LineWidth=1);
% % Plotting bone outline
% plot((0:a)/(ny-1),zeros(a+1) - 0.25, 'k', LineWidth=0.7);
% plot((0:a)/(ny-1),zeros(a+1) + 0.25, 'k', LineWidth=0.7);
% R = 1/4;
% x_c = R*cos(th) + (a)/(ny-1);
% y_c = R*sin(th) + 0;
% plot(x_c,y_c, 'k', LineWidth=0.7);
% % Making plot look nice
% xlabel('${x/N_y}$','interpreter','latex', fontsize=19)
% ylabel('${y/N_y}$','interpreter','latex', fontsize=19)
% axis equal
% xlim([-0.2*scale 3.85*scale])
% ylim([-0.7*scale 0.7*scale])

% Temperature heatmap
figure;
axes('FontSize',18, 'NextPlot', 'add');
% Plotting temperature of finger
s = pcolor(scale*x/(ny-1),scale*y/(ny-1),T);
set(s, 'EdgeColor', 'none');
% Plotting finger outline
plot(zeros(ny),scale*((0:ny-1) - (ny-1)/2)/(ny-1), 'k', LineWidth=1);
plot(scale*(0:a)/(ny-1),scale*(zeros(a+1) - 0.5), 'k', LineWidth=1);
plot(scale*(0:a)/(ny-1),scale*(zeros(a+1) + 0.5), 'k', LineWidth=1);
th = linspace( pi/2, -pi/2, 100);
R = 1/2;
x_c = R*cos(th) + (a)/(ny-1);
y_c = R*sin(th) + 0;
plot(scale*x_c,scale*y_c, 'k', LineWidth=1);
% Plotting bone outline
plot(scale*(0:a)/(ny-1),scale*(zeros(a+1) - 0.25), 'k', LineWidth=0.7);
plot(scale*(0:a)/(ny-1),scale*(zeros(a+1) + 0.25), 'k', LineWidth=0.7);
R = 1/4;
x_c = R*cos(th) + (a)/(ny-1);
y_c = R*sin(th) + 0;
plot(scale*x_c,scale*y_c, 'k', LineWidth=0.7);
% Making plot look nice
xlabel('${x/N_y}$','interpreter','latex', fontsize=25)
ylabel('${y/N_y}$','interpreter','latex', fontsize=25)
axis equal
xlim([-0.2*scale 3.85*scale])
ylim([-0.7*scale 0.7*scale])
c = colorbar;
c.Limits = [T_c T_h];
box on

% Temperature contour
figure;
axes('FontSize',18, 'NextPlot', 'add');
% Plotting temperature of finger
contour(scale*x/(ny-1),scale*y/(ny-1),T, T_c:1:T_h, ...
                LineWidth=0.9);
% Plotting finger outline
plot(zeros(ny),scale*((0:ny-1) - (ny-1)/2)/(ny-1), 'k', LineWidth=1);
plot(scale*(0:a)/(ny-1),scale*(zeros(a+1) - 0.5), 'k', LineWidth=1);
plot(scale*(0:a)/(ny-1),scale*(zeros(a+1) + 0.5), 'k', LineWidth=1);
th = linspace( pi/2, -pi/2, 100);
R = 1/2;
x_c = R*cos(th) + (a)/(ny-1);
y_c = R*sin(th) + 0;
plot(scale*x_c,scale*y_c, 'k', LineWidth=1);
% Plotting bone outline
plot(scale*(0:a)/(ny-1),scale*(zeros(a+1) - 0.25), 'k', LineWidth=0.7);
plot(scale*(0:a)/(ny-1),scale*(zeros(a+1) + 0.25), 'k', LineWidth=0.7);
R = 1/4;
x_c = R*cos(th) + (a)/(ny-1);
y_c = R*sin(th) + 0;
plot(scale*x_c,scale*y_c, 'k', LineWidth=0.7);
% Making plot look nice
xlabel('${x/N_y}$','interpreter','latex', fontsize=25)
ylabel('${y/N_y}$','interpreter','latex', fontsize=25)
axis equal
xlim([-0.2*scale 3.85*scale])
ylim([-0.7*scale 0.7*scale])
c = colorbar;
c.Limits = [T_c T_h];
box on


% Necrosis plotting
% figure;
% axes('FontSize',11.5, 'NextPlot', 'add');
% s = pcolor(scale*x/(ny-1),scale*y/(ny-1),theta);
% set(s, 'EdgeColor', 'none');
% % Plotting finger outline
% plot(zeros(ny),((0:ny-1) - (ny-1)/2)/(ny-1), 'k', LineWidth=1);
% plot((0:a)/(ny-1),(zeros(a+1) - 0.5), 'k', LineWidth=1);
% plot((0:a)/(ny-1),zeros(a+1) + 0.5, 'k', LineWidth=1);
% th = linspace( pi/2, -pi/2, 100);
% R = 1/2;
% x_c = R*cos(th) + (a)/(ny-1);
% y_c = R*sin(th) + 0;
% plot(x_c,y_c, 'k', LineWidth=1);
% % Plotting bone outline
% plot((0:a)/(ny-1),zeros(a+1) - 0.25, 'k', LineWidth=0.7);
% plot((0:a)/(ny-1),zeros(a+1) + 0.25, 'k', LineWidth=0.7);
% R = 1/4;
% x_c = R*cos(th) + (a)/(ny-1);
% y_c = R*sin(th) + 0;
% plot(x_c,y_c, 'k', LineWidth=0.7);
% % Making plot look nice
% xlabel('${x/N_y}$','interpreter','latex', fontsize=19)
% ylabel('${y/N_y}$','interpreter','latex', fontsize=19)
% axis equal
% colorbar
% xlim([-0.2*scale 3.85*scale])
% ylim([-0.7*scale 0.7*scale])
% box on











