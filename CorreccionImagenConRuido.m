% Practica #5.2 Restaurar imagen con ruido
% Flores Numa Jefte Allfadir
% 2011640201

clc
clear all
close all

%% Indice de creaci�n de im�genes
m=input('Introduzca el n�mero de imagenes con ruido que desea crear "M": \n');

%% Lectuta imagen
[file,root]=uigetfile('*.jpg','Selecciona Imagen');
IMA=imread(strcat(root,file));

%% Conversi�n imagen a escala de grises
GRIS=rgb2gray(IMA);

%% Sacar tama�o a la imagen
[NF,NC]=size(GRIS);

%% Agregando ruido a la imagen & Conversi�n a gris
NEW=zeros(NF,NC);
for h=1:m
    clear IMruido
    IMruido=double(imnoise(GRIS,'gaussian',0.1));
    for i=1:NF
        for j=1:NC
            NEW(i,j)=(IMruido(i,j)+NEW(i,j));
        end
    end
end
NEW=NEW/m;
figure(1)
subplot(2,2,1), imshow(GRIS), title('Gris Original')
subplot(2,2,2), imshow(IMruido/255), title('Gris c/Ruido')
subplot(2,2,3), imshow(NEW/255), title('Gris Promediada')