# KMeans-Clustering

A small image compressor written in Octave. It reduces an image to K colors using the K-Means clustering algorithm, which I implemented from scratch without any built-in machine learning functions.

I built it to understand K-Means properly rather than just call a library function, so the code favors readability over speed.

## How it works

Every pixel is treated as a point in 3D space (its R, G and B values). K-Means then does the following:

1. Pick K random pixels as the starting centroids.
2. Assign every pixel to its nearest centroid (squared Euclidean distance).
3. Move each centroid to the mean of the pixels assigned to it.
4. Repeat steps 2 and 3 until the centroids stop moving or 20 iterations are reached.

In the output image, every pixel is replaced by the color of its centroid, so the result contains at most K different colors. Storing it only takes a small palette of K colors plus one index of ceil(log2(K)) bits per pixel, instead of 24 bits per pixel.

## Project structure

```
KMeans_Clustering/
├── main.m                      % command-line menu, entry point
├── load_image.m                % reads the image into an N x 3 pixel matrix
├── initialize_centroids.m      % picks K random pixels as starting centroids
├── assign_clusters.m           % assigns each pixel to its nearest centroid
├── update_centroids.m          % recomputes each centroid as a cluster mean
├── run_kmeans.m                % main K-Means loop
├── build_compressed_image.m    % rebuilds the image from the centroids
├── show_result.m               % original vs compressed, using subplot
└── test_kmeans.m               % tests on small hand-checked data
```

## Getting started

You need Octave (the code only uses basic functions, so it should also run in MATLAB, but I have only tested it in Octave).

```bash
git clone https://github.com/YOUR_USERNAME/KMeans_Clustering.git
cd KMeans_Clustering
octave --persist main.m
```

The program asks for two things:

- the image file name (the file must be in the same folder, for example `photo.jpg`)
- the number of colors K

When it finishes, it opens a window with the original image on the left and the compressed one on the right, and saves the result in the `compressed/` folder as `<image name>_K<K>.png`.

To run the tests:

```bash
octave --no-gui test_kmeans.m
```

## Results

Same photo, compressed with different values of K. The ratio is the theoretical size reduction, assuming 24 bits per pixel in the original and ignoring the palette, which is negligible for normal image sizes.

| K  | Bits per pixel | Theoretical ratio |
|----|----------------|-------------------|
| 2  | 1              | ~24x              |
| 3  | 2              | ~12x              |
| 4  | 2              | ~12x              |
| 10 | 4              | ~6x               |
| 16 | 4              | ~6x               |

**K = 2**

<img src="compressed/photo_K2.png" width="300" alt="K = 2 result">

**K = 3**

<img src="compressed/photo_K3.png" width="300" alt="K = 3 result">

**K = 4**

<img src="compressed/photo_K4.png" width="300" alt="K = 4 result">

**K = 10**

<img src="compressed/photo_K10.png" width="300" alt="K = 10 result">

**K = 16**

<img src="compressed/photo_K16.png" width="300" alt="K = 16 result">

Note that K = 3 and K = 4 both need 2 bits per pixel, so K = 4 gives better quality at the same size. The same goes for K = 10 and K = 16.

## Known limitations

- The starting centroids are random, so two runs on the same image can give slightly different results.
- K has to be chosen by hand.
- It is slow on large images (above roughly 2000 x 2000 pixels), especially in Octave.
- The compressed image is only saved as a normal PNG. The palette-plus-indices format described above is calculated, not actually written to disk.

## Possible improvements

- K-Means++ initialization, for more stable results between runs
- Running the algorithm several times and keeping the result with the lowest error
- A plot of the error per iteration
- An elbow-method plot to help choosing K
- Writing the real palette-plus-indices format to disk, to measure the actual file size
- Support for choosing the image through a file dialog instead of typing the name