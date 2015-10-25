function states = readStates(xmlNode)
    states = containers.Map();
    children = xmlNode.getChildNodes();
    
    for i = 1:children.getLength()
        child = children.item(i-1);
        if strcmp(child.getNodeName(), 'state')
            [node, stateIndex] = readState(child);
            states(node) = stateIndex;
        end
    end
end

function [node, stateIndex] = readState(xmlNode)
    children = xmlNode.getChildNodes();
    
    for i = 1:children.getLength()
        child = children.item(i-1);
        switch char(child.getNodeName())
            case 'node'
                node = char(child.getFirstChild().getNodeValue());
            case 'stateIndex'
                stateIndex = str2double(child.getFirstChild().getNodeValue());
        end
    end
end