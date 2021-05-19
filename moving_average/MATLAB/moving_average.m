clear all;
clc;

FILTER_LEN = 8;

x = [1:32];
h = ones(FILTER_LEN,1);
y = filter(h,1,x)/FILTER_LEN;

y'
