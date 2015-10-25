function [progress, done] = solveGraphLabels( obj )
    
    fprintf(1, 'Label rule... ');

    progress = 0;
    done = 1;
    obj.updateCellMs();
    
    solvedMs = cell(size(obj.labelList));
    parfor i = 1:numel(obj.labelList)
        label = obj.labelList{i};
        solvedMs{i} = label.computeMDirect();
    end
    
    labelString = '';
    
    for i = 1:numel(obj.labelList)
        solvedM = solvedMs{i};
        if ~isempty(solvedM)
            progress = 1;
            labelString = sprintf('%s    label = ''%s''\n', labelString, obj.labelList{i}.name);
            obj.labelList{i}.setM(solvedM);
        elseif ~obj.labelList{i}.isSolved()
            done = 0;
        end
    end
    
	if done
		fprintf(1, 'done.\n');
	elseif progress
		fprintf(1, 'progress.\n');
	else
		fprintf(1, 'no progress.\n');
	end
    
    if progress
        fprintf(1, '%s', labelString);
    end
end

