function normalize( obj )
%NORMALIZE 
    import caliber.math.normalizeRigid
    obj.updateMs();
    obj.updateCellMs();
    
    H = logical(triu(obj.getHomogeneous() > 1));
    
    toNormalize = obj.cellMs(H);
    [rows, cols] = find(H);
    
    for i = 1:length(toNormalize)
        row = rows(i);
        col = cols(i);
        if col >= row
            obj.setCellM(row, col, normalizeRigid(toNormalize{i}));
        end
    end
end
