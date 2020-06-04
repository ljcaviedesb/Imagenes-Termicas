clc;
clear all;
B=imread('andresinfra.jpg');
A=imread('andrescolor.jpg');
B = rgb2gray(B);
A = rgb2gray(A);
I=imsubtract(A,B);
imshow(I,[]);
%improfile

[x,y]=size(I);
X=1:x;
Y=1:y;
[xx,yy]=meshgrid(Y,X);
i=im2double(I);
figure;mesh(xx,yy,i);
colorbar
figure;imshow(i)