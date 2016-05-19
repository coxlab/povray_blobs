% ######################################################################################################################
%
%                    ProvaFiltri
%         
% ######################################################################################################################
%
%
% ######################################################################################################################

function ProvaFiltri

% % Build a one dimensional Gaussian frequency-response filter
% sigma = 5;
% f = -30:30;
% H1 = sqrt(2*pi) * sigma * normpdf( f, 0, sigma );
% H1 = normpdf( f, 0, sigma );
% 
% % Obtain the corresponding Gaussian 2d filter in the spatial domain
% h2 = ftrans2(H1)
% 
% % Obtain the frequency response of the filters in the 1D and 2D frequency domain
% [H1,w] = freqz(H1,1,64,'whole');
% % colormap(jet(64));
% plot(w/pi-1,fftshift(abs(H1)));
% figure;
% freqz2(h2,[32 32]);
% 
% size(h2)
% 
% I=imread('coins.png');
% I_blur = imfilter(I,h2,'replicate');
% figure; imshow(I)
% figure; imshow(I_blur)


% I=imread('coins.png');
PathName = '../../images/Blobs_TrainingRatsD1D2/';
I = imread([PathName,'Blob_N1_CamRot_y0.png']);
[m n] = size(I);
cutoff = 40

figure; image(I);
colormap(gray(256));
axis equal;
axis off;

n_2 = floor(n/2);
m_2 = floor(m/2);

% n_2 = min(m_2,n_2);
% m_2 = n_2;

u = -m_2:m_2;
v = -n_2:n_2;
% [U V] = meshgrid(u,v); %old
[U V] = meshgrid(v,u);
R = sqrt(U.^2 + V.^2);

% ########## Build grating with 1 cycle per deg spatial frequency ##########
Om = (2*pi)/(length(u)/40);
S = (1 + cos( Om * V )) * 128;
figure; mesh(U,V,S);
U(1:10,1:10)
size(U)
S = uint8(S);
figure; image(S);
colormap(gray(256));
imwrite( S, 'CosGrating_1cyclePerDeg.png', 'png' );


% FFT
F = fft2(I);
size(F);
F2 = fftshift(F);
% F3 = ifftshift(F2);
% 
% size(F2)
% 
% figure;
% imshow(log(abs(F3))); 
% 
% Si = real(ifft2(F3));
% figure; image(Si);





% Ideal Low-pass
% H = zeros(length(u), length(v));
% Iok = find(R < cutoff);
% H(Iok) = 1;

% Gaussian Low-pass
% sigma = cutoff;
% H = normpdf( R, 0, sigma);
% Norm1d = sum(sum(H))

% Gaussian Low-pass with different sigm along the axes
cutoff_x = (length(v)/length(u))*cutoff;
sigma_2d = [cutoff_x^2 0; 0 cutoff^2];
Ucol = reshape( U, length(u)*length(v), 1);
Vcol = reshape( V, length(u)*length(v), 1);
H = mvnpdf( [Ucol, Vcol], 0, sigma_2d);
H = reshape( H, length(u), length(v) );
Norm2d = sum(sum(H))


Norm = H(m_2,n_2);
H = H / Norm;

% figure;
% mesh(U,V,H);

figure;
contour(U,V,H);
axis equal;
% set(gca, 'xlim', [-50 50], 'ylim', [-50 50])

size(H)
size(F2)

% Filter in the Fourier domain
% P = F2 .* H;
P = F2 .* H(:,1:end-1);
P = ifftshift(P);
I_blur_fft = real(ifft2(P));
figure; image(abs(I_blur_fft));
colormap(gray(256));
axis equal;
axis off;
pix_max = max(max(I_blur_fft))
pix_min = min(min(I_blur_fft))

title(['Max = ', num2str(floor(pix_max)), '; Min = ', num2str(floor(pix_min))]);

return;


% figure;
% imshow(H);


h = fsamp2(H);

% h = fwind1(H,hamming(50))


% figure;
% mesh(h);
% size(h)
% m_2
% n_2


% % old meshgrid(u,v)
% mask_size = 50;
% h = h( n_2+1-mask_size:n_2+1+mask_size, m_2+1-mask_size:m_2+1+mask_size );
% size(h)


% new meshgrid(v,u)
mask_size = 50;
h = h( m_2+1-mask_size:m_2+1+mask_size, n_2+1-mask_size:n_2+1+mask_size );
size(h)


% figure;
% mesh(h);


Norm = sum(sum(h))
h = h/Norm;

figure;
mesh(h);



% [X Y] = meshgrid

% figure;
% freqz2(h,[32 32]);
I_blur = imfilter(S,h,'replicate');
figure; image(I_blur);
colormap(gray(255));

pix_max = max(max(I_blur))
pix_min = min(min(I_blur))

title(['Max = ', num2str(pix_max), '; Min = ', num2str(pix_min)]);

% 
% P = F2 .* H(:,1:end-1);
% I_blur_fft = ifft2(P);
% figure; image(abs(I_blur_fft));
% 



