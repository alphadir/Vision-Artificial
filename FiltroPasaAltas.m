% Practica #6.3 Filtro Pasa Altas
% Flores Numa Jefte Allfadir
% 2011640201

clc
clear all
close all

%% Lectuta imagen
[file,root]=uigetfile('*.jpg','Selecciona Imagen');
IMA=imread(strcat(root,file));

%% Indice de creaci�n de m�scara
mask=ones(3,3);
mask=-1*mask;
mask(ceil(9/2))=(9-1);
mask=(1/9)*mask;

%% Conversi�n imagen a escala de grises
GRIS=double(rgb2gray(IMA));

%% Tama�o imagen
[NF,NC]=size(GRIS);

%% Aplicando el filtrado
GRIS2=zeros(NF+2,NC+2); %Matr�z donde se amplia el tama�o del marco
IMfiltrada=zeros(NF,NC); %Matr�z resultante del filtrado

%% Igualando a la matriz donde se amplia el marco
for i=1:NF
    for j=1:NC
        GRIS2(i+1,j+1)=GRIS(i,j);
    end
end

%% Aplicando el filtro pasa bajas
for i=2:NF+1
    for j=2:NC+1
        IMfiltrada(i,j)=abs(sum(sum(mask.*[GRIS2(i-1,j-1) GRIS2(i-1,j) GRIS2(i-1,j+1); GRIS2(i,j-1) GRIS2(i,j) GRIS2(i,j+1); GRIS2(i+1,j-1) GRIS2(i+1,j) GRIS2(i+1,j+1)])));
    end
end

figure(1)
subplot(1,2,1), imshow(GRIS/255), title('Gris Original')
subplot(1,2,2), imshow(IMfiltrada/255), title('Gris Filtrada')