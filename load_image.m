function [pixels, img_height, img_width] = load_image(file_name)
  img = imread(file_name);

  if ndims(img) == 2
    img = cat(3, img, img, img);
  end

  if size(img, 3) == 4
    img = img(:, :, 1:3);
  end

  if isa(img, 'uint16')
    max_value = 65535;
  else
    max_value = 255;
  end
  img = double(img) / max_value;

  img_height = size(img, 1);
  img_width  = size(img, 2);

  pixels = reshape(img, img_height * img_width, 3);

end