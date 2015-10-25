close all;

tree = caliber.test.ladybug00;
K = tree.nodeData('camera', 'K');
kc = tree.nodeData('camera', 'kc');
resolution = tree.nodeData('camera', 'resolution');

caliber.plot.plotRectification(K, kc, resolution, 32);
