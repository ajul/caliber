function readXML( initOpt, xmlFile )
%TREEFROMXML Summary of this function goes here
%   Detailed explanation goes here
    import caliber.io.xml.*
    doc = xmlread(xmlFile);
    root = doc.getFirstChild();
    children = root.getChildNodes();
    for i = 1:children.getLength()
        child = children.item(i-1);
        switch char(child.getNodeName())
            case 'nodes'
                processNodes(initOpt, child);
            case 'observations'
                processObservations(initOpt, child);
        end
    end
end

function processNodes(initOpt, xmlNode)
    children = xmlNode.getChildNodes();
    for i = 1:children.getLength()
        child = children.item(i-1);
        if strcmp(child.getNodeName(), 'node')
            caliber.io.xml.processNode(initOpt, child);
        end
    end
end

function processObservations(initOpt, xmlNode)
    children = xmlNode.getChildNodes();
    for i = 1:children.getLength()
        child = children.item(i-1);
        switch char(child.getNodeName())
            case 'observation'
                caliber.io.xml.processObservation(initOpt, child);
            case 'bouguetSet'
                caliber.io.xml.processBouguetSet(initOpt, child);
        end
    end
end
