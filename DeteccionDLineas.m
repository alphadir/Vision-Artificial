% Practica #9 Detección de Lineas
% Flores Numa Jefte Allfadir
% 2011640201

clc
clear all
close all

%% Umbral imagen
umbral=[600 1800 2400 3000 2900 1200];

%U700 20° U1800 50° U2400 60°
%U3000 120° U3000 130° U1200 150°

%% Lectura imagen
IMA=imread('Lineas.bmp');

%% Conversion a grises
GRIS=rgb2gray(IMA);

%% Máscaras de detección de lineas
  
    %20 Grados
    mask1=[ -8/6 -8/6 -8/6 1 2 1
        1 2 1 -8/6 -8/6 -8/6];
    %50 Grados
    mask2=[ -16/27 -16/27 -16/27 -16/27 2 -16/27
      -16/27 -16/27 -16/27 -16/27 2 -16/27
      -16/27 -16/27 1 2 -16/27 -16/27
      -16/27 2 2 -16/27 -16/27 -16/27
      1 2 -16/27 -16/27 -16/27 -16/27
      2 -16/27 -16/27 -16/27 -16/27 -16/27];
    %60 Grados
    mask3=[ -16/18 -16/18 -16/18 2
           -16/18 -16/18 1 2
           -16/18 -24/18 2 -16/18
           -16/18 1 1 -16/18
           -16/18 2 -16/18 -16/18
           2 1 -16/18 -16/18
           2 -16/18 -16/18 -16/18];
    %120 Grados
    mask4=[4 -5/3 -5/3 -5/3
           2 2 -5/3 -5/3
           -5/3 4 -5/3 -5/3
           -5/3 2 2 -5/3
           -5/3 -5/3 4 -5/3
           -5/3 -5/3 2 2
           -5/3 -5/3 -5/3 4];
    %130 Grados
    mask5=[4 -10/11 -10/11 -10/11 -10/11
           -10/11 2 -10/11 -10/11 -10/11
           -10/11 2 2 -10/11 -10/11
           -10/11 -10/11 2 2 -10/11
           -10/11 -10/11 -10/11 2 -10/11
           -10/11 -10/11 -10/11 -10/11 4];
    %150 Grados
    mask6=[4 1 -10/9 -10/9 -10/9 -10/9 -10/9
           -10/9 1 3 1 -10/9 -10/9 -10/9
           -10/9 -10/9 -10/9 1 3 1 -10/9
           -10/9 -10/9 -10/9 -10/9 -10/9 1 4];

%% Aplicación de filtrado
disp('Introduzca el ángulo que desea hallar:')
fprintf('1)20°\n2)50°\n3)60°\n4)120°\n5)130°\n6)1500°\n')
i=input(' ');

if i==1
    IMfiltrada=abs(filter2(mask1,GRIS));
elseif i==2
    IMfiltrada=abs(filter2(mask2,GRIS));
elseif i==3
    IMfiltrada=abs(filter2(mask3,GRIS));
elseif i==4
    IMfiltrada=abs(filter2(mask4,GRIS));
elseif i==5
    IMfiltrada=abs(filter2(mask5,GRIS));
elseif i==6
    IMfiltrada=abs(filter2(mask6,GRIS));
end

binaria=IMfiltrada>umbral(i);

figure(1)
subplot(1,2,1), imshow(GRIS), title('Imagen Original')
subplot(1,2,2), imshow(binaria), title('Deteccion de Lineas')