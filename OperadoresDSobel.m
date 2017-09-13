% Practica #8.2 Operadores de Sobel
% Flores Numa Jefte Allfadir
% 2011640201

clc
clear all
close all

%% Lectuta imagen
[file,root]=uigetfile('*.jpg','Selecciona Imagen');
IMA=imread(strcat(root,file));

%% Creación de máscara
mask1=[-1,-2,-1;0,0,0;1,2,1];
mask2=[-1,0,1;-2,0,2;-1,0,1];

%% Conversión imagen a escala de grises
GRIS=double(rgb2gray(IMA));

%% Tamaño imagen
[NF,NC]=size(GRIS);
GRIS2=zeros(NF+2,NC+2);
GRIS3=zeros(NF,NC);
GRIS4=zeros(NF,NC);
IMfiltrada=zeros(NF,NC);
IMfiltrada2=zeros(NF,NC);

%% Igualando a la matríz donde se amplia el marco
for i=1:NF
    for j=1:NC
        GRIS2(i+1,j+1)=GRIS(i,j);
    end
end

%% Aplicando operadores de Sobel
for i=2:NC+1
    for j=2:NC+1
        n=[GRIS2(i-1,j-1) GRIS2(i-1,j) GRIS2(i-1,j+1); GRIS2(i,j-1) GRIS2(i,j) GRIS2(i,j+1); GRIS2(i+1,j-1) GRIS2(i+1,j) GRIS2(i+1,j+1)];
        GRIS3(i-1,j-1)=abs(sum(sum(mask1.*n)));
        GRIS4(i-1,j-1)=abs(sum(sum(mask2.*n)));
    end
end

%% Escalando el valor máximo de las derivaciones
b=255/max(max(GRIS3));
c=255/max(max(GRIS4));
for i=1:NF
    for j=1:NC
        IMfiltrada(i,j)=GRIS3(i,j)*b;
        IMfiltrada2(i,j)=GRIS4(i,j)*c;
    end
end

%% Sumando matriz resultante
GRIS5=IMfiltrada+IMfiltrada2;
a=255/max(max(GRIS5));
IMfiltrada3=GRIS5*a;


figure(1)
subplot(2,2,1), imshow(GRIS/255), title('Imagen original')
subplot(2,2,2), imshow(IMfiltrada/255), title('Imagen derivada en Y')
subplot(2,2,3), imshow(IMfiltrada2/255), title('Imagen derivada en X')
subplot(2,2,4), imshow(IMfiltrada3/255), title('Operadores De Sobel')