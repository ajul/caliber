function m = mod1( a, b )
%INDEXMOD Modulus using start-at-1 indexing.
    m = mod(a - 1, b) + 1;
end

