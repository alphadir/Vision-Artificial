clc
clear all
close all

t=2;
for a=1:t
%% Lectura imagen
[file,root]=uigetfile('*.jpg','Selecciona Imagen');
IMA=imread(strcat(root,file));

%% Conversión a gris
Gris= (rgb2gray(IMA));

%% Umbralizado
umbral = 70;
bin= Gris<=umbral;
bin2 = bwareaopen(bin,200); %Binarizara figuras con mas de 100 pixels
prop = regionprops(bin2); %Obtiene propiedades de la imagen

%% Centroide
X0=0;
Y0=0;
X0 = prop.Centroid(1);
Y0 = prop.Centroid(2);

bordes = bwboundaries(bin2); %Inicia el barrido de la imagen
boud = bordes{1};
X=0;
Y=0;
Y = boud(:,1);
X = boud(:,2);
% figure(1)
% hold on
% plot(X,-Y,'r')
% plot(X0,-Y0,'*')
% hold off
X1 = X-X0;
Y1 = Y-Y0;
[theta,rho] = cart2pol(X1,Y1);
%mtheta = max(theta);
for j= 1:length(theta)
    if theta(j)==max(theta)
        pmtheta = j;
    end
end
theta = [theta(pmtheta+1:j);theta(1:pmtheta)];
rho = [rho(pmtheta+1:j);rho(1:pmtheta)];
mrho = max(rho);
rho = rho./mrho;
figure(1)
subplot(2,2,a), plot(theta,rho)
figure(2)
subplot(2,2,a),imshow(bin2)
end