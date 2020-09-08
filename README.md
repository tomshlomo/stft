# stft
Matlab routines for efficient calculation of the Short Time Fourier Transform (STFT) and its inverse (ISTFT) in the least squares sense. The implementation is fully vectorised, and is faster than MATLAB's built-in function spectrogram. The code also supports multi-channel signals.

It is common in signal processing to manipulate a signal after it has been transformed using the STFT.
In many cases, it is desired to transform the manipulated STFT array back into the time domain.
However, since the STFT is often not surjective, it might be the case that there is no signal whose STFT is equal to the manipulated STFT.
In such cases, we can find the signal whose STFT is as close as possible, in the least squares sense, to the manipulated STFT.
The algorithm to do so efficiently is described in [1].

Note that the least squares ISTFT has perfect reconstruction properties even if the window does not satisfy the constant overlap add condition (COLA)
(meaning: istft(stft(x))=x for any x).

Run "example.mlx" for more details and a demonstration.

[1] Griffin, Daniel, and Jae Lim. "Signal estimation from modified short-time Fourier transform." IEEE Transactions on Acoustics, Speech, and Signal Processing 32.2 (1984): 236-243.
[![View Short Time Fourier Transform and its least squares inverse on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://www.mathworks.com/matlabcentral/fileexchange/73475-short-time-fourier-transform-and-its-least-squares-inverse)