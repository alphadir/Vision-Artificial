%% Nombre : López Landa Luis Adrian
%  Boleta : 2014360450
%  Grupo  : 4MM4
%  Fecha  : 04/05/2017
%  Sistemas de vision artificial
%  Growing Region.
%%
clc;
clear all;
close all;
%% Declaracion de constantes y varibles
PATH = '../Images/';
FILE = 'colores.jpg';
Y = 1;
X = 2;
rule = 15;
remain = 1;
visited = 0;
%% Seccion de adquision de images
image = imread(strcat(PATH,FILE));
gray_image = rgb2gray(image);
[rows,columns] = size(gray_image);
grown_image = zeros(rows,columns);
%% Comienzo del algoritmo
[columnP,rowP,pixel] = impixel(gray_image);
queue(1,Y) = rowP;
queue(1,X) = columnP;
grayToCompare = gray_image(rowP,columnP);
while(remain>=0)
    [rowsQ,columnsQ] = size(queue);
    visited = visited + 1;
    remain = rowsQ - visited;
    if(visited<=rowsQ)
        rowInf = queue(visited,Y)-1;
        rowSup = queue(visited,Y)+1;
        columnInf = queue(visited,X)-1;
        columnSup = queue(visited,X)+1;
        %grayToCompare = gray_image(queue(visited,Y),queue(visited,X));
        times = rowsQ;
        for(row = rowInf:rowSup)
            for(column = columnInf:columnSup)
                if(row>0&&row<=rows&&column>0&&column<=columns)
                    result = abs(double(gray_image(row,column))-double(grayToCompare));
                    if(result<=rule&&grown_image(row,column)==0)
                        times = times +1;
                        grown_image(row,column) = 1;
                        queue(times,Y)=row;
                        queue(times,X)=column;
                    end
                end
            end
        end
    end
end
figure
imshow(grown_image)