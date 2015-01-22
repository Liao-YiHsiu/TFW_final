[a1, fs] = wavread('piano.wav');

x = a1(:, 1)';

x_ = x(180000:190000);
x_corr = xcorr(x_, x_);
x_corr = x_corr(size(x_corr, 2)/2:end);


figure
subplot(211);
plot(x_);
title('Piano waveform', 'FontSize', 15);

subplot(212);
plot(x_corr);
hold on;

[pks, idx] = findpeaks(x_corr, 'SORTSTR', 'descend');
plot(idx(1), pks(1), 'r*');

hold off;

title('Auto Correlation', 'FontSize', 15);

print('auto', '-dpng', '-r300');
