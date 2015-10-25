function [ rnoise, tnoise, Mnoise ] = randM( rnoise, tnoise, rotFunc )
%RANDM Summary of this function goes here
%   Detailed explanation goes here
    rnoise = (2 * rand(3, 1) - 1) * rnoise;
    tnoise = (2 * rand(3, 1) - 1) * tnoise;
    Rnoise = rotFunc(rnoise);
    Mnoise = [Rnoise tnoise; 0 0 0 1];
end

