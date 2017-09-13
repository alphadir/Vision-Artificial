% Practica #7.4 Filtro High Boost
% Flores Numa Jefte Allfadir
% 2011640201

clc
clear all
close all

%% Lectuta imagen
[file,root]=uigetfile('*.jpg','Selecciona Imagen');
IMA=imread(strcat(root,file));

%% Conversión imagen a escala de grises
GRIS=double(rgb2gray(IMA));

%% Tamaño imagen
[NF,NC]=size(GRIS);

%% Indice de creación de máscara
k=input('Introduzca el orden de la mascara (Numero impar):\n');
A=input('Introduzca el factor A \nDonde 1<=A<=2\n');;

m=k-1;
n=(k+1)/2;
K=(k-1)/2;
mask=ones(k,k);
mask=-1*mask;
w=((k^2)*A)-1;
mask(ceil((k^2)/2))=w;
mask=(1/(k^2))*mask;

%% Aplicando el filtrado
GRIS2=zeros(NF+m,NC+m); %Matríz donde se amplia el tamaño del marco
IMfiltrada=zeros(NF,NC); %Matríz resultante del filtrado

%% Igualando matríz de ruido a la matríz donde se amplia el marco
for i=1:NF
    for j=1:NC
        GRIS2(i+(n-1),j+(n-1))=GRIS(i,j);
    end
end

%% Aplicando el filtro high boost
for i=1:NF
    for j=1:NC
        temp=mask.*(GRIS2(i+K+(-K:K),j+K+(-K:K)));
        IMfiltrada(i,j)=abs(sum(sum(temp)));
        clear temp
    end
end

figure(1)
subplot(1,2,1), imshow(GRIS/255), title('Gris Original')
subplot(1,2,2), imshow(IMfiltrada/255), title('Gris Filtrada')