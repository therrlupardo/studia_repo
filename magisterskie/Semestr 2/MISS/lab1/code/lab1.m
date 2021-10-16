number_of_tests = 100000;

R1x = [4; 10];
R1y = 2;

R2x = [7; 8];
R2y = 3;

R3x = 3;
R3y = [3; 9];

R4x = 4;
R4y = [5; 6];

alpha_interval = [1 89];
v_interval = [1 30];

% 1 - find possible trajectories
values = initial_values(number_of_tests, alpha_interval(2), v_interval(2));

results_alpha = [];
results_v = [];

for iterator = 1:length(values)
    alpha = values(iterator, 1);
    v = values(iterator, 2);

    r1 = xy(R1y, alpha, v, R1x(1), R1x(2));
    if (r1 == false)
        continue
    end
    r2 = xy(R2y, alpha, v, R2x(1), R2x(2));
    if (r2 == true)
        continue
    end
        
    r3 = yx(R3x, alpha, v, R3y(1), R3y(2));
    if (r3 == false)
        continue
    end
    r4 = yx(R4x, alpha, v, R4y(1), R4y(2));
    if (r4 == true)
        continue
    end

    results_alpha = [results_alpha; alpha];
    results_v = [results_v; v];
end

subplot(2, 1, 1);
plot(results_alpha, results_v, 'o');
axis([alpha_interval(1) alpha_interval(2) v_interval(1) v_interval(2)]);
xlabel('alpha');
ylabel('v');
grid on;
grid minor;
subplot(2, 1, 2);   

% 2 - plot graph with trajectories
for trajectories_counter = 1:7
x_values = [];
y_values = [];
    for x = 0:0.1:15
       x_values = [x_values; x];
       y_values = [y_values; y_val(x, results_alpha(trajectories_counter), results_v(trajectories_counter))];
    end
plot(x_values, y_values);
hold on;
end

plot(R1x, [R1y R1y], 'Color', 'g');
hold on;
plot(R2x, [R2y R2y], 'Color', 'r');
hold on;
plot([R3x R3x], R3y, 'Color', 'g');
hold on;
plot([R4x R4x], R4y, 'Color', 'r');
hold on;
axis([0 15 0 15]);
xlabel('x');
ylabel('y');
grid on;
grid minor;
hold off;


