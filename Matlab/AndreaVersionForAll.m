clear all
close all
clc

images = {'test.JPG','stella.JPG','scoglione.JPG', 'pompei2.JPG', 'pompei.JPG', 'pesce.JPG', 'nulla.JPG', 'fondpesc.JPG', 'fondale.JPG', 'celeste.JPG', 'bella.JPG'};
for i = 1:length(images)
    imgName = images{i};
    
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
    
    counterMod = 1;
    while Ravg < min([Bavg, Gavg])
        Red = Red + 1;
        if(mod(counterMod, 8) == 0)
            Green = Green + 1;
            Blu = Blu + 1;
        end
        Ravg = mean(Red(:));
        Gavg = mean(Green(:));
        Bavg = mean(Blu(:));
        counterMod = counterMod +1;
        disp('aumento rosso');
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
    
    Ravg = mean(RedNew(:));
    Gavg = mean(GreenNew(:));
    Bavg = mean(BluNew(:));
    counterMod = 1;
    while Ravg > mean([Bavg, Gavg]) - 10
        RedNew = RedNew - 3;
        if(mod(counterMod, 2) == 0)
            GreenNew = GreenNew - 4;
            BluNew = BluNew - 4;
        end
        Ravg = mean(RedNew(:));
        Gavg = mean(GreenNew(:));
        Bavg = mean(BluNew(:));
        counterMod = counterMod + 1;
        disp('tolgo rosso');
    end
    
    RGBNuova = cat(3, RedNew, GreenNew, BluNew);
    
    imwrite(RGBNuova,imgName + "Andrea.png");
end