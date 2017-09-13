% Practica #8.1 Operadores de Roberts
% Flores Numa Jefte Allfadir
% 2011640201

clc
clear all
close all

%% Lectuta imagen
[file,root]=uigetfile('*.jpg','Selecciona Imagen');
IMA=imread(strcat(root,file));

%% Creación de máscara
mask1=[1,0;-1,0];
mask2=[1,-1;0,0];

%% Conversión imagen a escala de grises
GRIS=double(rgb2gray(IMA));

%% Tamaño imagen
[NF,NC]=size(GRIS);
GRIS2=zeros(NF+1,NC+1);
GRIS3=zeros(NF,NC);
GRIS4=zeros(NF,NC);
IMfiltrada=zeros(NF,NC);
IMfiltrada2=zeros(NF,NC);

%% Igualando a la matriz donde se amplia el marco
for i=1:NF
    for j=1:NC
        GRIS2(i,j)=GRIS(i,j);
    end
end

%% Aplicando Operadores de Roberts x & y
for i=1:NF
    for j=1:NC
        n=[GRIS2(i,j) GRIS2(i,j+1); GRIS2(i+1,j) GRIS2(i+1,j+1)];
        GRIS3(i,j)=abs(sum(sum(mask1.*n)));
        GRIS4(i,j)=abs(sum(sum(mask2.*n)));
    end
end

%% Sumando matriz resultante
GRIS5=GRIS3+GRIS4;

figure(1)
subplot(2,2,1), imshow(GRIS/255), title('Imagen original')
subplot(2,2,2), imshow(GRIS3/255), title('Imagen derivada en Y')
subplot(2,2,3), imshow(GRIS4/255), title('Imagen derivada en X')
subplot(2,2,4), imshow(GRIS5/255), title('Operadores De Roberts')