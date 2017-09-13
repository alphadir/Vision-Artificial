% Practica #3.1 Binarizar Imagenes
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

%% Limites del umbral
A=input('Ingrese el valor mínimo del umbral: \n');
B=input('Ingrese el valor máximo del umbral: \n');

%% Barrido imagen entre 0 y 255
BIN=zeros(NF,NC);
BIN2=zeros(NF,NC);
for i=1:NF
    for j=1:NC
        if GRIS(i,j)>=A && GRIS(i,j)<B
            BIN(i,j)=255;
            BIN2(i,j)=255;
        else
            BIN(i,j)=0;
            BIN2(i,j)=GRIS(i,j);
        end
    end
end

%% Gráfica escalón
t=zeros;
for l=1:255
    if l>=A && l<B
        t(l)=255;
    else
        t(l)=0;
    end
end

%% Gráfica recta con escalón
T=zeros;
for l=1:255
    if l>=A && l<B
        T(l)=255;
    else
        T(l)=l;
    end
end

figure(1)
subplot(2,2,1), imshow(GRIS/255), title('Gris Original')
subplot(2,2,2), imshow(BIN/255), title('Gris Umbralizado')
subplot(2,2,3), plot(t,'linewidth',1.5), title('Rango')

figure(2)
subplot(2,2,1), imshow(GRIS/255), title('Gris Original')
subplot(2,2,2), imshow(BIN2/255), title('Gris Umbralizado combinado')
subplot(2,2,3), plot(T,'linewidth',1.5), title('Rango')