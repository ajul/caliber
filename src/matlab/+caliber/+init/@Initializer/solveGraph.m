function allLabelsSolved = solveGraph(obj, options)
    fprintf('Starting GraphInit.solveGraph()...\n');
    fprintf('    Number of vertices = %u\n', length(obj.vertexNames));
    obj.initSolve();
    
    fprintf('    Number of labels = %u\n', length(obj.labelList));
    
    obj.tolR = caliber.init.optionsGet(options, 'TolR', 1e-2);
    fprintf('    Rotational tolerance = %g\n', obj.tolR);
    
    sceneSize = obj.tree.estimateSceneSize('ObservationDistance');
    obj.tolT = caliber.init.optionsGet(options, 'TolT', 1e-2 * sceneSize);
    fprintf('    Translational tolerance = %g\n', obj.tolT);
    
    obj.dofSoFar = 0;
    
    obj.maxDoFPerTransformation = caliber.init.optionsGet(options, 'MaxDoFPerTransformation', 6);
    fprintf('    Maximum DoF per transformation = %u\n', obj.maxDoFPerTransformation);
    
    obj.maxDoFTotal = caliber.init.optionsGet(options, 'MaxDoFTotal', inf);
    fprintf('    Maximum DoF total = %d\n', obj.maxDoFTotal);
    
    labelsDone = 0;

    while 1
        [progress, MsDone] = obj.solveGraphDirect();
        if MsDone
            if ~labelsDone
                obj.solveGraphLabels();
            end
            break;
        elseif progress
            continue;
        end
        
        [progress, labelsDone] = obj.solveGraphLabels();
        if progress
            if MsDone
                break
            else
                continue
            end
        end
        
        progress = obj.solveGraphAX_XB();
        
        if progress
            continue
        end
        
        break;
    end

    % obj.normalize();

    obj.updateMs();
    obj.updateCellMs();

    allLabelsSolved = 1;
    for i = 1:length(obj.labelList)
        if ~obj.labelList{i}.isSolved()
            allLabelsSolved = 0;
            break;
        end
    end
    
    if allLabelsSolved
        fprintf('GraphInit.solve() finished with complete solution.\n');
        fprintf('    DoF total = %d\n', obj.dofSoFar);
    else
        fprintf('GraphInit.solve() stopped with incomplete solution.\n');
    end
end
