function [S, f, t] = stft(x, window, hop, NFFT, fs)
% Short Time Fourier Transform of the signal x.
% The implementation is fully vectorized and supports multichannel signals.
%
% Inputs:
%   x           The time domain signal. must be either a column vector or a 2D array.
%               If x is a 2D array, the STFT is calculated for each column independently.
%   window      A vector containing the window function.
%               Default value is hann(128,'periodic').
%   hop         hop size
%   NFFT        Number of DFT points.
%               Default value is 2^nextpow2(length(window))
%   fs          Sample frequency. Doesn't affect S, only f and t.
%               Default value is 1.
% Outputs:
%   S           STFT array, with frequency across rows, and time across columns.
%               If x has multiple columms, than S(:,:,i) is the STFT of x(:,i).
%   f           Frequency vector. Same unit as fs.
%   t           Time vector (starting from 0). Same units as 1/fs.
%
% Please note that unlike MATLAB's builtin function spectrogram, this
% implementation of the STFT is causal. For example, if hop=1, then S(:,i) corresponds to a
% segment of x whos *last* index is i. More precisely:
% S(:,i,j) = fft(x(i-L+1:i,j).*window, NFFT)
% Where L = length(window), and x is zeropadded where neccessary.
% This defnition has several advantages over the more standard, anti-causal one.
% First, the inverse transform is more stable near the begining of the signal.
% Second, each frequency of the STFT can be regarded as the (resampled) 
% output of an FIR filter.
%
%
% Written by Tom Shlomo, 2019


%% default values
if nargin<2 || isempty(window)
    window = hann(128,'periodic');
end
windowLen = length(window);

if nargin<3 || isempty(hop)
    hop = max(1, round(windowLen/4));
end

if nargin<4 || isempty(NFFT)
    NFFT = 2^nextpow2(windowLen);
end

if nargin<5 || isempty(fs)
    fs = 1;
end

%% Padd with zeros from the left (for causality)
x = [zeros(windowLen-1,size(x,2)); x];

%% partition x to data segments
n = size(x,1);
I = 1:hop:n;
m = (0:windowLen-1)';
I = I+m;
x(end+1:I(end), :)=0;
I = I + reshape( (0:size(x,2)-1)*size(x,1) , 1, 1, [] );
x = x(I);

%% apply window function
x = x.*window(:);

%% FFT each segment
S = fft(x, NFFT, 1);

%% calculate frequency and time vectors
if nargout>=2
    f = (0:NFFT-1)'/NFFT * fs;
end
if nargout>=3
    t = (0:size(S,2)-1)'*hop/fs;
end

end