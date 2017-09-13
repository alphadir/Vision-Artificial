% Negativo 1a1
% Flores Numa Jefte Allfadir
% 2011640201

clc
clear all
close all

%% Lectuta imagen
[file,root]=uigetfile('*.jpg','Selecciona Imagen');
IMA=imread(strcat(root,file));

%%  Conversión a gris
GRIS=double(rgb2gray(IMA));

%% Sacar tamaño a la imagen
[NF,NC]=size(GRIS);

%% Función de transformación
%T=255-GRIS;

%% Barrido imagen
IMA2=zeros(NF,NC);
for i=1:NF
    for j=1:NC
        IMA2(i,j)=255-(GRIS(i,j));
    end
end

subplot(1,2,1), imshow(GRIS/255)
subplot(1,2,2), imshow(IMA2/255)