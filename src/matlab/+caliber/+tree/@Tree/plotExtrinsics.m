function h = plotExtrinsics(obj, predict, scale)
    % plots extrinsics
    tStart = tic;
    
    if nargin < 3
        scale = 0.125;
    end
    
    if nargin >= 2 && predict
        obsList = obj.predictions;
    else
        obsList = obj.observations;
    end
    
    obj.updateFull();
    
    h = figure;
    hold on;
    axis equal;
    grid on;
    xlabel('x');
    ylabel('y');
    zlabel('z');
    
    numObs = length(obsList);
    s = obj.estimateSceneSize();
    for i = 1:numObs
        obsList{i}.drawExtrinsics(s * scale);
    end
    
    hold off;
    
	tElapsed = toc(tStart);
	fprintf(1, '%f seconds elapsed for Optimizer.plotExtrinsics()\n', tElapsed);
end
