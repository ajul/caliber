function processNode(initOpt, xmlNode, parentName)
    if nargin < 3
        parentName = 'root';
    end
    children = xmlNode.getChildNodes();
    childNodes = {};
    K = [];
    kc = [];
    for i = 1:children.getLength()
        child = children.item(i-1);
        
        switch char(child.getNodeName())
            case 'name'
                name = char(child.getFirstChild().getNodeValue());
            case 'parent'
                parentName = char(child.getFirstChild().getNodeValue());
            case 'K'
                K = caliber.io.xml.readMatrix(child);
            case 'kc'
                kc = caliber.io.xml.readMatrix(child);
            case 'Ms'
                Ms = caliber.io.xml.readMatrices(child);
            case 'tweaks'
                tweaks = readTweaks(child);
            case 'bouguet'
                [K, kc] = readBouguet(child);
            case 'node'
                childNodes{end+1} = child;
        end
    end
    initOpt.addNode(name, parentName, K, kc, Ms, tweaks);
    for i = 1:length(childNodes)
        caliber.io.xml.processNode(initOpt, childNodes{i}, name);
    end
end

function tweaks = readTweaks(xmlNode)
    tweaks = {};
    children = xmlNode.getChildNodes();
    for i = 1:children.getLength()
        child = children.item(i-1);
        if strcmp(child.getNodeName(), 'tweak')
            tweaks = [tweaks; readTweak(child)];
        end
    end
end

function tweak = readTweak(xmlNode)
    states = [];
    paramNames = {};
    paramIndices = [];
    children = xmlNode.getChildNodes();
    for i = 1:children.getLength()
        child = children.item(i-1);
        switch char(child.getNodeName())
            case 'state'
                state = child.getFirstChild().getNodeValue();
                if strcmp(char(state), 'all')
                    states = 'all';
                elseif ~isa(states, 'char')
                    state = str2double(state);
                    states = [states state];
                end
            case 'parameterName'
                paramNames{end+1} = char(child.getFirstChild().getNodeValue());
            case 'parameterIndex'
                paramIndex = child.getFirstChild().getNodeValue();
                if strcmp(char(paramIndex), 'all')
                    paramIndices = 'all';
                elseif ~isa(states, 'char')
                    paramIndex = str2double(paramIndex);
                    paramIndices = [paramIndices paramIndex];
                end
        end
    end
    tweak = {states, paramNames, paramIndices};
end

function [ K, kc ] = readBouguet(xmlNode)
    children = xmlNode.getChildNodes();
    for i = 1:children.getLength()
        child = children.item(i-1);
        if strcmp(child.getNodeName(), 'resultFile')
            resultFile = char(child.getFirstChild().getNodeValue());
            [ ~, ~, K, kc, ~ ] = caliber.io.bouguet(resultFile, []);
            return;
        end
    end
end
