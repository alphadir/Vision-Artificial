% Practica #7.2 Filtro Mediana
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

%% Ruido a la imagen e Indice de creación de máscara
k=input('Introduzca el orden de la mascara (Numero impar): \n');
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

%% Igualando matríz de ruido a la matríz donde se amplia el marco
for i=1:NF
    for j=1:NC
        GRIS2(i+(n-1),j+(n-1))=IMruido(i,j);
    end
end

%% Aplicando el filtro de mediana
for i=1:NF
    for j=1:NC
        h=reshape(GRIS2(i+K+(-K:K),j+K+(-K:K)),k^2,1);
        Pos=sort(h);
        IMfiltrada(i,j)=Pos(ceil(k*k/2));
        clear Pos;
    end
end

figure(1)
subplot(2,2,1), imshow(IMruido/255), title('Imagen con ruido')
subplot(2,2,2), imshow(GRIS2/255), title('Imagen con marco ampliado')
subplot(2,2,3), imshow(GRIS), title('Gris Original')
subplot(2,2,4), imshow(IMfiltrada/255), title('Gris Filtrada')