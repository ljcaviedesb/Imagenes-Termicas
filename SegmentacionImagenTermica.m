% Imagen térmica segmentada
%% Análisis principal de cualquier imagen
clc; clear;
% Lectura de la imagen térmica y sus características
Ii = imread('andres4.jpg');subplot(1,3,1);imshow(Ii);title('Imagen sin filtro IR(Ii)');
Ic=imread('andres1.jpg');subplot(1,3,2);imshow(Ic);title('Imagen con filtro IR(Ic)');
Iig = rgb2gray(Ii); Icg = rgb2gray(Ic);
II = imsubtract(Ii,Ic);
I = imsubtract(Iig,Icg); subplot(1,3,3);imshow(I);title('Imagen resta Ii-Ic GRAY');
%% Recortar rostro de una imágen
% detector de objetos
DetectorRostro = vision.CascadeObjectDetector('FrontalFaceCART');   
BBOX = step(DetectorRostro,Is)

% Detecta rostros
posicion = step(DetectorRostro, Is)

%r = centerCropWindow2d(size(Reff),posicion);
I = imcrop(Is,BBOX(1,:));
figure;imshow(I)
%% 
improfile
 [x,y] = size(I);
 X=1:x;
 Y=1:y;
 [xx,yy]=meshgrid(Y,X);
 i = im2double(I);
 figure; mesh(xx,yy,i);title('mesh'); 
 colorbar
%figure; imshow(i);title('Imagen resta Ii-Ic DOUBLE');
%figure;imhist(I);title('imhist(Irg)')
 

 %% Filtros de colores
 % NO ES NECESARIO CORRER ESTA PARTE DEL CODIGO
  % utilizo la función colorfilter creada para filtrar el color rojo, azul y
  % verde de cada imágen
  %subplot(3,1,1)
 % figure;
 %Ir = colorfilter(II,'r'); title('Icolor filtro rojo')% filtro de la imagen a color
 %subplot(3,1,2)
%  figure;
% Ig = colorfilter(II,'g');title('Icolor filtro verde')
  %subplot(3,1,3)
%  figure;
% Ib = colorfilter(II,'b');title('Icolor filtro azul')
%%  Remover el ruido preservando los detalles importantes de la imagen

whos I
% Computar el rango de la matriz para ver el rango de temperatura de la imágen
rango = [median(I(:)) max(I(:))];

ValorSuave = 0.01*diff(rango).^2;
%Como X=RANGO es un vector de longitud m=2, Y=diff(X) devuelve un vector de
%longitud m-1=2-1=1. Los elementos de Y son las diferencias entre los 
%elementos adyacentes de X.
%Y = [X(2)-X(1) X(3)-X(2) ... X(m)-X(m-1)]
J = imguidedfilter(I,'DegreeOfSmoothing', ValorSuave);
%IMGUIDEDFILTER filtra la imagen utilizando pares nombre-valor para 
%controlar los aspectos del filtrado guiado
%DEGREEOFSMOOTHING es un parámetro que controla el suavizado  y es
%dependiente del rango de la u=imagen
figure; imshow(J,[]);colormap(gca,hot);

% % title('Imagen Filtrada Guiada')
%% Determinar los valores limites para usar en la segmentación
umbral = multithresh(J,1)

% el metodo Otsu es para segmentar
% Devuelve un vector de 1 por N que contiene los valores de umbral 
%utilizando el método de Otsu.threshN
%
%Umbral de la imagen utilizando los valores devueltos por multithresh. 
%Los valores umbral son de los valores devueltos por UMBRAL: x y grados Celsius. 
%El primer umbral separa la intensidad de fondo de la persona y el segundo 
%umbral separa a la persona del objeto caliente. Segmenta la imagen y rellena agujeros
%% 
L = imquantize(J,umbral);
L = imfill(L);
subplot(2,2,1)
imshow(label2rgb(L))
title('Matrix de 3-niveles Otsu')

%% Definir regiones de temperatura
props = regionprops(L,I,{'Area','BoundingBox','MeanIntensity','Centroid'})
% REGIONPROPS Devuelve mediciones para el conjunto de propiedades
%especificado por cada región etiquetada de la imagen
%
% Encuentra el índice de la región de fondo
[~,idx] = max([props.MeanIntensity]);

subplot(2,2,3)
imshow(I,[])
colormap(gca,hot)
title('Regiones segmentadas con temperatura media')
%% 
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