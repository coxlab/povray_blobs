% ##########################################################################################################—————————————
% —————————————————
%
%                    ResizeStimSetToMatchFrameBoundaries
%         
% ##########################################################################################################————————————
% —
% —————————————————————————
%  Load a set of images, center them in the middle of the frame, sum all the images in a set, find the boundaries of
%  the resulting "sum" image, then crop each image to these boundaries and save the resulting images in a uder define
%  folder. NOTE: the code has been tested only with squared images (smae # columns and rows).
%
%   Inputs:
%       - BaseName: prefix of the file names containing the images (without image number and wothout '_'
%       - StartIdx: index of the first image
%       - EndIdx: index of the last image
%       - OutputDir: name of the folder in which the new cropped images must be saved
%       - StartIdxNew: index of the first image in the new set (in case you want to renumber the images)
%
%   Example: 
%           >> ResizeStimSetToMatchFrameBoundaries( 'Stim', 0, 22, 'CropImages', 19 );
%
%   Author: davide
%
%   NOTE:   for the program to work the images must be grayscale !!!!!
%
% ##########################################################################################################————————————
% —

function ResizeStimSetToMatchFrameBoundaries( BaseName, StartIdx, EndIdx, OutputDir, StartIdxNew )

disp(' ');
FlagPlotBoundaries = 0;

% #######################################################################
% Find the boundaries of the image resulting from averaging all views of
% both stimuli
% #######################################################################
IdxImg = 1;
% Loop on all stimuli
for StimIdx = [0:22, 41:57]; %StartIdx:EndIdx
    
    Image2Load = [BaseName, '_', num2str(StimIdx), '.png'];
    [img map] = imread( Image2Load );
    
    % Center each image in its frame
    [img] = CenterImageInFrame_call(img);

    % Build stack matrix with all transformaitons
    img_stack(IdxImg,:,:) = img;

    IdxImg = IdxImg+1;
end; %for StimIdx

%  img_av = uint8( squeeze( mean(img_stack,1) ) );
img_av = uint8( squeeze( sum(img_stack,1) ) );
figure;
imshow(img_av);
map=gray(256);
colormap(map);
% title('Average image');
title('Sum image');

% SIze of each image
[nrow ncol] = size(img);

% Find boundaries of the sum image
[col_bounds, row_bounds] = FindImageBoundingBox_call( img_av, FlagPlotBoundaries );


plot( [col_bounds(1) col_bounds(1)], [0 nrow], 'r');
plot( [col_bounds(2) col_bounds(2)], [0 nrow], 'r');
plot( [0 ncol], [row_bounds(1) row_bounds(1)], 'g');
plot( [0 ncol], [row_bounds(2) row_bounds(2)], 'g');


% If the frame is square, make sure to keep it square (same rows and cols)
if nrow == ncol
    Pix2Cut = min( [col_bounds(1), ncol-col_bounds(2)+1, row_bounds(1), nrow-row_bounds(2)+1] );
    col_bounds(1) = Pix2Cut;
    col_bounds(2) = ncol-Pix2Cut+1;
    row_bounds(1) = Pix2Cut;
    row_bounds(2) = nrow-Pix2Cut+1;
else
    Pix2Cut_col = min( [col_bounds(1), ncol-col_bounds(2)+1] );
    Pix2Cut_row = min( [row_bounds(1), nrow-row_bounds(2)+1] );
    col_bounds(1) = Pix2Cut_col;
    col_bounds(2) = ncol-Pix2Cut_col+1;
    row_bounds(1) = Pix2Cut_row;
    row_bounds(2) = nrow-Pix2Cut_row+1;
end;

% #######################################################################
% Crop each image using the boundaries obtained above
% #######################################################################
xmin = col_bounds(1)-2;
ymin = row_bounds(1)-2;
width = col_bounds(2) - col_bounds(1) +4;
height = row_bounds(2) - row_bounds(1) +4;
rect = [xmin ymin width height];

mkdir(OutputDir);
NewStimIdx = StartIdxNew;
% Loop on all stimuli
for StimIdx = [0:22, 41:57]; %StartIdx:EndIdx

    Image2Load = [BaseName, '_', num2str(StimIdx), '.png'];
    [img map] = imread( Image2Load );

    % Center the image in its frame
    [img] = CenterImageInFrame_call(img);
    
    img_crop = imcrop(img,rect);
    OutName = [BaseName, '_', num2str(NewStimIdx), '.png'];
    h_f = figure;
    imshow(img_crop);
    imwrite( img_crop, [OutputDir,'/',OutName], 'png' ); 

    disp(['Image ', Image2Load, ' cropped and saved as ', [OutputDir,'/',OutName] ]);
    NewStimIdx = NewStimIdx+1;
    close(h_f);

end; %for StimIdx





