% Practica #4.2 Histograma
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

%% Histograma
Hist=zeros(256);
for i=1:NF
    for j=1:NC
        Hist(GRIS(i,j)+1)=Hist(GRIS(i,j)+1)+1;
    end
end

figure(1)
subplot(1,2,1), imshow(GRIS/255)
subplot(1,2,2), bar(Hist)