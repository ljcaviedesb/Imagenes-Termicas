%% Imagen térmica segmentada
% Análisis principal de cualquier imagen
clc; clear;
% Lectura de la imagen térmica y sus características
Img_con_filtro = input('Ingrese el nombre de la imagen tomada con el filtro IR','s')
Img_sin_filtro = input('Ingrese el nombre de la imagen tomada sin el filtro IR','s')
Ii = imread(Img_sin_filtro);subplot(2,2,1);imshow(Ii);title('Imagen sin filtro IR(Ii)');
Ic=imread(Img_con_filtro);subplot(2,2,2);imshow(Ic);title('Imagen con filtro IR(Ic)');
% Resta de las imágenes en RGB
Irgb = imsubtract(Ii,Ic); subplot(2,2,3);imshow(Irgb);title('Imagen resta Ii-Ic RGB');
%% Recortar área a analizar
[I_cut_rgb, rect] = imcrop(Irgb);
subplot(2,2,4);imshow(I_cut_rgb);title('Imagen recortada');
print -djpeg ImagenesIniciales_fig1.jpg
%% Perfil de intensidad
 improfile
 [x,y] = size(I_cut_rgb);
 X=1:x;
 Y=1:y;
 [xx,yy]=meshgrid(Y,X);
 i = im2double(I_cut_rgb);
 print -djpeg Profile_fig2.jpg
 %% Segmentación para medición de temperatura
whos i
i = rgb2gray(i)
whos i
% Computar el rango de la matriz para ver el rango de temperatura de la imágen
rango = [median(i(:)) max(i(:))];

ValorSuave = 0.01*diff(rango).^2;
%Como X=RANGO es un vector de longitud m=2, Y=diff(X) devuelve un vector de
%longitud m-1=2-1=1. Los elementos de Y son las diferencias entre los 
%elementos adyacentes de X.
%Y = [X(2)-X(1) X(3)-X(2) ... X(m)-X(m-1)]
J = imguidedfilter(i,'DegreeOfSmoothing', ValorSuave);
%IMGUIDEDFILTER filtra la imagen utilizando pares nombre-valor para 
%controlar los aspectos del filtrado guiado
%DEGREEOFSMOOTHING es un parámetro que controla el suavizado  y es
%dependiente del rango de la u=imagen
figure(3); imshow(J,[]);colormap(gca,hot);

% % title('Imagen Filtrada Guiada')
% Determinar los valores limites para usar en la segmentación
umbral = multithresh(J,1);

% el metodo Otsu es para segmentar
% Devuelve un vector de 1 por N que contiene los valores de umbral 
%utilizando el método de Otsu.threshN
%
%Umbral de la imagen utilizando los valores devueltos por multithresh. 
%Los valores umbral son de los valores devueltos por UMBRAL: x y grados Celsius. 
%El primer umbral separa la intensidad de fondo de la persona y el segundo 
%umbral separa a la persona del objeto caliente. Segmenta la imagen y rellena agujeros
figure(4);
L = imquantize(J,umbral);
L = imfill(L);
subplot(2,2,1)
imshow(label2rgb(L))
title('Matrix de 2-niveles Otsu')

% Definir regiones de temperatura
props = regionprops(L,i,{'Area','BoundingBox','MeanIntensity','Centroid'});
% REGIONPROPS Devuelve mediciones para el conjunto de propiedades
%especificado por cada región etiquetada de la imagen
%
% Encuentra el índice de la región de fondo
[~,idx] = max([props.MeanIntensity]);

subplot(2,2,3)
imshow(i,[])
colormap(gca,hot)
title('Regiones segmentadas con temperatura media')
% 
for n = 1:numel(props) %NUMEL numero de elementos de la matriz
    % si la imágen no tiene fondo
    if n ~= idx
        % Draw bounding box around region
       rectangle('Position',props(n).BoundingBox,'EdgeColor','c')
       
       % Draw text displaying mean temperature in Celsius
       T = [num2str(props(n).MeanIntensity,3) ' \circ C'];
       text(props(n).Centroid(1),props(n).Centroid(2),T,...
           'Color','c','FontSize',15)
    end
end
print -djpeg Imagen_Segmentada_fig3.jpg