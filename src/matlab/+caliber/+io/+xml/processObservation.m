function processObservation(initOpt, xmlNode)
    children = xmlNode.getChildNodes();
    
    for i = 1:children.getLength()
        child = children.item(i-1);
        weight = 1;
        switch char(child.getNodeName())
            case 'camera'
                cameraNode = char(child.getFirstChild().getNodeValue());
            case 'pointset'
                pointNode = char(child.getFirstChild().getNodeValue());
            case 'imagePoints'
                imagePoints = caliber.io.xml.readMatrix(child);
            case 'worldPoints'
                worldPoints = caliber.io.xml.readMatrix(child);
            case 'Q'
                Q = caliber.io.xml.readMatrix(child);
            case 'states'
                states = caliber.io.xml.readStates(child);
            case 'weight'
                weight = str2double(child.getFirstChild().getNodeValue());
            case 'bouguet'
                [ imagePoints, worldPoints, ~, ~, Q ] = readBouguet(child);
        end
        initOpt.addObservation(cameraNode, pointNode, imagePoints, worldPoints, Q, states, weight)
    end
end

function [ imagePoints, worldPoints, Q ] = readBouguet(xmlNode)
    children = xmlNode.getChildNodes();
    index = 1;
    for i = 1:children.getLength()
        child = children.item(i-1);
        switch char(child.getNodeName())
            case 'resultFile'
                resultFile = char(child.getFirstChild().getNodeValue());
            case 'index'
                index = str2double(child.getFirstChild().getNodeValue());
        end
    end
    
    [ imagePoints, worldPoints, ~, ~, Q ] = caliber.io.bouguet(resultFile, index);
    imagePoints = imagePoints{1};
    worldPoints = worldPoints{1};
end
