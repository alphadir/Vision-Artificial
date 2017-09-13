% Practica #7.3 Filtro Pasa Altas
% Flores Numa Jefte Allfadir
% 2011640201

clc
clear all
close all

%% Lectuta imagen
[file,root]=uigetfile('*.jpg','Selecciona Imagen');
IMA=imread(strcat(root,file));

%% Conversi�n im�gen a escala de grises
GRIS=double(rgb2gray(IMA));

%% Tama�o imagen
[NF,NC]=size(GRIS);

%% Indice de creaci�n de m�scara
k=input('Introduzca el orden de la mascara (Numero impar): \n');
m=k-1;
n=(k+1)/2;
K=(k-1)/2;
mask=ones(k,k);
mask=-1*mask;
mask(ceil((k^2)/2))=((k^2)-1);
mask=(1/(k^2))*mask;

%% Aplicando el filtrado
GRIS2=zeros(NF+m,NC+m); %Matr�z donde se amplia el tama�o del marco
IMfiltrada=zeros(NF,NC); %Matr�z resultante del filtrado

%% Igualando matriz de ruido a la matriz donde se amplia el marco
for i=1:NF
    for j=1:NC
        GRIS2(i+(n-1),j+(n-1))=GRIS(i,j);
    end
end

%% Aplicando el filtro pasa altas
for i=1:NF
    for j=1:NC
        temp=mask.*(GRIS2(i+K+(-K:K),j+K+(-K:K)));
        IMfiltrada(i,j)=abs(sum(sum(temp)));
        clear temp
    end
end

figure(1)
subplot(1,2,1), imshow(GRIS/255), title('Gris Original')
%subplot(1,2,2), imshow(IMfiltrada/255), title('Gris Filtrada')
subplot(1,2,2), imshow(IMfiltrada/max(max(IMfiltrada,[],1))), title('Gris Filtrada')