t = 0:1e-4:0.1;
x = sin(2*pi*440*t) + sin(2*pi*490*t);

show('x[n] without zero padding', t, x, false, false, false, [-40, 5], 1000, true);
print('wzero', '-dpng', '-r300');

show('x[n] with zero padding', t, x, false, false, true, [-40, 5], 1000, true);
print('wozero', '-dpng', '-r300');

%peak detection
figure
% y[-1] y[0] y[1]
y = [30 100 90];
x = [-1 0 1];
% y = ax^2+bx+y0
a = (y(1) + y(3))/2 - y(2);
b = (y(3) - y(1))/2;

t = -2:1e-2:2;
approx = a*(t.^2) + b*t + y(2);

max_x = -b/(2*a);
max_y = y(2) - b*b/(4*a);

plot(x, y, 'r*', t, approx, max_x, max_y, 'b*');

print('quad', '-dpng', '-r300');
