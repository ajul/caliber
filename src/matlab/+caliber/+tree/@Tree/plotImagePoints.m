function plotImagePoints(obj, predict)
    tStart = tic;

    if nargin >= 2 && predict
        obsList = obj.predictions;
    else
        obsList = obj.observations;
    end
    
    obj.updateFull();
    
    numObs = length(obsList);
    for i = 1:numObs
        obsList{i}.plotImagePoints();
    end
    
    tElapsed = toc(tStart);
    fprintf(1, '%f seconds elapsed for Optimizer.plotImagePoints()\n', tElapsed);
end
