% Practica #7.1 Filtro Pasa Baja
% Flores Numa Jefte Allfadir
% 2011640201

clc
clear all
close all

%% Lectuta imagen
[file,root]=uigetfile('*.jpg','Selecciona Imagen');
IMA=imread(strcat(root,file));

%% Conversión imágen a escala de grises
GRIS=rgb2gray(IMA);

%% Tamaño imagen
[NF,NC]=size(GRIS);

%% Ruido a la imagen e Indice de creación de máscara
k=input('Introduzca el orden de la mascara (numero impar): \n');
r=input('Seleccione: \n1) para ruido Gausiano \n2) para ruido Sal & Pimienta\n');

m=k-1;
n=(k+1)/2;
K=(k-1)/2;

if r==1
    IMruido=double(imnoise(GRIS,'gaussian',0.1));
else
    IMruido=double(imnoise(GRIS,'salt & pepper',0.1));
end

%% Aplicando el filtrado
GRIS2=zeros(NF+m,NC+m); %Matríz donde se amplia el tamaño del marco
IMfiltrada=zeros(NF,NC); %Matríz resultante del filtrado
temp=zeros;

%% Igualando matriz de ruido a la matriz donde se amplia el marco
for i=1:NF
    for j=1:NC
        GRIS2(i+(n-1),j+(n-1))=IMruido(i,j);
    end
end

%% Aplicando el filtro pasa bajas
for i=1:NF
    for j=1:NC
        temp=sum(GRIS2(i+K+(-K:K),j+K+(-K:K)));
        IMfiltrada(i,j)=sum(temp)/(k^2);
    end
end

figure(1)
subplot(2,2,1), imshow(IMruido/255), title('Imagen con ruido')
subplot(2,2,2), imshow(GRIS2/255), title('Imagen con marco ampliado')
subplot(2,2,3), imshow(GRIS), title('Gris Original')
subplot(2,2,4), imshow(IMfiltrada/255), title('Gris Filtrada')