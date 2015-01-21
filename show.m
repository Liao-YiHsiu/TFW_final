function [Y, freq_Y] = show(ti, t, y, sym, filled, zeroPd, magL, showF, shwPk)

   fs = 1/(t(2)-t(1));

   if ~exist('sym', 'var') || isempty('sym'), sym = false; end
   if ~exist('filled', 'var') || isempty('filled'), filled = false; end
   if ~exist('zeroPd', 'var') || isempty('zeroPd'), zeroPd = true; end
   if ~exist('showF', 'var') || isempty('showF'), showF = fs/2; end
   if ~exist('shwPk', 'var') || isempty('shwPk'), shwPk = false; end


   if size(t, 2) == 1
      t = t';
   end

   if size(y, 2) == 1
      y = y';
   end

   if size(t, 2) ~= size(y, 2)
      fprintf('size mismatch!!!\n');
      return;
   end

   figure
   subplot(2, 1, 1);

   if filled
      area(t, y);
   else
      plot(t, y);
   end
   title(ti, 'FontSize', 15);

   % window 
   %y = y .* gausswin(size(y, 2), 4)';
   if ~sym
      y = y .* gausswin(size(y, 2), 4)';
     % y = y .* blackman(size(y, 2))';
   end

   % do zero padding to get better resolution on frequency domain.
   if zeroPd
      n = pow2(nextpow2(size(y, 2)) + 2);
   else
      n = size(y,2);
   end
   Y = fftshift(fft(y, n));

   ang = unwrap(angle(Y));
   log_Y = log(Y.*conj(Y)/n);
   freq = (-n/2:n/2-1)*(fs/n);
   freq_Y = (-n/2:n/2-1)*(fs/n);


   if ~sym
      ang = ang(freq >= 0); 
      log_Y = log_Y(freq >= 0);
      freq = freq( freq >= 0);
   end


   % only show Y and freq in the showF
   log_Y = log_Y( freq < showF & freq > -showF);
   ang = ang( freq < showF & freq > -showF);
   freq = freq( freq < showF & freq > -showF);

   %ang = unwrap(angle(Y));

   subplot(2, 1, 2);
   if shwPk
      [pks, locs] = findpeaks(log_Y);
      plot(freq, log_Y, freq(locs), log_Y(locs), 'r*');
   else
      plot(freq, log_Y);
   end
   title('magnitude(log)', 'FontSize', 15);
   grid on;

   if exist('magL', 'var') & ~isempty('magL')
      ylim(magL);
   end


