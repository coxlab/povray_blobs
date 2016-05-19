% ######################################################################################################################
%
%                    LowPassFilterImage
%         
% ######################################################################################################################
%
%   This function low pass filter an input image, using 3 possible different filter types chosen by the user. It also
%   allows testing if the filter works, by applying it to a grating rather than to an image. The function is meant to
%   test how images can be seen by rats given their low acuity.
%
%   NOTE: this function works with the data collected using the new training stimuli (i.e., the blobs) that allow also
%   rotations in depth.
%
%   INPUTS:
%       - ImageName: name of the image to filter. NOTE: this function for images in a path that is relative to its
%           location. therefore, the function should always be run from its folder.
%       - DegsVertExt: size (in degrees of visual angle) of the vertical dimension of the image 
%       - CutoffFreq: cutoff frequency of the filter. For the ideal filter this is the edge (excluded) of the boxcar
%           (actually circular) frequency response function. For the Gaussian filters, this is sigma (along the vertical
%           dimension in the case of the elipsoidal Gaussian)
%       - FylterType: choose the type of filter to use: 'ideal', 'gaussian (circle)', 'gaussian (ellipse)'
%       - FlagPlotFilterShape: if = 1, plot the shape of the filter in the frequncy domain as mesh and a countour plot
%       - Mode: if it is = 'test', build a grating of 1 cycle per deg frequency and apply the filter to the grating
%           instead than to the input image). If it is 'call', the function expect that another calling function has
%           passed it an image to filter instead of the file "ImageName"
%
%   CALLED FUNCTIONS:
%       - 
%
%   CALLING FUNCTIONS:
%       - LowPassFilterImage

%   Example:
%
%       1) To filter an image
%       >> LowPassFilterImage( ImageName, 40, 0.4*40, 'gaussian (ellipse)', 0, 'filter' )
%
%       2) To test the filter
%       >> LowPassFilterImage( ImageName, 40, 0.4*40, 'gaussian (ellipse)', 0, 'test' )
%
% ######################################################################################################################

function [I_blur] = LowPassFilterImage( ImageName, DegsVertExt, CutoffFreq, FylterType, FlagPlotFilterShape, Mode, Img )

FlagPlot = 1;
if strcmp( Mode, 'call' )
    I = Img;
    FlagPlot = 0;
    FlagPlotFilterShape = 0;
else
    PathName = '../../images/Blobs_TrainingRatsD1D2/';
    I = imread([PathName,ImageName]);
end;
[m n] = size(I);


% If the number of rows or column is even, add one strip of black pixels
if ~rem(m,2)
    I(m+1,:) = 0;
end;
if ~rem(n,2)
    I(:,n+1) = 0;
end;
[m n] = size(I);

% Build meshgrid (with the same size of the image) over which the filter (in the frequency domain) will be built
n_2 = floor(n/2);
m_2 = floor(m/2);
u = -m_2:m_2;
v = -n_2:n_2;
[U V] = meshgrid(v,u);
R = sqrt(U.^2 + V.^2);

% ============ Operating mode =============

% Build a grating with 1 cycle per deg spatial frequency and use it to replace the image
if strcmp( Mode, 'test' )
    Om = (2*pi)/(length(u)/DegsVertExt);
    I = (1 + cos( Om * V )) * 128;
    figure; mesh(U,V,I);
    I = uint8(I);
end;

% Show image
if FlagPlot
    figure; image(I);
    colormap(gray(256));
    axis equal;
    axis off;
end;

% Compute FFT of the image
F = fft2(I);
size(F);
F = fftshift(F);

% ============ Decide the filter to use =============

% Ideal Low-pass (circle in the 2d frequency space)
% NOTE: since this is a circle (the radius is the same in both dimensions), the CutoffFreq frequncy is the correct one
% only along the vertical axis, but not necessarly along the horizontal axis (if the image is not square)
if strcmp( FylterType, 'ideal' )
    H = zeros(length(u), length(v));
    Iok = find(R < CutoffFreq);
    H(Iok) = 1;
    
% Gaussian (circular: same radius along both dimensions) Low-pass
% NOTE: since this is a circle (the radius is the same in both dimensions), the CutoffFreq frequncy is the correct one
% only along the vertical axis, but not necessarly along the horizontal axis (if the image is not square)
elseif strcmp( FylterType, 'gaussian (circle)' )
    sigma = CutoffFreq;
    H = normpdf( R, 0, sigma);
    Norm1d = sum(sum(H))

% Gaussian Low-pass with different sigm along the axes
% NOTE: this correctly achieve the same CutoffFreq frequency along both axes!
elseif strcmp(FylterType, 'gaussian (ellipse)')
    CutoffFreq_x = (length(v)/length(u))*CutoffFreq;
    sigma_2d = [CutoffFreq_x^2 0; 0 CutoffFreq^2];
    Ucol = reshape( U, length(u)*length(v), 1);
    Vcol = reshape( V, length(u)*length(v), 1);
    H = mvnpdf( [Ucol, Vcol], 0, sigma_2d);
    H = reshape( H, length(u), length(v) );
end; %if strcmp

% Normalize the peak of the filter to 1
Norm = H(m_2,n_2);
H = H / Norm;

% Plot the shape of the filter in the frequency domain
if FlagPlotFilterShape
    figure;
    mesh(U,V,H);
    figure;
    contour(U,V,H);
    axis equal;
end;

% Perform filtering in the Fourier domain
P = F .* H;
P = ifftshift(P);
I_blur = real(ifft2(P));

if FlagPlot
    figure; image(I_blur);
    colormap(gray(256));
    axis equal;
    axis off;
    pix_max = max(max(I_blur));
    pix_min = min(min(I_blur));
    title(['Max = ', num2str(floor(pix_max)), '; Min = ', num2str(floor(pix_min))]);
end

return;



