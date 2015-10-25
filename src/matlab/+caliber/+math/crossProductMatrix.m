function [ M ] = crossProductMatrix( v )
%CROSSPRODUCTMATRIX Summary of this function goes here
%   Detailed explanation goes here
    M = [0 -v(3) v(2);...
        v(3) 0 -v(1);
        -v(2) v(1) 0];
end

