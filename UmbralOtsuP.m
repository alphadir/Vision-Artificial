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

%% Probabilidad de Ocurrencia de Gris
fi=imhist(GRIS);
N=NF*NC;
p=fi/N;

%% Momentos de Orden 0
w1=zeros;
w2=zeros;
for t=1:256
    w1(t)=sum(p(1:t));
    w2(t)=sum(p(t+1:256)); %ó w2(i)=1-w1(t) debido a que w1+w2=1
end

%% Média clase C1 y C2
m1=zeros;
m2=zeros;
iPi=zeros;

for i=1:256
    iPi(i)=p(i)*(i-1);
end
for t=1:256
    m1(t)=sum(iPi(1:t))/w1(t);
    m2(t)=sum(iPi(t+1:256))/w2(t);
end

mT=(w1.*m1)+(w2.*m2);

sigma=(w1.*((m1-mT).^2))+(w2.*((m2-mT).^2));

umbral=0;
for i=1:length(sigma)
   if sigma(i)==max(sigma)
       umbral=i-1;
   end
end

binaria=GRIS>umbral;

figure(1)
subplot(2,2,1), imshow(GRIS)
subplot(2,2,2), imshow(binaria)
subplot(2,2,[3,4]), imhist(GRIS)