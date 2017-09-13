% Practica #3.2 Dibujar imagenes en matriz
% Flores Numa Jefte Allfadir
% 2011640201

clc
clear all
close all

%% Se inicializa la matriz en ceros
IMA=zeros(300,250,3);
[NF,NC,C]=size(IMA);

%% Se empieza a dibujar las figuras en la matriz
%% con sus respectivas ecuaciones
for i=1:NF
    for j=1:NC
        %% Función rectángulo
        if i>=180 && i<=240 && j>=100 && j<=200
            IMA(i,j,1)=0;
            IMA(i,j,2)=0;
            IMA(i,j,3)=50;
        %% Función triángulo    
        elseif i>=90 && i<=150 && j>=(((-2/3)*i)+110) && j<=(((2/3)*i)-10)
            IMA(i,j,1)=100;
            IMA(i,j,2)=0;
            IMA(i,j,3)=0;
        %% Función figura compuerta AND
        elseif i>=60 && i<120 && j>=150 && j<=(200+sqrt(900-((i-90)^2)))
            IMA(i,j,1)=180;
            IMA(i,j,2)=180;
            IMA(i,j,3)=0;
        else
            IMA(i,j,1)=255;
            IMA(i,j,2)=255;
            IMA(i,j,3)=255;
        end
    end
end

imshow(uint8(IMA))