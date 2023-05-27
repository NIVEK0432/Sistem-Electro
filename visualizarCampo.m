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

