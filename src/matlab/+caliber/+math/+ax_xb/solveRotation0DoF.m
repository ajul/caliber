function [ R ] = solveRotation0DoF( ra, rb, tolR )
%SOLVEROTATION 
    n = size(ra, 2);
    
    if n < 2
        R = [];
    elseif n == 2
        AA = computeFrame(ra);

        if cond(AA) * tolR * tolR > 1
            R = [];
            return;
        end
        
        BB = computeFrame(rb);
        
        if cond(BB) * tolR * tolR > 1
            R = [];
            return;
        end
        
        R = AA / BB;
    else
        M = rb * ra';
        
        MM = M' * M;

        if cond(MM) * tolR * tolR > 1
            R = [];
            return;
        end
        
        R = sqrtm(MM) \ M';
    end

end

function RR = computeFrame(r)
    r1 = r(:, 1);
    r2 = r(:, 2);
    RR = [r1, r2, cross(r1, r2)];
end
