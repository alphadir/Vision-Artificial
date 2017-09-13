% Practica #5.1 Contraste Automático
% Flores Numa Jefte Allfadir
% 2011640201

clc
clear all
close all

%% Lectuta imagen
[file,root]=uigetfile('*.jpg','Selecciona Imagen');
IMA=imread(strcat(root,file));

%%  Conversión a gris
GRIS=double(rgb2gray(IMA));

%% Sacar tamaño a la imagen
[NF,NC]=size(GRIS);

%% Histograma
Hist=zeros(1,256);
for i=1:NF
    for j=1:NC
        Hist(GRIS(i,j)+1)=Hist(GRIS(i,j)+1)+1;
    end
end

%% Aplicando la función de transformación con 'cumsum'
S=round((255*cumsum(Hist))/(NF*NC));

%% Aplicando la función de transformación con 'sum'
S2=zeros(1,256);
for l=1:length(Hist)
    S2(l)=round((sum(Hist(1:l))*255)/(NF*NC));
end

%% Rellenado de la nueva imagen con el contraste modificado
GRIS2=zeros(NF,NC);
for m=1:NF
    for n=1:NC
        GRIS2(m,n)=S(GRIS(m,n)+1);
    end
end

%% Histograma2
Hist2=zeros(1,256);
for i=1:NF
    for j=1:NC
        Hist2(GRIS2(i,j)+1)=Hist2(GRIS2(i,j)+1)+1;
    end
end

figure(1)
subplot(2,2,1), imshow(GRIS/255), title('Gris Original')
subplot(2,2,2), bar(Hist), title('Histograma Gris Original')
subplot(2,2,3), imshow(GRIS2/255), title('Gris Contraste Ajustado')
subplot(2,2,4), bar(Hist2), title('Histograma Gris Contraste Ajustado')

figure(2)
plot(S2), title('Gráfica de ajuste')