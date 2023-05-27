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