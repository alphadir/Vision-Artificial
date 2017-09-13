% Practica #10 Sobel & Prewitt filter2
% Flores Numa Jefte Allfadir
% 2011640201

clc
clear all
close all

%% Umbral Imagen
umbral=input('Defina el umbral: ');

%% Lectuta imagen
[file,root]=uigetfile('*.jpg','Selecciona Imagen');
IMA=imread(strcat(root,file));

%% Conversión Imagen a escala de Grises
GRIS=rgb2gray(IMA);

%% Creacion de Mascara
%Sobel
masksx=[-1 -2 -1; 0 0 0; 1 2 1];
masksy=[-1 0 1; -2 0 2; -1 0 1];

%Prewitt
maskpx=[-1 -1 -1; 0 0 0; 1 1 1];
maskpy=[-1 0 1; -1 0 1; -1 0 1];

%% Mascaras de Deteccion de Lineas
sobelx=abs(filter2(masksx,GRIS));
sobely=abs(filter2(masksy,GRIS));

prewittx=abs(filter2(maskpx,GRIS));
prewitty=abs(filter2(maskpy,GRIS));

bordesxs=sobelx>umbral;
bordesys=sobely>umbral;

bordesxp=prewittx>umbral;
bordesyp=prewitty>umbral;

bordesS=bordesxs+bordesys;
bordesP=bordesxp+bordesyp;

figure(1)
subplot(2,2,1), imshow(GRIS), title('Gris Original')
subplot(2,2,2), imshow(bordesS), title('Sobel')
subplot(2,2,3), imshow(bordesxs), title('Sobel X')
subplot(2,2,4), imshow(bordesys), title('Sobel Y')

figure(2)
subplot(2,2,1), imshow(GRIS), title('Gris Original')
subplot(2,2,2), imshow(bordesP), title('Prewitt')
subplot(2,2,3), imshow(bordesxp), title('Prewitt X')
subplot(2,2,4), imshow(bordesyp), title('Prewitt Y')