% Practica #4.1 Contraste Manual
% Flores Numa Jefte Allfadir
% 2011640201

clc
clear all
close all

%% Lectuta imagen
[file,root]=uigetfile('*.jpg','Selecciona Imagen');
IMA=imread(strcat(root,file));

% prompt='Ingrese la ruta de la imagen con el nombre: \n';
% ruta=input(prompt,'s');
% IMA=imread(strcat(ruta,'.jpg'));

%% Introducción de los valores
r1=input('Introduzca el valor de r1: \n');
r2=input('Introduzca el valor de r2: \n');
s1=input('Introduzca el valor de s1: \n');
s2=input('Introduzca el valor de s2: \n');

%%  Conversión a gris
GRIS=double(rgb2gray(IMA));

%% Sacar tamaño a la imagen
[NF,NC]=size(GRIS);

%% Ecuación de la recta
%s=mr+b

%% Calculando las pendientes
m1=(s1-0)/(r1-0);

m2=(s2-s1)/(r2-r1);
b2=s2-(m2*r2);

m3=(255-s2)/(255-r2);
b3=255-(m3*255);

%% Barrido de contraste
CON=zeros(255,255);
for i=1:NF
    for j=1:NC
        if GRIS(i,j)>=0 && GRIS(i,j)<r1
            CON(i,j)=m1*GRIS(i,j);
        elseif GRIS(i,j)>=r1 && GRIS(i,j)<r2
            CON(i,j)=m2*GRIS(i,j)+b2;
        elseif GRIS(i,j)>=r2 && GRIS(i,j)<255
            CON(i,j)=m3*GRIS(i,j)+b3;
        end
    end
end

%% Gráfica de las pendientes
r=0:0.01:255;
s=zeros;
for l=1:length(r)
    if r(l)>=0 && r(l)<r1
        s(l)=m1*r(l);
    elseif r(l)>=r1 && r(l)<r2
        s(l)=m2*r(l)+b2;
    else
        s(l)=m3*r(l)+b3;
    end
end

figure(1)
subplot(2,2,1), imshow(uint8(GRIS)), title('Gris Original')
subplot(2,2,2), imshow(uint8(CON)), title('Gris Constrastada')
subplot(2,2,3), plot(r,s,'linewidth', 1.5'), title('Pendiente Contraste')

%% Comprobación código
% r1=s1,r2=s2,r2>r1 (deja la imagen igual)
% r1=r2,s1=0;s2=255; (deja la imagen binaria)