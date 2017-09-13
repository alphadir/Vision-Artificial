%% Nombre : López Landa Luis Adrian
%  Boleta : 2014360450
%  Grupo  : 4MM4
%  Fecha  : 04/05/2017
%  Sistemas de vision artificial
%  Segmentacion Otsu.
%%
clc
clear all
close all
%% Declaracion de constantes y varibles
PATH = '../Images/';
FILE = 'colores.jpg';
MAX = 256;
MIN = 0;
gray_level = zeros(1,MAX); % Histograma de grises
gray_probability = zeros(1,MAX); %Probabilidad de gris
sum_probabilities = zeros(1,MAX);
classes = 3;
probabilities = zeros(1,classes);
threshold = zeros(1,classes);
means = zeros(1,classes);
max_variance = zeros(1,classes);
max_thresholds = zeros(1,classes);
P0S = 0;
P1S = 0;
P2S = 0;
M0S = 0;
M1S = 0;
M2S = 0;
M1 = 0;
M2 = 0;
M3 = 0;
current_value =0;
optimalT1 = 0;
optimalT2 = 0;
optimalT3 = 0;
MT = 0;
max_btw = 0;
max_btw2 = 0;
mask_sobel_H = [-1 -2 -1;0 0 0;1 2 1];
mask_sobel_V = mask_sobel_H';



%% Seccion de adquision de images
image = imread(strcat(PATH,FILE));
gray_image = rgb2gray(image);
%gray_image = imread(strcat(PATH,FILE));
[rows,columns] = size(gray_image);
pixels = rows*columns;
%% Seccion de recorrido de la imagen
for (row=1:rows)
    for(column=1:columns)
        value = double(gray_image(row,column));
        index = value+1;
        gray_level(index) = gray_level(index) + 1; 
    end
end
gray_probability = gray_level./(rows*columns);
for(k =1:MAX)
    MT = MT +(k*(gray_level(k)/pixels));
end
for(t1=1:MAX)
    P0S = P0S + gray_level(t1)/pixels;
    M0S = M0S + (t1*(gray_level(t1)/pixels));
    M0 = M0S / P0S; 
    P1S = 0;
    M1S = 0;
    for(t2=t1+1:MAX)
        P1S = P1S + (gray_level(t2)/pixels);
        M1S = M1S + (t2*(gray_level(t2)/pixels));
        M1 = M1S/P1S;
        P2S = 1 -(P0S+P1S);
        M2S = MT -(M0S+M1S);
        if(M2S<=0)
            break;
        end
        M2 = M2S/P2S;
        current_value = P0S*((M0-MT)^2)+P1S*((M1-MT)^2)+P2S*((M2-MT)^2);
            if(max_btw2<current_value)
                max_btw2 = current_value;
                optimal2T1 = t1;
                optimal2T2 = t2;
            end
        M2S = 0;
        P2S = 0;
        
        for(t3=t2+1:MAX)
            P2S = P2S + (gray_level(t3)/pixels);
            M2S = M2S + (t3*(gray_level(t3)/pixels)); 
            M2 = M2S/P2S;
            P3S = 1 -(P0S+P1S+P2S);
            M3S = MT -(M0S+M1S+M2S);
            M3 = M3S/P3S;
            current_value = P0S*((M0-MT)^2)+P1S*((M1-MT)^2)+P2S*((M2-MT)^2)+P3S*((M3-MT)^2);
            if(max_btw<current_value)
                max_btw = current_value;
                optimalT1 = t1;
                optimalT2 = t2;
                optimalT3 = t3;
            end
        end
    end
end
threshold1_image_binary = gray_image>=optimalT1;
threshold2_image_binary = gray_image>=optimalT2;
threshold3_image_binary = gray_image>=optimalT3;
threshold21_image_binary = gray_image>=optimal2T1;
threshold22_image_binary = gray_image>=optimal2T2;

horizontal_sobel_binary_t1 = abs(filter2(mask_sobel_H,threshold1_image_binary))>=1;
vertical_sobel_binary_t1 = abs(filter2(mask_sobel_V,threshold1_image_binary))>=1;
sobel_image_binary_t1 = horizontal_sobel_binary_t1 + vertical_sobel_binary_t1;

horizontal_sobel_binary_t2 = abs(filter2(mask_sobel_H,threshold2_image_binary))>=1;
vertical_sobel_binary_t2 = abs(filter2(mask_sobel_V,threshold2_image_binary))>=1;
sobel_image_binary_t2 = horizontal_sobel_binary_t2 + vertical_sobel_binary_t2;

horizontal_sobel_binary_t3 = abs(filter2(mask_sobel_H,threshold3_image_binary))>=1;
vertical_sobel_binary_t3 = abs(filter2(mask_sobel_V,threshold1_image_binary))>=1;
sobel_image_binary_t3 = horizontal_sobel_binary_t3 + vertical_sobel_binary_t3;
generated_image=zeros(rows,columns);
for(row=1:rows)
    for(column=1:columns)
        if(gray_image(row,column)<optimal2T1)
            generated_image(row,column) = 0;
        elseif(gray_image(row,column)>=optimal2T1&&gray_image(row,column)<optimal2T2)
            generated_image(row,column) = 0.5;
        else 
            generated_image(row,column) = 1;
        end
    end
end
%% Muestra de resultados
subplot(2,2,1)
imshow(gray_image);
subplot(2,2,2)
imshow(threshold1_image_binary);
subplot(2,2,3)
imshow(threshold2_image_binary);
subplot(2,2,4)
imshow(threshold3_image_binary);
figure

subplot(2,2,1)
imshow(gray_image);
subplot(2,2,2)
imshow(sobel_image_binary_t1);
subplot(2,2,3)
imshow(sobel_image_binary_t2);
subplot(2,2,4)
imshow(sobel_image_binary_t3);
figure
hold on
bar(0:255,gray_level)
plot([optimalT1,optimalT1],[0,max(gray_level)])
plot([optimalT2,optimalT2],[0,max(gray_level)])
plot([optimalT3,optimalT3],[0,max(gray_level)])
title('Tres umbrales');
figure
hold on
bar(0:255,gray_level)
plot([optimal2T1,optimal2T1],[0,max(gray_level)])
plot([optimal2T2,optimal2T2],[0,max(gray_level)])
title('Dos umbrales');
figure
subplot(2,2,1)
imshow(gray_image);
subplot(2,2,2)
imshow(generated_image);
subplot(2,2,3)
imshow(threshold21_image_binary);
subplot(2,2,4)
imshow(threshold22_image_binary);

thresh = multithresh(gray_image,3)