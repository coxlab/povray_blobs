% ———————————————————————————————————————————————————————————————————
%
%                    CenterImageInFrame_call
%         
% ———————————————————————————————————————————————————————————————————
%
%
%  Center the image in its frame
%
%   CALLING FUNCTIONS:
%       - ResizeStimSetToMatchFrameBoundaries
%
%   Author: davide
%
% ———————————————————————————————————————————————————————————————————

function [img] = CenterImageInFrame_call(img)

% disp( '... in FindImageBoundingBox_call' );


% Image2Load = ['Stim_4.png'];
% [img map] = imread( Image2Load );
% figure;
% imshow(img);

FlagPlotBoundaries = 0;
[nrow ncol] = size(img);

% Find image boundaries
[col_bounds, row_bounds] = FindImageBoundingBox_call( img, FlagPlotBoundaries );

Dcols = col_bounds(1)-1 + ncol-col_bounds(2);
Drows = row_bounds(1)-1 + nrow-row_bounds(2);
Dcols_2 = floor(Dcols/2);
Drows_2 = floor(Drows/2);

% disp(['Frame in excess: columns = ', num2str(Dcols) ]);
% disp(['Frame in excess: rows = ', num2str(Drows) ]);

% SHift image in the center
if ~rem(Dcols,2)
    img = [zeros(nrow,Dcols_2), img(:, col_bounds(1):col_bounds(2)), zeros(nrow,Dcols_2)];
else
    img = [zeros(nrow,Dcols_2), img(:, col_bounds(1):col_bounds(2)), zeros(nrow,Dcols_2+1)];
end;
if ~rem(Drows,2)
    img = [zeros(Drows_2,ncol); img(row_bounds(1):row_bounds(2),:); zeros(Drows_2,ncol)];
else
    img = [zeros(Drows_2,ncol); img(row_bounds(1):row_bounds(2),:); zeros(Drows_2+1,ncol)];
end;



% figure;
% imshow(img);
% % Find image boundaries
% [col_bounds, row_bounds] = FindImageBoundingBox_call( img, FlagPlotBoundaries );
% 


