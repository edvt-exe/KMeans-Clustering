function new_centroids = update_centroids(pixels, indices, old_centroids)

  K = size(old_centroids, 1);

  % Start from the old centroids, so an empty cluster stays unchanged
  new_centroids = old_centroids;

  for k = 1:K
    % Select only the pixels assigned to cluster k
    cluster_pixels = pixels(indices == k, :);
    pixel_count = size(cluster_pixels, 1);

    % If the cluster has pixels, the new centroid is their mean: sum of the colors / number of pixels, separately for R, G, B
    if pixel_count > 0
      new_centroids(k, :) = sum(cluster_pixels, 1) / pixel_count;
    end
  end

end