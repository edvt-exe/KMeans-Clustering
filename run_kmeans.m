function [centroids, indices] = run_kmeans(pixels, K, max_iterations)

  % initial centroids
  centroids = initialize_centroids(pixels, K);

  for iteration = 1:max_iterations

    %each pixel chooses its closest centroid
    indices = assign_clusters(pixels, centroids);

    % move the centroids to the mean of their pixels
    new_centroids = update_centroids(pixels, indices, centroids);

    % How far did the centroids move in this iteration
    shift = max(abs(new_centroids(:) - centroids(:)));
    centroids = new_centroids;

    fprintf('Iteration %2d / %d - maximum shift: %.6f\n', ...
            iteration, max_iterations, shift);

    % Stopping condition: the centroids practically stopped moving
    if shift < 0.0001
      disp('The algorithm converged.');
      break;
    end

  end

  % Final assignment with the final centroids, so the image is consistent
  indices = assign_clusters(pixels, centroids);

end