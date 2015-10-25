[ tree, initializer, optimizer ] = caliber.test.ladybug00( );

caliber.plot.plotOnImage(imread('data/ladybug00/ladybug_1_001.bmp'), tree.observations{1}.imagePoints(), tree.observations{1}.projectedImage());
caliber.plot.plotOnImage(imread('data/ladybug00/ladybug_2_001.bmp'), tree.observations{14}.imagePoints(), tree.observations{14}.projectedImage());
caliber.plot.plotOnImage(imread('data/ladybug00/ladybug_3_001.bmp'), tree.observations{27}.imagePoints(), tree.observations{27}.projectedImage());
caliber.plot.plotOnImage(imread('data/ladybug00/ladybug_4_001.bmp'), tree.observations{40}.imagePoints(), tree.observations{40}.projectedImage());
caliber.plot.plotOnImage(imread('data/ladybug00/ladybug_5_001.bmp'), tree.observations{53}.imagePoints(), tree.observations{53}.projectedImage());