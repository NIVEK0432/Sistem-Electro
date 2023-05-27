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
