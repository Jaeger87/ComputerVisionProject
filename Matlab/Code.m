clear all 
close all
clc


RGB = imread('test.JPG');

%figure
%imshow(RGB);
%title('Image in RGB Color Space');


YCBCR = rgb2ycbcr(RGB);

%figure
%imshow(YCBCR);
%title('Image in YCbCr Color Space');


Red = RGB(:,:,1);
Ravg = mean(Red(:));
Rmax = max(Red(:));
Green = RGB(:,:,2);
Gavg = mean(Green(:));
Gmax = max(Green(:));
Blu = RGB(:,:,3);
Bavg = mean(Blu(:));
Bmax = max(Blu(:));

L = YCBCR(:,:,1);
Lavg = mean(L(:));
Lmax = max(L(:));

Rmwsf = Lmax / Rmax;
Gmwsf = Lmax / Gmax;
Bmwsf = Lmax / Bmax;


Rawsf = Lavg / Ravg;
Gawsf = Lavg / Gavg;
Bawsf = Lavg / Bavg;