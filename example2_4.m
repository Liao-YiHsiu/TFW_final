%[a1 fs] = wavread('harpsi-cs.wav');
[a1 fs] = wavread('piano.wav');

x = a1(:, 1)';

[mask, value, F, T] = findSin(x, fs);
print('sinPeak', '-dpng', '-r300');

