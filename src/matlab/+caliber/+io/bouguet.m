function [imagePoints, worldPoints, Q, data] = bouguet( resultfile, indices )
%BOUGUET Reads a Bouguet Calib_results.mat file and returns observations

    if strcmp(indices, 'all')
        data = load(resultfile, 'n_ima');
        indices = 1:data.n_ima;
    end
    
    data = load(resultfile, 'KK', 'kc', 'est_dist', 'nx', 'ny');
    
    est_dist = data.est_dist;
    if est_dist(5)
        kc = data.kc([1;2;5]);
    elseif est_dist(2)
        kc = data.kc([1;2]);
    elseif est_dist(1)
        kc = data.kc(1);
    else
        kc = [];
    end
    
    K = data.KK;
    resolution = [data.nx, data.ny];
    
    numIndices = length(indices);
    imagePoints = cell(numIndices, 1);
    worldPoints = cell(numIndices, 1);
    Q = cell(numIndices, 1);
    
    for i = 1:numIndices
        index = indices(i);
        Rc_index = sprintf('Rc_%d', index);
        Tc_index = sprintf('Tc_%d', index);
        X_index = sprintf('X_%d', index);
        x_index = sprintf('x_%d', index);
        
        data = load(resultfile, Rc_index, Tc_index, X_index, x_index);
        
        Q{i} = [data.(Rc_index) data.(Tc_index); 0 0 0 1];
        worldPoints{i} = data.(X_index);
        imagePoints{i} = data.(x_index);
    end
    
    data = struct();
    data.K = K;
    data.kc = kc;
    data.resolution = resolution;
end
