function [imagePoints, objectPoints, gantryStates, poseTransforms, cameraIntrinsics] = opencvGantry( filename )
%BOUGUET Reads an OpenCV calibration result from a YAML file and returns observations
%
% imagePoints: array of calibration points found in 2D image space (checkerboard corners)
% objectPoints: array of calibration points in local 3D space of the checkerboard (lie in XY plane so z==0)
% poseTransforms: array of transforms from object space to camera space (ie estimate pose of camera relative to checkerboard for each image)
% cameraIntrinsics: struct that encodes focal length, principal point, lens distortion model, etc (ie camera parameters that do not vary per image)
% gantryStates: struct that encodes state of the gantries robotic joints for each image
%
% Note: image space is measured in pixels while world&object space are measured in millimeters
%
% This script requires the YAMLMatlab library, developed with version 0.4.3
%    https://code.google.com/p/yamlmatlab/
%
% Copied&modified by Bruce to support gantry-specific fields that I need
% (and remove a few options I don't need, and added some extra comments)


    %first we create a temp file that strips out the (unrecognized) 
    %opencv-specific type specifiers so the YAML reader won't barf on them
    %also strips out the initial %YAML line which snakeYAML also does not like
    infi = fopen(filename, 'r');
    if (infi == -1)
        disp(['Error unable to open input file: ',filename]);
        return;
    end
    %create a name for a temporary file by adding a descriptive (hopefully unique) prefix to name of input file
    [inPath,inName,inExt] = fileparts(filename);
    tmpFilename = fullfile(inPath,strcat('tmp-deleteme-opencvGantry-',inName,inExt));
    assert(~exist(tmpFilename,'file'),'Error: temp file already exists.  Try deleting : %s',tmpFilename);
    if exist(tmpFilename, 'file') 
        disp(['Error temp file already exists, must delete first: ',tmpFilename]);
        return;
    end
    tmpfi = fopen(tmpFilename, 'w');
    if tmpfi == -1
        disp(['Error unable to open temp file: ',tmpFilename]);
        return;
    end
    while ~feof(infi)
        s = fgetl(infi);
        if ~strcmp(s(1:5), '%YAML')
            fwrite(tmpfi, strrep(s, '!!opencv-matrix', ''));
            fwrite(tmpfi, char(10));
        end
    end
    fclose(infi);
    fclose(tmpfi);

    %Now parse the resulting stripped YAML file
    yaml_data = ReadYaml(tmpFilename);
    delete(tmpFilename);

    numImages = yaml_data.nframes;
    resolution = [yaml_data.image_width, yaml_data.image_height];
    numPointsPerImage = 1;
    if isfield(yaml_data,'board_width')
        numPointsPerImage =  yaml_data.board_height * yaml_data.board_width;
    end
    
    %camera-calibration files have camera fields, but light-calibration
    %files do not, so check to see if such fields are present
    if isfield(yaml_data,'camera_matrix') 
        %camera data is present so parse it
        distortion_coefficients = convert_matrix(yaml_data.distortion_coefficients);
        kc = distortion_coefficients([1;2;5]); %appears to skip tangential components (px,py) and only use k1,k2,k3 radial coefficients (also excludes k4,k5,k6)
        if ~isequal(distortion_coefficients([3;4]),[0;0])
            warning('Caliber does not support tangential distortion in camera model.  Please disable it in openCV code');
        end
        if size(distortion_coefficients,2) > 5
            warning('Caliber does not support rational radial distortion model.  Please disable it in openCV code.');
        end
        K = convert_matrix(yaml_data.camera_matrix);
        
        cameraIntrinsics = struct();
        cameraIntrinsics.K = K;
        cameraIntrinsics.kc = kc;
        cameraIntrinsics.resolution = resolution;

        extrinsic_parameters = convert_matrix(yaml_data.extrinsic_parameters);
        poseTransforms = cell(numImages, 1);
        for i = 1:numImages
            R = rodrigues(extrinsic_parameters(i, 1:3)');
            t = extrinsic_parameters(i, 4:6)';
            poseTransforms{i} = [R t; 0 0 0 1];
        end
    else
        %no camera info in the file so set camera data to empty
        cameraIntrinsics = struct();
        poseTransforms = {};
    end

    %Get image and corresponding object points and convert them to expected output format
    image_points = convert_matrix(yaml_data.image_points);
    object_points = convert_matrix(yaml_data.object_points);

    imagePoints = cell(numImages, 1);
    objectPoints = cell(numImages, 1);
    
    for i = 1:numImages
        objectPoints{i} = reshape(object_points(:,i,:), [3, numPointsPerImage]);
        imagePoints{i} = reshape(image_points(:,i,:), [2,numPointsPerImage]);
    end

    %Now parse and convert gantry state data
    gantryStates = struct();
    gantryStates.ml = convert_matrix(yaml_data.gantry_ml);
    gantryStates.mc = convert_matrix(yaml_data.gantry_mc);
    gantryStates.mb = convert_matrix(yaml_data.gantry_mb);
    gantryStates.mo = convert_matrix(yaml_data.gantry_mo);
    

    function M = convert_matrix(matrix_cell)
        % decodes a matrix from opencv's YAML encoding

        if matrix_cell.dt(1) > '1' && matrix_cell.dt(1) <= '9'
            firstdim = matrix_cell.dt(1) - '0';
            M = permute(reshape(cell2mat(matrix_cell.data), firstdim, matrix_cell.cols, matrix_cell.rows), [1 3 2]);
        else
            M = reshape(cell2mat(matrix_cell.data), matrix_cell.cols, matrix_cell.rows)';
        end
        
    end


    function R = rodrigues(r)
        % r is a column 3-vector representing a rotation in scaled-axis form.
        % Returns the corresponding rotation matrix.

        theta = norm(r);
        r = r / theta;
        skewR = [0 -r(3) r(2); r(3) 0 -r(1); -r(2) r(1) 0];

        R = cos(theta) * eye(3,3) + (1 - cos(theta)) * r*r' + sin(theta) * skewR;

    end

end
