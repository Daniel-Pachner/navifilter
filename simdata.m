r = 100;
K = 1.1;
dt = 0.1;
v = 5;
N = ceil(2*pi*r/v/dt / 4);

phi_tru = 0;
phi_odo = phi_tru + 0.05;
i = 0;

s_tru = zeros(1, N);
s_gps = zeros(1, N);
s_odo = zeros(1, N);

x_tru = zeros(2, N);
x_odo = zeros(2, N);
x_gps = zeros(2, N);
gps_sigma = 1.0*ones(1, N);
gps_sigma(floor(N*0.6) : floor(N*0.8)) = 10;
gps_sigma(floor(N*0.1) : floor(N*0.3)) = 10;

T = dt*(0 : 1 : N-1);
for t = T
    phi_tru = phi_tru + v/r*dt;
    phi_odo = phi_odo + K*v/r*dt;

    i = i + 1;
    x_odo(1, i) = r*cos(phi_odo);
    x_odo(2, i) = r*sin(phi_odo);
    
    x_tru(1, i) = r*cos(phi_tru);
    x_tru(2, i) = r*sin(phi_tru);
  
    x_gps(:, i) = x_tru(:, i) + gps_sigma(i)*randn(2, 1);
    
    s_tru(i) = r*phi_tru;
    s_odo(i) = r*phi_odo;
    phi_gps = myangle(x_gps(1, i), x_gps(2, i));
    s_gps(i) = r*phi_gps; 
end

figure
subplot(1, 2, 1)
hx_tru = plot(x_tru(1, :), x_tru(2, :), 'g', 'linewidth', 4, ...
'displayname', 'True path');
hold on
hx_gps = plot(x_gps(1, :), x_gps(2, :), 'ro', 'markersize', 2, 'markerfacecolor', 'r', ...
'displayname', 'GNSS location');
hx_odo = plot(x_odo(1, :), x_odo(2, :), 'b-', ...
'displayname', 'Odometric path', ...
x_odo(1, [1, end]), x_odo(2, [1, end]), ...
'bo', 'markersize', 4, 'markerfacecolor', 'b');
legend([hx_tru, hx_odo(1), hx_gps])
axis equal
title('Cartesian view')

subplot(1, 2, 2)
plot(T, s_tru, 'g', 'linewidth', 4, ...
'displayname', 'True path');
hold on
plot(T, s_odo, 'b-', ...
'displayname', 'Odometric path');
plot(T, s_gps, 'ro', 'markersize', 2, 'markerfacecolor', 'r', ...
'displayname', 'GNSS path');
legend
title('Track distance view')