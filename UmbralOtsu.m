% Practica #12 Método de Otsu
% Flores Numa Jefte Allfadir
% 2011640201

clc
clear all
close all

%% Lectuta imagen
[file,root]=uigetfile('*.jpg','Selecciona Imagen');
IMA=imread(strcat(root,file));

%% Conversión Imagen a escala de Grises
GRIS=rgb2gray(IMA);
[NF,NC]=size(GRIS);

p=imhist(GRIS)/(NF*NC);

%% Calculo del momento acumulado de orden cero
w=zeros;
w(1)=p(1);
mu=zeros;
for i=2:256
    w(i)=w(i-1)+p(i);
    mu(i)=mu(i-1)+(i-1)*p(i);
end

%% Calculo del umbral optimo segun Otsu
mut=mu(256); % Intensidad media total de la imagen
sigmamax=0;
for t=1:256
    w1=w(t);
    w2=1-w1;
    if w1~=0 && w2~=0
        m1=mu(t)/w1;
        m2=(mut-mu(t))/w2;
        sigma=w1*(m1-mut)^2+w2*(m2-mut)^2;
        if sigma>sigmamax
            sigmamax=sigma;
            umbral=t-1;
        end
    end
end

binaria=GRIS>umbral;

figure(1)
subplot(2,2,1), imshow(GRIS)
subplot(2,2,2), imshow(binaria)
subplot(2,2,[3,4]), imhist(GRIS)