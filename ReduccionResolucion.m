% Practica #2 Reduccion de resolución con zoom aplicado a 512x512
% Flores Numa Jefte Allfadir
% 2011640201

clc
clear all
close all

[file,root]=uigetfile('*.jpg','Selecciona Imagen');
%% Reducción a color
%IMrgb=double(imread(strcat(root,file)));
%% Reducción a gris
IMrgb=double(rgb2gray(imread(strcat(root,file))));

figure(1),imshow(uint8(IMrgb))

%% Nred = numero de reducciones
Nred=9;
IMred=zeros(256,256);
IMadj=zeros(512,512);
for h=1:Nred
    [NF,NC,C]=size(IMrgb);
    %% Factor escalamiento
    k=2^h;
    %% En caso que se trabaje en RGB
    for rgb=1:C
        %% (fix) Redondea al entero menor en caso de resolucion impar
        for i=1:fix(NF/2)
            for j=1:fix(NC/2)
                %% Reduce de a 4 pixeles por iteracion
                IMred(i,j,rgb)=(IMrgb(2*i,2*j,rgb)+IMrgb(2*i,2*j-1,rgb)+IMrgb(2*i-1,2*j,rgb)+IMrgb(2*i-1,2*j-1,rgb))/4;
                %% Rellenar la nueva imagen con el factor de escalamiento de la inmagen reducida
                for m=0:k-1
                    for n=0:k-1
                        IMadj(k*i-n,k*j-m,rgb)=IMred(i,j,rgb);
                    end
                end
            end
        end
    end
    clear IMrgb
    %% Reduce en la siguiente iteracion
    IMrgb=IMred;
    clear IMred
    figure(h+1),imshow(uint8(IMadj))
end