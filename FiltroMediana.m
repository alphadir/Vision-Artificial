% Practica #6.2 Filtro Mediana
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

%% Tamaño imagen
[NF,NC]=size(GRIS);

%% Ruido a la imagen
a=input('Seleccione 1 para ruido Gausiano o 2 para ruido Sal & Pimienta:\n');
if a==1
    IMruido=double(imnoise(GRIS,'gaussian',0.1));
elseif a==2
    IMruido=double(imnoise(GRIS,'salt & pepper',0.1));
else
    break
end

%% Aplicando el filtrado
GRIS2=zeros(NF+2,NC+2); %Matríz donde se amplia el tamaño del marco
IMfiltrada=zeros(NF,NC); %Matríz resultante del filtrado

%% Igualando matriz de ruido a la matríz donde se amplia el marco
for i=1:NF
    for j=1:NC
        GRIS2(i+1,j+1)=IMruido(i,j);
    end
end

%% Aplicando el filtro de mediana
for i=2:NF+1
    for j=2:NC+1
        Pos=sort([GRIS2(i-1,j-1) GRIS2(i-1,j) GRIS2(i-1,j+1) GRIS2(i,j-1) GRIS2(i,j) GRIS2(i,j+1) GRIS2(i+1,j-1) GRIS2(i+1,j) GRIS2(i+1,j+1)]);
        IMfiltrada(i,j)=Pos(5);
        clear Pos
    end
end

figure(1)
subplot(2,2,1), imshow(IMruido/255), title('Imagen con ruido')
subplot(2,2,2), imshow(GRIS2/255), title('Imagen con marco ampliado')
subplot(2,2,3), imshow(GRIS), title('Gris Original')
subplot(2,2,4), imshow(IMfiltrada/255), title('Gris Filtrada')