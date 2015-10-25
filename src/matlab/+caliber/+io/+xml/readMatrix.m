function M = readMatrix( xmlNode )
%PROCESSMATRIX 
    M = [];
    children = xmlNode.getChildNodes();
    for i = 1:children.getLength()
        child = children.item(i-1);
        if strcmp(child.getNodeName(), 'mr')
            M = [M; readMatrixRow(child)];
        end
    end
end

function Mr = readMatrixRow( xmlNode )
%PROCESSMATRIX 
    Mr = [];
    children = xmlNode.getChildNodes();
    for i = 1:children.getLength()
        child = children.item(i-1);
        if strcmp(child.getNodeName(), 'md')
            Mr = [Mr str2double(child.getFirstChild().getNodeValue())];
        end
    end
end
