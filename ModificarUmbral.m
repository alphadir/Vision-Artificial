% Practica #11.2 Modificar Umbral
% Flores Numa Jefte Allfadir
% 2011640201

clc
clear all
close all

%% Lectuta imagen
[file,root]=uigetfile('*.jpg','Selecciona Imagen');
IMA=imread(strcat(root,file));

%% Conversión imagen a escala de grises
GRIS=rgb2gray(IMA);

figure(1)
subplot(1,2,1), imshow(GRIS)
subplot(1,2,2), imhist(GRIS)

umbral=input('Ingrese umbral: \n');
GRIS2=GRIS<umbral;

figure(2)
subplot(1,2,1), imshow(GRIS2)
subplot(1,2,2), imhist(GRIS2)