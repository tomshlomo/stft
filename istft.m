function [x, k] = istft(S, window, hop, symFlag)
% Inverse Short Time Fourier Transform in the least squares sense.
% Given an STFT array S, this function finds x such that
% norm( S - stft(x, window, hop, size(S,1)) , 'fro' )
% is minimized.
% 
% The implementation is fully vectorized and supports multichannel signals.
%
% Inputs:
%   S - STFT array, with frequency along rows and time across columns.
%       If size(S,3) > 1, the ISTFT is performed independently on each layer.
%   window - a vector containing the window function.
%   hop - a positive integer describing the hop size.
%   symFlag (optional) - frequency symmetry type, specified as 'nonsymmetric' (default) or 'symmetric'. Same as symFlag of MATLAB's built-in ifft.
%                        Set as 'symmetric' if x is expected to be real.
% Outputs:
%   x - a time domain signal. For 3D S, the the i'th column of x if the ISTFT of S(:,:,i).
%   k - a scalar describing the instability of the inverse transform. It depends only on the window and hop size.
%       The minimum value is 1, which means the most stable. 
%       k=1 is achived for windows and hop sizes whos square value satisfy the COLA (Constant Overlap Add) condition.

%% defauls
if nargin<4
    symFlag = 'nonsymmetric';
end

%% Name some dimensions
N = size(S,2);
L = length(window);
Q = size(S,3);
T = L + hop*(N-1);

%% IFFT to obtain segemnts
y = ifft(S, [], 1, symFlag);
y(L+1:end,:,:) = []; % this is for case where NFFT is larger than the window's length

%% Weighted overlap add
y = y.*window(:); % apply weights
I = (1:L)' + hop*(0:N-1) + reshape( (0:Q-1)*T, 1, 1, [] ); % calculate subs for accumarray
x = reshape( accumarray(I(:), y(:)), [], Q ); % overlap-add

%% Least-squares correction
L2 = ceil(L/hop)*hop; 
window(end+1:L2) = 0; % zero pad window to be an integer multiple of hop
J = mod( (1:hop:L2)' + (0:hop-1) -1, L2 ) + 1;
denom = sum(window(J).^2, 1)';
if nargout==2
    k = max(denom)/min(denom);
end
denom = repmat(denom, ceil(T/hop), 1);
denom(T+1:end) = [];
x = x./denom;

%% delete the first L-1 rows of x
x(1:L-1, :) = [];

end