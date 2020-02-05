clear all 
close all
clc

imgName = 'pompei.JPG';

RGB = imread(imgName);

%figure
%imshow(RGB);
%title('Image in RGB Color Space');

Green = RGB(:,:,2);

Blu = RGB(:,:,3);

Red = RGB(:,:,1);

Ravg = mean(Red(:));
Gavg = mean(Green(:));
Bavg = mean(Blu(:));


while Ravg < mean([Bavg, Gavg]) 
    Red = Red + 9;
    Green = Green + 1;
    Blu = Blu + 1;
    Ravg = mean(Red(:));
    Gavg = mean(Green(:));
    Bavg = mean(Blu(:));
end
Rmax = max(Red(:));
Gmax = max(Green(:));
Bmax = max(Blu(:));


YCBCR = rgb2ycbcr(cat(3, Red, Green, Blu));

L = YCBCR(:,:,1);
Lavg = mean(L(:));
Lmax = max(L(:));

CB = YCBCR(:,:,2);
CBavg = mean(CB(:));
CBmax = max(CB(:));

CR = YCBCR(:,:,3);
CRavg = mean(CR(:));
CRmax = max(CR(:));

Rmwsf = double(Lmax) / double(Rmax);
Gmwsf = double(Lmax) / double(Gmax);
Bmwsf = double(Lmax) / double(Bmax);


Rawsf = Lavg / Ravg;
Gawsf = Lavg / Gavg;
Bawsf = Lavg / Bavg;

%Rawsf = 1.4;

if(Rawsf > Gawsf && Rawsf > Bawsf)
    disp('rosso')
    Gfac = Gmwsf / Rmwsf;
    Bfac = Bmwsf / Rmwsf;
    CCF = (Gfac + Bfac) / 2;
end

if(Gawsf > Rawsf && Gawsf > Bawsf)
    disp('verde')
    Rfac = Rmwsf / Gmwsf;
    Bfac = Bmwsf / Gmwsf;
    CCF = (Rfac + Bfac) / 2;
end

if(Bawsf > Rawsf && Bawsf > Gawsf)
    disp('blu')
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

imwrite(RGBNuova,imgName + "Andrea.png");