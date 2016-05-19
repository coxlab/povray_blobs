function [kernel, nx, ny] = gabor2(kernel_width, A, f, sigmax, sigmay, phi, orientation)

kernel = zeros(2*kernel_width+1);

[X,Y] = meshgrid(linspace(-0.5,0.5, 2*kernel_width+1), linspace(-0.5,.5, 2*kernel_width+1));

slope = tan(orientation);
Xprime = (slope .* X + Y) / sqrt(slope^2+1);
slope2 = tan(orientation + pi/2);
Yprime = (slope2 .* X + Y) / sqrt(slope2^2 + 1);

kernel = A * exp(-(Xprime./(sqrt(2)*sigmax)).^2 - (Yprime./(sqrt(2)*sigmay)).^2) .* cos(2*pi*f*Xprime + phi);

nx = f*sigmax;
ny = f*sigmay;

kernel = kernel ./ norm(reshape(kernel, [prod(size(kernel)) 1]));