clear all 
close all
clc

imgName = 'nulla.JPG';
RGB = imread(imgName);

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

Rmwsf = double(Lmax) / double(Rmax);
Gmwsf = double(Lmax) / double(Gmax);
Bmwsf = double(Lmax) / double(Bmax);


Rawsf = Lavg / Ravg;
Gawsf = Lavg / Gavg;
Bawsf = Lavg / Bavg;


if(Rawsf > Gawsf && Rawsf > Bawsf)
    Gfac = Gmwsf / Rmwsf;
    Bfac = Bmwsf / Rmwsf;
    CCF = (Gfac + Bfac) / 2;
end

if(Gawsf > Rawsf && Gawsf > Bawsf)
    Rfac = Rmwsf / Gmwsf;
    Bfac = Bmwsf / Gmwsf;
    CCF = (Rfac + Bfac) / 2;
end

if(Bawsf > Rawsf && Bawsf > Gawsf)
    Rfac = Rmwsf / Bmwsf;
    Gfac = Gmwsf / Bmwsf;
    CCF = (Rfac + Gfac) / 2;
end

Rgf = CCF * Rawsf * Rmwsf;
Ggf = CCF * Gawsf * Gmwsf;
Bgf = CCF * Bawsf * Bmwsf;

RedNew = Red * Rgf;
GreenNew = Green * Ggf;
BluNew = Blu * Bgf;

RGBNuova = cat(3, RedNew, GreenNew, BluNew);

figure
imshow(RGBNuova);
title('Final result');

imwrite(RGBNuova,imgName + "Indiani.png");