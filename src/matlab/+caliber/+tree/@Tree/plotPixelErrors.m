 function plotPixelErrors(obj, predict)
    % plots image errors
    
    tStart = tic;
    
    if nargin >= 2 && predict
        obsList = obj.predictions;
    else
        obsList = obj.observations;
    end
    
    obj.updateFull();

    numObs = numel(obsList);
    data = cell(numObs, 1);
    
    for i=1:numObs;
        data{i} = obsList{i}.reprojectionError();
    end
    caliber.plot.plotPixelErrors(data);
    
    tElapsed = toc(tStart);
    fprintf(1, '%f seconds elapsed for Optimizer.plotPixelErrors()\n', tElapsed);
end
