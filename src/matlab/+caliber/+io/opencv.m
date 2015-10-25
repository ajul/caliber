function [imagePoints, worldPoints, Q, data, frameInds] = opencv( resultfile, indices )
%BOUGUET Reads an OpenCV calibration result from a YAML file and returns observations
%
% This script requires the YAMLMatlab library, developed with version 0.4.3
%    https://code.google.com/p/yamlmatlab/

    tmpfi = fopen('foobar-49203.yml', 'w');
    infi = fopen(resultfile, 'r');

    while ~feof(infi)
        s = fgetl(infi);
        if ~strcmp(s(1:5), '%YAML')
            fwrite(tmpfi, strrep(s, '!!opencv-matrix', ''));
            fwrite(tmpfi, char(10));
        end
    end

    fclose(infi);
    fclose(tmpfi);

    yaml_data = ReadYaml('foobar-49203.yml');

    if strcmp(indices, 'all')
        indices = 1:yaml_data.nframes;
    end

    distortion_coefficients = convert_matrix(yaml_data.distortion_coefficients);
    kc = distortion_coefficients([1;2;5]);

    K = convert_matrix(yaml_data.camera_matrix);
    resolution = [yaml_data.image_width, yaml_data.image_height];

    extrinsic_parameters = convert_matrix(yaml_data.extrinsic_parameters);
    image_points = convert_matrix(yaml_data.image_points);

    [ch_x, ch_y] = ndgrid(0:yaml_data.board_width-1, 0:yaml_data.board_height-1);
    checker_points = yaml_data.square_size * [ch_x(:), ch_y(:), zeros(yaml_data.board_height * yaml_data.board_width,1)]';

    numIndices = length(indices);
    imagePoints = cell(numIndices, 1);
    worldPoints = cell(numIndices, 1);
    Q = cell(numIndices, 1);
    
    for i = 1:numIndices
        index = indices(i);

        R = rodrigues(extrinsic_parameters(index, 1:3)');
        t = extrinsic_parameters(index, 4:6)';
                
        Q{i} = [R t; 0 0 0 1];
        worldPoints{i} = checker_points;
        imagePoints{i} = reshape(image_points(:,index,:), [2, yaml_data.board_height * yaml_data.board_width]);
    end
    
    data = struct();
    data.K = K;
    data.kc = kc;
    data.resolution = resolution;
    
    frameInds = convert_matrix(yaml_data.used_frames) + 1;


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
