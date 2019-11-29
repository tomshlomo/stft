# stft
Matlab routines for efficient calculation of the Short Time Fourier Transform (STFT) and its inverse (ISTFT). The implementation is fully vectorised, and is faster than MATLAB's built-in function spectrogram. The code also supports multi-channel signals.

The ISTFT is calculated in the least-squares sense according to [1], so it has perfect reconstruction properties even if the window does not satisfy the constant overlap add condition (COLA).

Run "example.mlx" for a demonstration.

[1] Griffin, Daniel, and Jae Lim. "Signal estimation from modified short-time Fourier transform." IEEE Transactions on Acoustics, Speech, and Signal Processing 32.2 (1984): 236-243.
[![View Short Time Fourier Transform and its least squares inverse on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://www.mathworks.com/matlabcentral/fileexchange/73475-short-time-fourier-transform-and-its-least-squares-inverse)