function fullySolved = solve( obj, options )
%SOLVE Summary of this function goes here
    tStart = tic;
    
    if nargin < 2
        options = caliber.init.optionsSet();
    end
    
    obj.solvePre(options);

    fullySolved = obj.solveGraph(options);
    
    obj.solvePost();

    tElapsed = toc(tStart);
    fprintf('%f seconds elapsed for Initializer.solve()\n', tElapsed);

end

