% Grafica de la magnitud del campo magnetico
% Este código calcula y grafica la magnitud del campo magnético (B) generado por una corriente (I) que circula por una góndola circular de radio (R), en función de la posición vertical (z).
% Parámetros
mu0 = 4*pi*10^(-7); % Permeabilidad magnética del vacío (H/m)
I = 1; % Corriente (A)
R = 2.5; % Radio de la góndola (m)

% Valores de z
z = linspace(-10, 10, 100); % Rango de valores para z (m)

% Cálculo del campo magnético B
b = (mu0 * I * R^2) ./ (2 * (R^2 + z.^2).^(3/2)); % Campo magnético (T)

% Gráfica
plot(z, b, 'LineWidth', 2);
xlabel('z (m)');
ylabel('B (T)');
title('Magnitud del Campo Magnético vs Z');
grid on;

