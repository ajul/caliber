import caliber.plot.*
import caliber.math.*
import caliber.math.projection.fullProjection

rotFunc = @axisAngle;

experiment = 'twoarm';  

switch(experiment)
    
    case 'stereo'
        load('caliber_data/stereo_03/opt.mat');
        c = initOpt.optimizer.observations{1}.imagePoints;
        p = initOpt.optimizer.observations{1}.projectedImage(rotFunc);

        imageData = imread('caliber_data/stereo_03/c01.ppm');
        plotOnImage(imageData, c, p);

        c = initOpt.optimizer.observations{2}.imagePoints;
        p = initOpt.optimizer.observations{2}.projectedImage(rotFunc);

        imageData = imread('caliber_data/stereo_03/m01.ppm');
        plotOnImage(imageData, c, p);
        
    case 'spherical'
        load('caliber_data/spherical_00/opt.mat');
        c = initOpt.optimizer.observations{1}.imagePoints;
        p = initOpt.optimizer.observations{1}.projectedImage(rotFunc);
        
        imageData = imread('caliber_data/spherical_00/ppm/calibtest00.ppm');
        plotOnImage(imageData, c, p);
        
        c = initOpt.optimizer.observations{11}.imagePoints;
        p = initOpt.optimizer.observations{11}.projectedImage(rotFunc);
        
        imageData = imread('caliber_data/spherical_00/ppm/calibtest10.ppm');
        plotOnImage(imageData, c, p);
    case 'tablet'
        load('caliber_data/tablet02/opt.mat');
        oc = initOpt.optimizer.observations{1}.imagePoints;
        pc = initOpt.optimizer.observations{1}.projectedImage(rotFunc);
        om = initOpt.optimizer.observations{2}.imagePoints;
        pm = initOpt.optimizer.observations{2}.projectedImage(rotFunc);
        oct = initOpt.optimizer.observations{3}.imagePoints;
        pct = initOpt.optimizer.observations{3}.projectedImage(rotFunc);
        omt = initOpt.optimizer.observations{4}.imagePoints;
        pmt = initOpt.optimizer.observations{4}.projectedImage(rotFunc);
        ot = initOpt.optimizer.observations{5}.imagePoints;
        pt = initOpt.optimizer.observations{5}.projectedImage(rotFunc);

        imc = imread('caliber_data/tablet02/c01.ppm');
        imm = imread('caliber_data/tablet02/m01.ppm');
        imt = imread('caliber_data/tablet02/t01.jpg');
        
        plotOnImage(imc, [oc, oct], [pc pct]);
        
        hold on;
        obj = initOpt.optimizer.observations{1};
        M = obj.cameraNode.getRelativeM(initOpt.optimizer.nodes('tablet_camera'), obj.states, rotFunc);
        kc = obj.cameraNode.getkc(obj.states);
        K = obj.cameraNode.getK(obj.states);
        predCam = fullProjection(K, kc, M, [0;0;0]);
        scatter(predCam(1), predCam(2), 'g', 'd');
        hold off;
        
        plotOnImage(imm, [om, omt], [pm pmt]);
        hold on;
        obj = initOpt.optimizer.observations{2};
        M = obj.cameraNode.getRelativeM(initOpt.optimizer.nodes('tablet_camera'), obj.states, rotFunc);
        kc = obj.cameraNode.getkc(obj.states);
        K = obj.cameraNode.getK(obj.states);
        predCam = fullProjection(K, kc, M, [0;0;0]);
        scatter(predCam(1), predCam(2), 'g', 'd');
        hold off;
        
        plotOnImage(imt, ot, pt);
        
    case 'twoarm'
        load('caliber_data/cal2arms/opt.mat');
        o1 = initOpt.optimizer.observations{1}.imagePoints;
        p1 = initOpt.optimizer.observations{1}.projectedImage(rotFunc);
        o2 = initOpt.optimizer.observations{27}.imagePoints;
        p2 = initOpt.optimizer.observations{27}.projectedImage(rotFunc);
        
        imageData = imread('caliber_data/cal2arms/meas06.ppm');
        imageData = swapbytes(imageData);
        imageData = double(imageData(:, :, 2));
        imageData = imageData - min(min(imageData));
        imageData = imageData / max(max(imageData)) * 255;
        plotOnImage(imageData, [o1 o2], [p1 p2]);
        colormap gray;
        
end