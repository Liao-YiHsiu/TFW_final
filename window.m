M = 10000;
m = 100;
index = -M:M;
x = zeros(1, 2*M+1);

%rectangular window
x(index < m & index > -m) = hamming(m*2-1);
x(index < m & index > -m) = hamming(m*2-1);

size(x)
y = fft(x);
y_ = fftshift(y);
figure
subplot(3,1,1);
plot(index, x);
subplot(3,1,2);
plot(index, log(abs(y_))-log(max(abs(y_))));

subplot(3,1,3);
plot(index, unwrap(angle(y_)));
