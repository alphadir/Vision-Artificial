% Practica #15 Momentos de Hu
% Flores Numa Jefte Allfadir
% 2011640201

clc
clear all
close all
t=3;
I=zeros(t,7);
J=zeros(t,7);
for a=1:t
%% Lectuta imagen
clear cam
pause(3)
cam=webcam(1);
IMA=snapshot(cam);
%[file,root]=uigetfile('*.jpg','Selecciona Imagen');
%IMA=imread(strcat(root,file));

%% Conversión imagen a escala de grises
GRIS=rgb2gray(IMA);

%% Binariza la imagen
%umbral=input('Umbral: ');
bin=GRIS<=70;
%figure, imhist(GRIS)

%% Borrar los pixeles menores a 50
binaria=bwareaopen(bin,200);
figure(1)
subplot(2,2,a),imshow(binaria)
[NF,NC]=size(binaria);

%% Momentos generales discretos
m00=0;
m10=0;m01=0;m11=0;
m02=0;m20=0;
m30=0;m03=0;m12=0;m21=0;
for i=1:NF
    for j=1:NC
        if binaria(i,j)>0
            m00=m00+binaria(i,j);
            
            m10=m10+i*binaria(i,j);
            m01=m01+j*binaria(i,j);
            m11=m11+i*j*binaria(i,j);
            
            m20=m20+((i^2)*(binaria(i,j)));
            m02=m02+((j^2)*(binaria(i,j)));
            
            m30=m30+((i^3)*(binaria(i,j)));
            m03=m03+((j^3)*(binaria(i,j)));
            m12=m12+(i*(j^2)*(binaria(i,j)));
            m21=m21+((i^2)*j*(binaria(i,j)));
        end
    end
end

%% Centroide
xm=m10/m00;
ym=m01/m00;

%% Momentos invariantes a la translación yá divididos entre las homotecias
n11=(m11-(ym*m10))/m00^2;

n20=(m20-xm*m10)/m00^2;
n02=(m02-ym*m01)/m00^2;

n21=(m21-(2*xm*m11)-(ym*m20)+(2*m01*(xm^2)))/m00^2.5;
n12=(m12-(2*ym*m11)-(xm*m02)+(2*m10*(ym^2)))/m00^2.5;
n30=(m30-(3*xm*m20)+(2*m10*(xm^2)))/m00^2.5;
n03=(m03-(3*ym*m02)+(2*m01*(ym^2)))/m00^2.5;

%% Momentos de Hu
I1=n20+n02;
I2=(n20-n02)^2+(4*n11^2);
I3=(n30-(3*n12))^2+((3*n21)-n03)^2;
I4=(n30+n12)^2+(n21+n03)^2;
I5=(n30-3*n12)*(n30+n12)*((n30+n12)^2-(3*(n21+n03)^2))+(3*n21-n03)*(n21+n03)*((3*(n30+n12)^2)-(n21+n03)^2);
I6=(n20-n02)*((n30+n12)^2-(n21+n03)^2)+(4*n11)*(n30+n12)*(n21+n03);
I7=(3*n21-n03)*(n30+n12)*((n30+n12)^2-(3*(n21+n03)^2))-(n30-3*n12)*(n21+n03)*((3*(n30+n12)^2)-(n21+n03)^2);

%% Normalización
J1=abs(log(abs(I1)));
J2=abs(log(abs(I2)));
J3=abs(log(abs(I3)));
J4=abs(log(abs(I4)));
J5=abs(log(abs(I5)));
J6=abs(log(abs(I6)));
J7=abs(log(abs(I7)));

I(a,:)=[I1,I2,I3,I4,I5,I6,I7];
J(a,:)=[J1,J2,J3,J4,J5,J6,J7];
end
disp('I')
disp(I)
disp('J')
disp(J)