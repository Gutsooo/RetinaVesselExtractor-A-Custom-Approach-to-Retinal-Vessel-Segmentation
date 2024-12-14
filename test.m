%% part1
clc; clear; close all;

I = imread("thersholding.tif");
I = I(:,:,2);

S = imfilter(I,fspecial("average",[51 51]));

K = 0.8;

T = K*S;
F = adaptthresh(I);
imtool(F);

imshow(I>T);