N = 100;
t = -.25*N:1.25*N;
%t = -1:0.01:1;
empty = zeros(size(t));
mask = t >= 0 & t < N;

rect = empty;
rect(mask) = 1;

show('rectangular window', t, rect, true, true, true, [-30, 5]);
print('rect', '-dpng', '-r300');

ham = empty;
ham(mask) = hamming(sum(mask))';

show('hamming window', t, ham, true, true, true, [-30, 5]);
print('ham', '-dpng', '-r300');

black = empty;
black(mask) = blackman(sum(mask))';

show('blackman window', t, black, true, true, true, [-30, 5]);
print('black', '-dpng', '-r300');

gau = empty;
gau(mask) = gausswin(sum(mask), 4)';

show('gaussian window', t, gau, true, true, true, [-30, 5]);
print('gau', '-dpng', '-r300');

