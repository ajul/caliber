function [optResiduals, predictErrors] = loocv(obj, tweaks, initializerOptions, optimizerOptions )
    if nargin < 3
        initializerOptions = caliber.init.optionsSet();
    end
    
    if nargin < 4
        optimizerOptions = optimset();
    end

    n = numel(obj.observations);

    predictErrors = cell(n, 1);
    parfor i = 1:n
        cloneTree = caliber.tree.Tree();
        for j = 1:numel(obj.nodeList)
            cloneTree.addNode(obj.nodeList{j}.clone());
        end
        for j = 1:numel(obj.observations)
            if i == j
                weight = 0;
            else
                weight = obj.observationWeights(j);
            end
            cloneTree.addObservation(obj.observations{j}.clone(), weight);
        end

        [~, optimizer] = cloneTree.solve(tweaks, initializerOptions, optimizerOptions);
        residual = optimizer.computeErrors('predict');
        predictErrors{i} = residual;
        % subInitOpt.treeOpt.plotPixelErrors(1);
        optimizer.printSolutionInfo(); 
    end

    [~, optimizer] = obj.solve(tweaks, initializerOptions, optimizerOptions);
    optResiduals = optimizer.computeErrors();

    if nargout >= 2
        [ rSq, rmsError, meanError, medianError, minError, maxError ] = ...
            caliber.math.errorStats( cell2mat(predictErrors) );
        fprintf(1, 'Prediction statistics:\n');
        fprintf(1, '    Residual 2-Norm:  %e\n', rSq);
        fprintf(1, '    RMS Residual:     %e\n', rmsError);
        fprintf(1, '    Mean Residual:    %e\n', meanError);
        fprintf(1, '    Median Residual:  %e\n', medianError);
        fprintf(1, '    Minimum Residual: %e\n', minError);
        fprintf(1, '    Maximum Residual: %e\n', maxError);
    end
    
    individualNorms = zeros(numel(predictErrors), 1);
    for i = 1:numel(predictErrors)
        individualNorms(i) = norm(predictErrors{i}, 'fro');
    end
    [~, ind] = max(individualNorms);
    fprintf(1, '    Worst prediction: %d\n', ind);
end
