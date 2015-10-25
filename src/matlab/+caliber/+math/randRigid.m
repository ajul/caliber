function [varargout] = randRigid(maxRot, maxTrans)
%RANDRIGID Random rigid transformation matrix.
    if nargin < 1
        maxRot = 1;
    end
    
    if nargin < 2
        maxTrans = 1;
    end
    for i=1:nargout
        varargout{i} = randRigidSingle(maxRot, maxTrans);
    end
end

function M = randRigidSingle(maxRot, maxTrans)
    import caliber.math.randRot
    import caliber.math.randVec
    M = [randRot(maxRot) randVec(maxTrans); 0 0 0 1];
end
