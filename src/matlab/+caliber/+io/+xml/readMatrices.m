function [ Ms ] = readMatrices( xmlNode )
%READMATRICES 
    Ms = {};
    children = xmlNode.getChildNodes();
    for i = 1:children.getLength()
        child = children.item(i-1);
        switch char(child.getNodeName())
            case 'matrix'
                Ms{end+1} = caliber.io.xml.readMatrix(child);
            case 'unknown'
                Ms{end+1} = [];
            case 'unknowns'
                if child.hasChildNodes()
                    n = str2double(child.getFirstChild().getNodeValue());
                else
                    n = 1;
                end
                for j = 1:n
                    Ms{end+1} = [];
                end
        end
    end
end
