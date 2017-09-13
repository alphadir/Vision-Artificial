clc
clear all
close all

%% Lectuta imagen
[file,root]=uigetfile('*.jpg','Selecciona Imagen');
IMA=imread(strcat(root,file));

%% Conversión imagen a escala de grises
GRIS=rgb2gray(IMA);
[NF,NC]=size(GRIS);

%% Umbral de detección
umbral =150;

binaria=GRIS>umbral;

%La dilatación se aplica siempre al tono de blanco por lo que se dilata el
%fondo blanco en esta imagen, haciendo nuestras imagenes en negro mas
%chicas y el fondo mas grande

elem_b=strel('disk',2);
dilatada=imdilate(binaria,elem_b);
erosionada=imerode(binaria,elem_b);

figure(1)
subplot(2,2,1), imshow(uint8(GRIS)), title('Gris Original')
subplot(2,2,2), imshow(binaria), title('Binaria')
subplot(2,2,3), imshow(erosionada), title('Erosionada')
subplot(2,2,4), imshow(dilatada), title('Dilatada')

bordes=dilatada-binaria;

%Con esta operacion nos aparece un borde dependiendo el tamaño de la
%mascara aplicada a la imagen con imdilate

figure(2)
imshow(bordes)