function [progress, done] = solveDirect( obj )

    fprintf(1, 'Direct rule... ');

    obj.updateMs();
    
    oldSolved = obj.getHomogeneous();
    
    obj.MsDirty = 1;
    obj.Ms = obj.Ms * obj.Ms;
    
    newSolved = obj.getHomogeneous();
    
    H = max(newSolved, 1);
    obj.Ms = obj.Ms ./ kron(H, ones(4));
    
    progress = any(any(newSolved & ~oldSolved));
    done = all(all(newSolved));
	if done
		fprintf(1, 'done.\n');
	elseif progress
		fprintf(1, 'progress.\n');
	else
		fprintf(1, 'no progress.\n');
	end
end
