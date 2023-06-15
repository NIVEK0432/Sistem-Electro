% Grafica de la magnitud de la fuerza magnética
% Este código calcula y grafica la magnitud de la fuerza magnética (F) ejercida por un dipolo magnético (mu) de una góndola circular de radio (R), en función de la posición vertical (z), cuando una corriente (I) circula por la góndola.

% Parámetros
mu = 6.25;          % Dipolo magnético de la góndola (unidades dependen del contexto, como A*m^2)
mu0 = 4*pi*10^(-7);  % Permeabilidad magnética del vacío (Tesla metro por amperio, T*m/A)
I = 1;               % Corriente (1 A)
R = 2.5;             % Radio de la góndola (2.5 m)

% Valores de z
z = linspace(-10, 10, 100);  % Rango de valores para z, generando 100 puntos equidistantes en el intervalo -10 a 10 metros

% Cálculo de la fuerza magnética F
f = (3/2) * I * mu * mu0 * R^2 .* z ./ (R^2 + z.^2).^(5/2);

% Gráfica
plot(z, f, 'LineWidth', 2);
xlabel('z (m)');  % Etiqueta del eje x
ylabel('(N)');    % Etiqueta del eje y
title('Magnitud de la Fuerza Magnética vs Z');  % Título de la gráfica
grid on;  % Activar cuadrícula en la gráfica
