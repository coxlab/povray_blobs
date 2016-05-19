% ######################################################################################################################
%
%                    Build_LowPassFiltered_Subsampled_Scaled_Images
%         
% ######################################################################################################################
%
%   This function loads image files containing either of two objects (the two blobs used ti trian the rats) at each of a
%   range of sizes and views (these images may have been created using the function "TransformAndAverageImages") and
%   then: 1) low pass filter them using a Gaussian filter in the frequency domain; and 2) downsample them to 2 pixels
%   per degree.
%
%
%   INPUTS:
%
%   CALLED FUNCTIONS:
%       - LowPassFilterImage
%
%   Example:
%       
%       >> Build_LowPassFiltered_Subsampled_Scaled_Images
%
%
% ######################################################################################################################


function Build_LowPassFiltered_Subsampled_Scaled_Images

% Filter parameters
DegsVertExt = 40;
% This gives a cutoff frequency of 0.4 cycles per deg (obviously, since we use a Gaussian filter in the frequency
% domain, frequncy larger than 0.4 still are present in the image, altough attenuated)
CutoffFreq = 0.4*DegsVertExt;   
FylterType = 'gaussian (ellipse)';
FlagPlotFilterShape = 0;
Mode = 'call';

% PathName = '../../images/Blobs_TrainingRatsD1D2/';
PathName = 'Blobs_1and2_views_sizes/';
RangeSize = 40:-5:15;
% RangeSize = [40];
ViewRange = [-60:15:60];
% ViewRange = [-60];

% Loop on the stimulus identity
for N = [1,2]
    
    % Loop on the views
    for v = ViewRange
        % Loop on sizes
        for s = RangeSize
        
            ImageName = ['Blob_N', num2str(N), '_CamRot_y', num2str(v), '_Size', num2str(s), '.png'];
            Img = imread([PathName,ImageName]);

            [I_blur] = LowPassFilterImage( ImageName, DegsVertExt, CutoffFreq, FylterType, FlagPlotFilterShape, Mode, Img );
            [m n] = size(I_blur);

            % Number of pixels per deg in the scaled version of the image that we want to build. NOTE: we want this to be at least
            % 2, so that the 1 cycle per deg frequency (limit of the rat's acuity) is not lost.
            NpixPerDeg_new = 2;
            m_new = NpixPerDeg_new * DegsVertExt;
            DegsPerPix = DegsVertExt/m;
            DegsHorizExt = DegsPerPix * n;
            n_new = NpixPerDeg_new * DegsHorizExt;

            I = imresize( I_blur, [m_new n_new]);
            I = uint8(I);
            
%             figure; imshow(I);
%             colormap(gray(256));
%             axis equal;
%             axis off;
            
            imwrite( I, [PathName, 'Blur_DwnSmp_Blob_N', num2str(N), '_CamRot_y', num2str(v), '_Size', num2str(s), '.png'] );
        
        end; %for s
    end; %for v

end; %for N























