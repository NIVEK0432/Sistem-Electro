% Gráfica de la posición con respecto al tiempo del movimiento de la góndola, y de la velocidad con respecto al tiempo
% El siguiente codigo es una implementación numérica para simular el movimiento de una góndola sometida a un frenado magnético
I = 1;                            % Corriente
mu = 1;                           % Permeabilidad relativa
mu_0 = 4 * pi * 1e-7;             % Permeabilidad del vacío
R = 1;                            % Radio
m = 1;                            % Masa
g = 9.8;                          % Aceleración debida a la gravedad
dt = 0.01;                        % Paso de tiempo
t_max = 3;                        % Tiempo máximo

t = 0:dt:t_max;                   % Vector de tiempo desde 0 hasta t_max con paso dt
z = linspace(3, 0, numel(t));    % Inicializar posición desde 30 hasta 0
v = 30 * ones(size(t));           % Inicializar velocidad en 30

% Bucle de integración numérica
for i = 1:length(t)-1
    A = (3 * I * mu * mu_0 * R^2 / (2 * m)) * (z(i) / (R^2 + z(i)^2)^(5/2)) - g;
    
    v_half = v(i) + A * dt / 2;          % Estimación de la velocidad en el punto intermedio
    z_half = z(i) + v(i) * dt / 2;       % Estimación de la posición en el punto intermedio
    
    A_plus_1 = (3 * I * mu * mu_0 * R^2 / (2 * m)) * (z_half / (R^2 + z_half^2)^(5/2)) - g;
    
    v(i + 1) = v_half + A_plus_1 * dt / 2;  % Actualización de la velocidad en el siguiente paso
    z(i + 1) = z(i) + v_half * dt;           % Actualización de la posición en el siguiente paso
end

% Gráfica de posición con respecto al tiempo
figure;
subplot(2, 1, 1);
plot(t, flip(z), 'b', 'LineWidth', 2);  % Invertir el orden de los valores de z para que sea descendente
xlabel('Tiempo');
ylabel('Posición (z)');
title('Gráfica de posición con respecto al tiempo');
grid on;

% Gráfica de velocidad con respecto al tiempo
subplot(2, 1, 2);
plot(t, v, 'r', 'LineWidth', 2);
xlabel('Tiempo');
ylabel('Velocidad');
title('Gráfica de velocidad con respecto al tiempo');
grid on;