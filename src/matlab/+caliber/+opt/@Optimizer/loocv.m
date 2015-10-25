function [optResiduals, predictErrors] = loocv( obj, optimizerOptions )
%LOOCV Summary of this function goes here
%   Detailed explanation goes here
    if nargin < 2
        optimizerOptions = optimset();
    end
    
    tree = obj.tree;
    
    n = numel(tree.observations);

    predictErrors = cell(n, 1);
    parfor i = 1:n
        cloneTree = caliber.tree.Tree();
        for j = 1:numel(tree.nodeList)
            cloneTree.addNode(tree.nodeList{j}.clone());
        end
        for j = 1:numel(tree.observations)
            if i == j
                weight = 0;
            else
                weight = tree.observationWeights(j);
            end
            cloneTree.addObservation(tree.observations{j}.clone(), weight);
        end

        cloneOpt = caliber.opt.Optimizer(cloneTree);
        for j = 1:numel(obj.tweaks)
            tweak = obj.tweaks{j};
            cloneOpt.addTweaks({tweak.node.name, tweak.paramName, logical(tweak.paramIndices), []});
        end
        cloneOpt.solve(optimizerOptions);
        residual = cloneOpt.computeErrors('predict');
        predictErrors{i} = residual;
        % subInitOpt.treeOpt.plotPixelErrors(1);
        cloneOpt.printSolutionInfo(); 
    end

    obj.solve(optimizerOptions);
    optResiduals = obj.computeErrors();

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

