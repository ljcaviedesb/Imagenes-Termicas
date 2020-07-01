%% RED
Im_led_red = imread('r.JPG');
I_red = imshow(Im_led_red);
 improfile
 [xr,yr] = size(I_red);
 Xr=1:xr;
 Yr=1:yr;
 [xxr,yyr]=meshgrid(Yr,Xr);
 ired = im2double(I_red);
 print -djpeg Profile_red.jpg

%% GREEN
Im_led_green = imread('g.JPG');
I_green = imshow(Im_led_green);
 improfile
 [xg,yg] = size(I_green);
 Xg=1:xg;
 Yg=1:yg;
 [xxg,yyg]=meshgrid(Yg,Xg);
 igreen = im2double(I_green);
 print -djpeg Profile_green.jpg

%% BLUE
Im_led_blue = imread('b.JPG');
I_blue = imshow(Im_led_blue);
 improfile
 [xb,yb] = size(I_blue);
 Xb=1:xb;
 Yb=1:yb;
 [xxb,yyb]=meshgrid(Yb,Xb);
 iblue = im2double(I_blue);
 print -djpeg Profile_blue.jpg