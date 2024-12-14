%% part1
clc; clear; close all;

I = im2double(imread("Q2\Cells.tif"));
[counts,x] = imhist(I,256);
T = otsuthresh(counts);
BW = imbinarize(I,T);
% imtool(BW);
label_image = MY_BWlabel(BW);

imshow(label_image, [])

path = pwd;

save_xls(path, I, BW);
