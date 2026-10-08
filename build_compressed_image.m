function img = build_compressed_image(centroids, indices, img_height, img_width)
  compressed_pixels = centroids(indices, :);

  % Restore the image shape: from (N x 3) back to (height x width x 3)
  img = reshape(compressed_pixels, img_height, img_width, 3);

end