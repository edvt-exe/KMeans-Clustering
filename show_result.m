function show_result(original_image, compressed_image, K)
  figure('Name', 'K-Means Compressor', 'NumberTitle', 'off');

  % Left: the original image
  subplot(1, 2, 1);
  image(original_image);
  axis image;
  axis off;
  title('Original image');

  % Right: the compressed image
  subplot(1, 2, 2);
  image(compressed_image);
  axis image;
  axis off;
  title(sprintf('Compressed image (K = %d colors)', K));
end