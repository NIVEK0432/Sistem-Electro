# Sistemas Electromagneticos

# Proyecto: Torre de Caída con Frenos Magnéticos

## Descripción

Este proyecto se centra en el estudio y funcionamiento de las torres de caída en los parques de diversiones, con un enfoque específico en los frenos magnéticos utilizados en estas atracciones. La torre de caída es una atracción popular donde los pasajeros experimentan una caída libre seguida de una desaceleración brusca.

Uno de los tipos de frenos utilizados en estas torres son los frenos magnéticos, los cuales aprovechan las corrientes de Eddy. Estos frenos ofrecen varias ventajas, como un mantenimiento reducido debido a su funcionamiento sin fricción, mayor seguridad al no requerir una fuente de energía adicional, y una experiencia de frenado más cómoda para los pasajeros al evitar sacudidas bruscas.

Las corrientes de Eddy, también conocidas como corrientes de Foucault o corrientes parásitas, se generan cuando un campo magnético variable atraviesa un conductor eléctrico. El movimiento relativo induce una circulación de electrones en el conductor (Ley de Faraday). Estas corrientes, a su vez, crean electroimanes con campos magnéticos que se oponen al efecto del campo magnético aplicado (Ley de Lenz). En el caso de la torre de caída, la góndola cuenta con imanes, y la parte inferior de la torre tiene un conductor eléctrico. Durante la caída de la góndola, la energía cinética se transfiere a las corrientes de Eddy, lo que disminuye la velocidad sin necesidad de utilizar fricción entre superficies.

## Codigo integracion discreta

``` matlab
f1 = @(x) x.^2;  % Función f(x) = x^2
f2 = @(theta) sin(theta);  % Función f(theta) = sin(theta)
a1 = -1;  % Límite inferior del primer caso de prueba
b1 = 1;  % Límite superior del primer caso de prueba
N_values = [10, 50, 100, 150, 200, 250, 300, 350, 400, 450, 500];  % Valores de N para graficar

re1 = [];  % Matriz para almacenar los resultados del primer caso de prueba
t1 = [];  % Matriz para almacenar los tiempos de ejecución del primer caso de prueba
tic;  % Inicia el cronómetro del primer caso de prueba

% Bucle para el primer caso de prueba
for N = N_values
    dx = (b1 - a1) / N;  % Tamaño del paso para la integración discreta
    x = linspace(a1, b1, N+1);  % Vector de puntos equidistantes dentro del intervalo de integración
    
    integral_sum = sum(f1(x));  % Suma de los valores de f(x)
    result = integral_sum * dx;  % Aproximación de la integral
    
    re1 = [re1, result];  % Almacena el resultado en la matriz de resultados
    t1 = [t1, toc];  % Almacena el tiempo de ejecución actual
end

total_time1 = toc();  % Calcula el tiempo total del primer caso de prueba

a2 = 0;  % Límite inferior del segundo caso de prueba
b2 = 2*pi;  % Límite superior del segundo caso de prueba

re2 = [];  % Matriz para almacenar los resultados del segundo caso de prueba
t2 = [];  % Matriz para almacenar los tiempos de ejecución del segundo caso de prueba
tic;  % Reinicia el cronómetro del segundo caso de prueba

% Bucle para el segundo caso de prueba
for N = N_values
    dx = (b2 - a2) / N;  % Tamaño del paso para la integración discreta
    x = linspace(a2, b2, N+1);  % Vector de puntos equidistantes dentro del intervalo de integración
    
    integral_sum = sum(f2(x));  % Suma de los valores de f(theta)
    result = integral_sum * dx;  % Aproximación de la integral
    
    re2 = [re2, result];  % Almacena el resultado en la matriz de resultados
    t2 = [t2, toc];  % Almacena el tiempo de ejecución actual
end

total_time2 = toc();  % Calcula el tiempo total del segundo caso de prueba

figure;
plot(N_values, t1, 'bo-', 'LineWidth', 1.5);
hold on;
plot(N_values, t2, 'ro-', 'LineWidth', 1.5);
xlabel('N');
ylabel('Tiempo');
title('Tiempo vs. N');
legend('∫ x^2 dx', '∫ sin(theta) dtheta');
grid on;

disp('Resultados del primer caso de prueba:');
disp(re1);
fprintf('Tiempo total del primer caso de prueba: %.4f segundos\n', total_time1);

disp('Resultados del segundo caso de prueba:');
disp(re2);
fprintf('Tiempo total del segundo caso de prueba: %.4f segundos\n', total_time2);
```

