% Practica #11.1 Laplace
% Flores Numa Jefte Allfadir
% 2011640201

clc
clear all
close all

%% Gamma Imagen
r=input('Defina la gamma "r": ');

%% Lectuta imagen
[file,root]=uigetfile('*.jpg','Selecciona Imagen');
IMA=imread(strcat(root,file));

%% Conversión imagen a escala de grises
GRIS=double(rgb2gray(IMA));

%% Creación de máscara
n=ceil(r*3)*2+1;
i=1;
j=1;

mask_h=zeros;

for x=-ceil(n/2):floor(n/2)
    for y=-ceil(n/2):floor(n/2)
        r2=x^2+y^2;
        mask_h(i,j)=-((r2-(r^2))/(r^4))*exp(-r2/(2*(r^2)));
        j=j+1;
    end
    i=i+1;
    clear j
    j=1;
end

mask_h=mask_h-mean(mask_h(:));

%% Mascaras de deteccion de lineas
Laplace = filter2(mask_h,GRIS);

binaria = Laplace>=0;

%% Sobel
mask_x = [-1 -2 -1; 0 0 0; 1 2 1];
mask_y = [-1 0 1; -2 0 2; -1 0 1];

sobel_x = abs(filter2(mask_x,binaria));
sobel_y = abs(filter2(mask_y,binaria));

bordes_x=sobel_x>0;
bordes_y=sobel_y>0;

bordes = bordes_x + bordes_y;

figure(1)
mesh(mask_h)

%figure(2)
%mesh(Laplace)

q=min(min(Laplace));
p=max(max(Laplace))-q;
figure(3)
subplot(1,2,1), imshow(uint8(GRIS)), title('Gris Original')
subplot(1,2,2), imshow(uint8(255*(Laplace-q)/p)), title('Laplace') 

figure(4)
subplot(1,2,1), imshow(binaria), title('Binaria')
subplot(1,2,2), imshow(bordes), title('Bordes')