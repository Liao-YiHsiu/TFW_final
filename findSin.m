function [mask, value, F, T] =  findSin(x, fs)

   NSR = -4;
   N = round(0.02 * fs);
   [S F T] = spectrogram(x, gausswin(N, 4), round(N/2), pow2(nextpow2(N)+2), fs);
   
   imagesc( T, F, log(abs(S)) ); %plot the log spectrum
   set(gca,'YDir', 'normal');
   hold on;

   log_S = log(abs(S));

   thres_S = max(max(log_S)) + NSR;
   
   %mask = zeros(size(S));
   mask = false(size(S));
   value = zeros(size(S));

   for j = 1:size(log_S, 2)
      [pks, locs] = findpeaks(log_S(:, j));
      %locs = locs(pks > thres_S);
      tmp = locs(pks > thres_S);
      mask(tmp , j) = true;
      value(tmp, j) = S(tmp, j);
   end

   mask = bwareaopen(mask, 6, 8);
   for j = 1:size(mask, 2)
      if sum(mask(:, j)) ~= 0
         plot(T(j), F(mask(:, j)), 'k.');
      end
   end

   %imagesc(T, F, 255*bwareaopen(mask, 6, 8))

   hold off;
end