## Codigo campo electrico 

``` matlab
% Iniciar el cronómetro
tic

% Llamado a la función calcularCampoMagnetico con los valores deseados
r = 1;
i = 1;
n = 100;
[bcx, bcy, bcz, y, z] = calcularCampoMagnetico(r, i, n);

% Coordenadas del punto de interés
punto_x = 0.2;
punto_y = 0.3;
punto_z = 0.4;

% Buscar índices de los puntos más cercanos en la malla
[~, indice_y] = min(abs(y - punto_y));
[~, indice_z] = min(abs(z - punto_z));

% Obtención del valor del campo magnético en el punto de interés
campo_x = bcx(indice_z, indice_y);
campo_y = bcy(indice_z, indice_y);
campo_z = bcz(indice_z, indice_y);

% Impresión del valor del campo magnético en el punto de interés
fprintf('Campo Magnético en el punto (%f, %f, %f): %e T\n', punto_x, punto_y, punto_z, norm([campo_x, campo_y, campo_z]));

% Gráfico del campo magnético en la malla
[Y, Z] = meshgrid(y, z);
Y = flipud(Y);
Z = flipud(Z);
quiver(Y, Z, bcy./sqrt(bcy.^2+bcz.^2), bcz./sqrt(bcy.^2+bcz.^2));
xlabel('y');
ylabel('z');
title('Campo Magnético');

% Detener el cronómetro
tiempo_transcurrido = toc;

% Mostrar el tiempo transcurrido en segundos
fprintf('El tiempo de ejecución es: %.4f segundos.\n', tiempo_transcurrido);

function [bcx, bcy, bcz, y, z] = calcularCampoMagnetico(r, i, n)
    
    % Generamos la matriz/malla
    y = linspace(-3*r, 3*r, 21);
    z = linspace(-r, 5*r, 21);
    [Y, Z] = meshgrid(y, z);
    
    % Inicializamos los vectores para almacenar los componentes del campo magnético
    bcx = zeros(length(z), length(y));
    bcy = zeros(length(z), length(y));
    bcz = zeros(length(z), length(y));
    
    % Bucle para calcular el campo magnético en cada punto de la malla
    for ind = 1:n
        % Calculamos el ángulo theta correspondiente al paso de integración
        theta = (ind - 1) * 2 * pi / n;
        
        % Calculamos la distancia al punto de la malla y la elevamos a la tercera potencia
        d = sqrt(r^2 + Y.^2 + Z.^2 - (2*r)*Y*(sin(theta))).^3;
        
        % Calculamos los componentes del campo magnético
        bcx = bcx + cos(theta) ./ d;
        bcy = bcy + sin(theta) ./ d;
        bcz = bcz + (r - Y .* sin(theta)) ./ d;
    end
    
    % Calculamos el campo magnético completo
    bcx = 1E-7 * r * i * Z .* bcx * 2 * pi / n;
    bcy = 1E-7 * r * i * Z .* bcy * 2 * pi / n;
    bcz = 1E-7 * r * i * bcz * 2 * pi / n;
    
    % Invertimos los vectores para que estén en el orden adecuado
    bcx = flipud(bcx);
    bcy = flipud(bcy);
    bcz = flipud(bcz);
end


```
## Codigo posicion con respecto al tiempo

``` matlab
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
```

## Codigo magnitud del campo

``` matlab
% Grafica de la magnitud del campo magnetico
% Este código calcula y grafica la magnitud del campo magnético (B) generado por una corriente (I) que circula por una góndola circular de radio (R), en función de la posición vertical (z).
% Parámetros
mu0 = 4*pi*10^(-7);  % Permeabilidad magnética del vacío 
I = 1;               % Corriente 
R = 2.5;             % Radio de la góndola 

% Valores de z
z = linspace(-10, 10, 100);  % Rango de valores para z

% Cálculo del campo magnético B
b = (mu0 * I * R^2) ./ (2 * (R^2 + z.^2).^(3/2));

% Gráfica
plot(z, b, 'LineWidth', 2);
xlabel('z (m)');
ylabel('(T)');
title('Magnitud del Campo Magnético vs Z');
grid on;
```

## Codigo fuerza magnetica

``` python
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
```
