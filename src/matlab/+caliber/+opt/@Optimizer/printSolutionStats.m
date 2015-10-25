function printSolutionStats( obj )
%PRINTSOLUTIONSTATS 
    residual = obj.computeErrors('unweighted', 1);
    merged = cell2mat(residual);
    [ rSq, rmsError, meanError, medianError, minError, maxError ] = ...
        caliber.math.errorStats( merged );
    fprintf(1, 'Solution statistics:\n');
    fprintf(1, '    Residual 2-norm:  %e\n', rSq);
    fprintf(1, '    RMS residual:     %e\n', rmsError);
    fprintf(1, '    Mean residual:    %e\n', meanError);
    fprintf(1, '    Median residual:  %e\n', medianError);
    fprintf(1, '    Minimum residual: %e\n', minError);
    fprintf(1, '    Maximum residual: %e\n', maxError);
    
    individualNorms = zeros(numel(residual), 1);
    for i = 1:numel(residual)
        individualNorms(i) = norm(residual{i}, 'fro');
    end
    [~, ind] = max(individualNorms);
    fprintf(1, '    Worst observation: %d\n', ind);
end

