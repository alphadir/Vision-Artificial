%% Nombre : López Landa Luis Adrian
%  Boleta : 2014360450
%  Grupo  : 4MM4
%  Fecha  : 20/04/2017
%  Sistemas de vision artificial
%  Imagen escondida
%% Limpieza de variables y ventanas
clc;
clear all;
close all;
%% Declaracion de constantes y variables
FOLDER_NAME = 'Images/';
FILE_BASE_NAME = 'CAPA';
LAYERS = 8;
folder = dir(strcat(FOLDER_NAME,'/*.bmp'));
pictures = length(folder);
%% Obtencion de imagenes
sample_image = imread(strcat(FOLDER_NAME,FILE_BASE_NAME,num2str(0),'.bmp'));
[rows,columns] = size(sample_image);
gray_images = zeros(rows,columns,pictures);
layers = zeros(rows,columns,LAYERS);
hiden_image = zeros(rows,columns);
for(picture=1:pictures)
    gray_images(:,:,picture) = imread(strcat(FOLDER_NAME,FILE_BASE_NAME,num2str(picture-1),'.bmp'));
end
 for(layer = 1:LAYERS)
    for(row=1:rows)
        for(column=1:columns)
            layers(row,column,layer) = bitget(gray_images(row,column,layer),1);
        end
    end
 end
 for(row=1:rows)
     for(column=1:columns)
         for(layer=1:LAYERS)
             hiden_image(row,column) = hiden_image(row,column) + (2^(layer-1)*double(layers(row,column,9-layer)));
         end
     end
 end
%% Muestra de resultados
subplot(3,3,1)
imshow(sample_image)
title('Imagen Original')
subplot(3,3,2)
imshow(layers(:,:,1))
title('LAYER 0')
subplot(3,3,3)
imshow(layers(:,:,2))
title('LAYER 1')
subplot(3,3,4)
imshow(layers(:,:,3))
title('LAYER 2')
subplot(3,3,5)
imshow(layers(:,:,4))
title('LAYER 3')
subplot(3,3,6)
imshow(layers(:,:,5))
title('LAYER 4')
subplot(3,3,7)
imshow(layers(:,:,6))
title('LAYER 5')
subplot(3,3,8)
imshow(layers(:,:,7))
title('LAYER 6')
subplot(3,3,9)
imshow(layers(:,:,8))
title('LAYER 7')
figure,
imshow(uint8(hiden_image))

figure,
imshow(uint8(hiden_image))

