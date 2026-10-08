clear; clc;
% Tiny dataset: 2 dark pixels and 2 bright pixels
pixels = [0.0 0.0 0.0;
          0.1 0.1 0.1;
          1.0 1.0 1.0;
          0.9 0.9 0.9];

% T1 - assign_clusters
centroids = [0 0 0; 1 1 1];
indices = assign_clusters(pixels, centroids);
assert(isequal(indices, [1; 1; 2; 2]));
disp('Test 1 passed: assign_clusters');

% T2 - update_centroids
new_centroids = update_centroids(pixels, indices, centroids);
expected = [0.05 0.05 0.05; 0.95 0.95 0.95];
assert(all(all(abs(new_centroids - expected) < 1e-10)));
disp('Test 2 passed: update_centroids');

% T3 - update_centroids keeps an empty cluster unchanged
centroids3 = [0 0 0; 1 1 1; 0.5 0.5 0.5];   % cluster 3 gets no pixels
new_centroids3 = update_centroids(pixels, indices, centroids3);
assert(isequal(new_centroids3(3, :), [0.5 0.5 0.5]));
disp('Test 3 passed: empty cluster');

% T4 - run_kmeans finds the two obvious groups
[final_centroids, final_indices] = run_kmeans(pixels, 2, 20);
assert(all(all(abs(sortrows(final_centroids) - expected) < 1e-10)));
assert(final_indices(1) == final_indices(2));
assert(final_indices(3) == final_indices(4));
assert(final_indices(1) ~= final_indices(3));
disp('Test 4 passed: run_kmeans');

% T5 - build_compressed_image has the right shape
img = build_compressed_image(centroids, indices, 2, 2);
assert(isequal(size(img), [2 2 3]));
disp('Test 5 passed: build_compressed_image');

% T6 - load_image (white 4x4 picture -> all values equal 1)
imwrite(uint8(255 * ones(4, 4, 3)), 'test_tmp.png');
[p, h, w] = load_image('test_tmp.png');
assert(h == 4 && w == 4 && isequal(size(p), [16 3]) && all(p(:) == 1));
delete('test_tmp.png');
disp('Test 6 passed: load_image');

disp('=== ALL TESTS PASSED ===');