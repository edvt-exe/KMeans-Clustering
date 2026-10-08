clear; clc; close all;

disp('=====================================');
disp('   IMAGE COMPRESSOR - K-MEANS');
disp('=====================================');

% read the input from the user
image_name = input('Image file name (e.g. photo.jpg): ', 's');

if ~exist(image_name, 'file')
  disp('Error: the file does not exist in the current folder.');
  return;
end

K = input('Number of colors K (e.g. 16): ');

if isempty(K) || K < 1 || K ~= floor(K)
  disp('Error: K must be a natural number >= 1.');
  return;
end

max_iterations = 20;

% load the image as an N x 3 matrix (one pixel per row)
[pixels, img_height, img_width] = load_image(image_name);
N = size(pixels, 1);

if K > N
  disp('Error: K cannot be larger than the number of pixels.');
  return;
end

fprintf('\nImage loaded: %d x %d pixels (%d pixels in total)\n', ...
        img_height, img_width, N);
fprintf('Running K-Means with K = %d...\n\n', K);

% run the K-Means algorithm
[centroids, indices] = run_kmeans(pixels, K, max_iterations);

% build the compressed image
compressed_image = build_compressed_image(centroids, indices, ...
                                          img_height, img_width);

% simple compression statistics
original_bits   = N * 24;
compressed_bits = N * ceil(log2(K)) + K * 24;
ratio = original_bits / compressed_bits;
fprintf('\nTheoretical compression: about %.1f times smaller.\n', ratio);

% save the result and display it
output_name = sprintf('compressed_K%d.png', K);
imwrite(compressed_image, output_name);
fprintf('The compressed image was saved as: %s\n', output_name);

original_image = reshape(pixels, img_height, img_width, 3);
show_result(original_image, compressed_image, K);