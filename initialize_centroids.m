function centroids = initialize_centroids(pixels, K)
  N = size(pixels, 1);

  random_order = randperm(N);
  chosen_positions = random_order(1:K);

  centroids = pixels(chosen_positions, :);

end