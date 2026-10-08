function indices = assign_clusters(pixels, centroids)

  N = size(pixels, 1);
  K = size(centroids, 1);

  smallest_distance = inf(N, 1);
  indices = ones(N, 1);

  for k = 1:K
    difference = pixels - repmat(centroids(k, :), N, 1);

    distance = sum(difference .^ 2, 2);

    % Pixels for which centroid k is closer than any centroid checked so far
    is_closer = distance < smallest_distance;

    % Update only those pixels
    indices(is_closer) = k;
    smallest_distance(is_closer) = distance(is_closer);
  end

end