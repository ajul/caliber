function processBouguetSet( initOpt, xmlNode )
    children = xmlNode.getChildNodes();
    for i = 1:children.getLength()
        child = children.item(i-1);
        switch char(child.getNodeName())
            case 'camera'
                cameraNode = char(child.getFirstChild().getNodeValue());
            case 'pointset'
                pointNode = char(child.getFirstChild().getNodeValue());
            case 'resultFile'
                resultFile = char(child.getFirstChild().getNodeValue());
            case 'observation'
                processObservationInSet( initOpt, child, cameraNode, pointNode, resultFile );
        end
    end
end

function processObservationInSet( initOpt, xmlNode, cameraNode, pointNode, resultFile )
    children = xmlNode.getChildNodes();
    for i = 1:children.getLength()
        child = children.item(i-1);
        weight = 1;
        switch char(child.getNodeName())
            case 'index'
                index = str2double(child.getFirstChild().getNodeValue());
            case 'states'
                states = caliber.io.xml.readStates(child);
            case 'weight'
                weight = str2double(child.getFirstChild().getNodeValue());
        end
    end
    [ imagePoints, worldPoints, ~, ~, Q ] = caliber.io.bouguet(resultFile, index);
    initOpt.addObservation(cameraNode, pointNode, imagePoints{1}, worldPoints{1}, Q{1}, states, weight);
end
