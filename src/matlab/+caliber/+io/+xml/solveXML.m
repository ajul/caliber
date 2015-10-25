function optimizer = solveXML( xmlFile )
%SOLVEXML Reads and solves a problem defined in an XML file.
    initOpt = caliber.initopt.InitOpt();
    caliber.io.xml.readXML(initOpt, xmlFile);
    optimizer = initOpt.solve();
end

