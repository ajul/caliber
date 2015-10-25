function progress = solveGraphAX_XB( obj )
    fprintf(1, 'AX = XB rule... ');

    progress = 0;
    obj.updateCellMs();

    solvedMs = cell(size(obj.labelList));
    dofs = zeros(size(obj.labelList));
    parfor i = 1:numel(obj.labelList)
        label = obj.labelList{i};
        [solvedMs{i}, dofs(i)] = label.computeMAX_XB();
    end

    [dof, idx] = min(dofs);

    if dof <= obj.maxDoFPerTransformation && ...
            dof + obj.dofSoFar <= obj.maxDoFTotal
        progress = 1;
        obj.labelList{idx}.setM(solvedMs{idx});
        obj.dofSoFar = obj.dofSoFar + dof;
    end

    if progress
        labelName = obj.labelList{idx}.name;
        switch(dof)
            case 0
                dofDesc = 'monparallel screw axes, unique solution';
            case 1
                dofDesc = 'parallel screw axes';
            case 2
                dofDesc = 'coincident screw axes (e.g. revolute joint)';
            case 3
                dofDesc = 'nonparallel translation (e.g. 2D prismatic joint)';
            case 4
                dofDesc = 'parallel translation (e.g. 1D prismatic joint)';
            case 6
                dofDesc = 'no information, setting to identity';
            otherwise
                dofDesc = 'not implemented';
        end
        fprintf(1, 'progress.\n    Label = ''%s''\n    DoF = %d : %s\n', labelName, dof, dofDesc);
        return;
    else
        fprintf(1, 'no progress.\n');
        if dof > obj.maxDoFPerTransformation
            fprintf(1, '    Exceeded maximum DoF per transformation.\n');
        end
        if dof + obj.dofSoFar > obj.maxDoFTotal
            fprintf(1, '    Exceeded maximum DoF total.\n');
        end
    end
end

