% Grafica de la magnitud de la fuerza magnetica
% Este código calcula y grafica la magnitud de la fuerza magnética (F) ejercida por un dipolo magnético (mu) de una góndola circular de radio (R), en función de la posición vertical (z), cuando una corriente (I) circula por la góndola.
% Parámetros
mu = 6.25;          % Dipolo magnético de la góndola 
mu0 = 4*pi*10^(-7);  % Permeabilidad magnética del vacío 
I = 1;               % Corriente 
R = 2.5;             % Radio de la góndola 

% Valores de z
z = linspace(-10, 10, 100);  % Rango de valores para z

% Cálculo de la fuerza magnética F
f = (3/2) * I * mu * mu0 * R^2 .* z ./ (R^2 + z.^2).^(5/2);

% Gráfica
plot(z, f, 'LineWidth', 2);
xlabel('z (m)');
ylabel('(N)');
title('Magnitud de la Fuerza Magnética vs Z');
grid on;