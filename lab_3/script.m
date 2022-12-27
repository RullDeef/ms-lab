#!/bin/octave -qf

pkg load statistics

global T = [-5.00, -4.80, -4.60, -4.40, -4.20, -4.00, -3.80, -3.60, -3.40, -3.20, -3.00, -2.80, -2.60, -2.40, -2.20, -2.00, -1.80, -1.60, -1.40, -1.20, -1.00, -0.80, -0.60, -0.40, -0.20, 0.00, 0.20, 0.40, 0.60, 0.80, 1.00, 1.20, 1.40, 1.60, 1.80, 2.00, 2.20, 2.40, 2.60, 2.80, 3.00, 3.20, 3.40, 3.60, 3.80, 4.00, 4.20, 4.40, 4.60, 4.80, 5.00, 5.20, 5.40, 5.60, 5.80, 6.00, 6.20, 6.40, 6.60, 6.80, 7.00];

global Y = [168.04, 134.84, 151.80, 122.02, 124.47, 99.41, 83.67, 79.85, 67.28, 49.34, 38.70, 37.60, 56.74, 39.18, 14.90, 18.16, 5.57, 20.01, 7.47, -0.83, -4.27, 6.99, -5.98, 0.06, 5.12, 4.25, 11.96, -3.26, 11.99, 1.46, 6.77, 7.04, 20.57, 17.30, 11.79, 27.22, 41.66, 37.30, 54.07, 60.48, 69.80, 99.22, 92.88, 90.04, 115.74, 109.33, 124.73, 155.13, 151.89, 177.92, 188.00, 193.02, 215.24, 227.41, 250.07, 248.79, 286.57, 294.65, 326.11, 341.49, 351.17];

function res = Tk(k)
    global T;
    res = sum(T .^ k);
endfunction;

function res = Yk(k)
    global T;
    global Y;
    res = sum((T .^ k) .* Y);
endfunction;

function res = sko(theta)
    global T;
    global Y;

    res = sqrt(sum((theta(1) + theta(2) * T + theta(3) * T .^ 2 - Y) .^ 2));
endfunction;

T_MAT = [Tk(0), Tk(1), Tk(2);
         Tk(1), Tk(2), Tk(3);
         Tk(2), Tk(3), Tk(4)]
Y_MAT = [Yk(0); Yk(1); Yk(2)]

THETA = T_MAT\Y_MAT

SKO = sko(THETA)

hold on;
scatter(T, Y, 16, 1, "filled");

t = linspace(min(T), max(T), 100);
y = THETA(1) + THETA(2) * t + THETA(3) * t .^ 2;
plot(t, y);
pause;
