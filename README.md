# stft
Matlab routines for efficient calculation of the Short Time Fourier Transform and its inverse. 
The implemenatation is fully vectorized, and is faster than MATLAB's built-in function spectrogram.
The implementation also supports multi-channel signals.

The ISTFT is calculated in the least-squares sense acording to [1], so it has perfect reconsturction properties even if the window does not satisfy the constant overlap add consitition (COLA).

Run "example.mlx" for a demonstration.

[1] Griffin, Daniel, and Jae Lim. "Signal estimation from modified short-time Fourier transform." IEEE Transactions on Acoustics, Speech, and Signal Processing 32.2 (1984): 236-243.
