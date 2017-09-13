% Practica #1 Separacíon de Colores
% Flores Numa Jefte Allfadir
% 2011640201

clc
clear all
close all

%% Lectuta imagen
[file,root]=uigetfile('*.jpg','Selecciona Imagen');
IMA=imread(strcat(root,file));

%% Sacar tamaño a la imagen
[NF,NC,C]=size(IMA);

%%  Conversión a gris
GRIS=double(rgb2gray(IMA));

%% Conversión a gris 2
GRIS2=zeros(NF,NC);
for i=1:NF
    for j=1:NC
        GRIS2(i,j)=double(0.299*IMA(i,j,1)+0.587*IMA(i,j,2)+0.144*IMA(i,j,3));
    end
end

%% Igualando colores primarios para sacar sus tonos de grises
ROJOGRIS=IMA(:,:,1);
VERDEGRIS=IMA(:,:,2);
AZULGRIS=IMA(:,:,3);

%% Mostrando la imagen en gris y sus capas de colores primarias en gris
figure(1)
subplot(2,2,1), imshow(uint8(GRIS)), title('Imágen Gris')
subplot(2,2,2), imshow(uint8(ROJOGRIS)), title('Capa de rojo gris')
subplot(2,2,3), imshow(uint8(VERDEGRIS)), title('Capa de verde gris')
subplot(2,2,4), imshow(uint8(AZULGRIS)),  title('Capa de azul gris')

%% Igualando imagen original para sacar colores primarios
% ROJO=zeros(size(IMA));
% VERDE=zeros(size(IMA));
% AZUL=zeros(size(IMA));

ROJO=zeros(NF,NC,C);
VERDE=zeros(NF,NC,C);
AZUL=zeros(NF,NC,C);

ROJO(:,:,1)=IMA(:,:,1);
VERDE(:,:,2)=IMA(:,:,2);
AZUL(:,:,3)=IMA(:,:,3);

%% Mostrando la imagen y sus capas de colores primarias
figure(2)
subplot(2,2,1), imshow(IMA), title('Imágen original')
subplot(2,2,2), imshow(ROJO/255), title('Capa de rojo')
subplot(2,2,3), imshow(VERDE/255), title('Capa de verde')
subplot(2,2,4), imshow(AZUL/255),  title('Capa de azul')

%% Igualando colores primarios para sacar sus derivados
AMARILLO=zeros(size(IMA));
CIAN=zeros(size(IMA));
MAGENTA=zeros(size(IMA));

AMARILLO(:,:,1:2)=IMA(:,:,1:2);
CIAN(:,:,2:3)=IMA(:,:,2:3);
MAGENTA(:,:,1:2:3)=IMA(:,:,1:2:3);

%% Mostrando la imagen y sus capas de colores secundarios
figure(3),
subplot(2,2,1), imshow(IMA), title('Imágen original')
subplot(2,2,2), imshow(AMARILLO/255), title('Combinación Rojo/Verde'),
subplot(2,2,3), imshow(CIAN/255), title('Combinación Verde/Azul'),
subplot(2,2,4), imshow(MAGENTA/255), title('Combinación Rojo/Azul')

%% Mostrando la imagen de grises en 3D
figure(4),
mesh(GRIS2)