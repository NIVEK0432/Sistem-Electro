I = 1;                            % Corriente (Amperios)
mu = 1;                           % Permeabilidad relativa
mu_0 = 4 * pi * 1e-7;             % Permeabilidad del vacío (T·m/A)
R = 1;                            % Radio (metros)
m = 1;                            % Masa (kilogramos)
g = 9.8;                          % Aceleración debida a la gravedad (m/s^2)
dt = 0.01;                        % Paso de tiempo (segundos)
t_max = 3;                        % Tiempo máximo (segundos)

t = 0:dt:t_max;                   % Vector de tiempo desde 0 hasta t_max con paso dt
z = linspace(3, 0, numel(t));     % Inicializar posición desde 3 metros hasta 0 metros
v = 30 * ones(size(t));           % Inicializar velocidad en 30 m/s

% Bucle de integración numérica
for i = 1:length(t)-1
    A = (3 * I * mu * mu_0 * R^2 / (2 * m)) * (z(i) / (R^2 + z(i)^2)^(5/2)) - g;
    % Aceleración (m/s^2) = (Amperios * T·m/A * metros^2) / (kilogramos) - m/s^2
    
    v_half = v(i) + A * dt / 2;          % Estimación de la velocidad en el punto intermedio (m/s)
    z_half = z(i) + v(i) * dt / 2;       % Estimación de la posición en el punto intermedio (metros)
    
    A_plus_1 = (3 * I * mu * mu_0 * R^2 / (2 * m)) * (z_half / (R^2 + z_half^2)^(5/2)) - g;
    % Aceleración (m/s^2) = (Amperios * T·m/A * metros^2) / (kilogramos) - m/s^2
    
    v(i + 1) = v_half + A_plus_1 * dt / 2;  % Actualización de la velocidad en el siguiente paso (m/s)
    z(i + 1) = z(i) + v_half * dt;           % Actualización de la posición en el siguiente paso (metros)
end

% Gráfica de posición con respecto al tiempo
figure;
subplot(2, 1, 1);
plot(t, flip(z), 'b', 'LineWidth', 2);  % Invertir el orden de los valores de z para que sea descendente
xlabel('Tiempo (segundos)');
ylabel('Posición (metros)');
title('Gráfica de posición con respecto al tiempo');
grid on;

% Gráfica de velocidad con respecto al tiempo
subplot(2, 1, 2);
plot(t, v, 'r', 'LineWidth', 2);
xlabel('Tiempo (segundos)');
ylabel('Velocidad (m/s)');
title('Gráfica de velocidad con respecto al tiempo');
grid on;
