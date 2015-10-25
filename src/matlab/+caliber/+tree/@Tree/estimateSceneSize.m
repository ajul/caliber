function s = estimateSceneSize( obj, mode )
%ESTIMATESCENESIZE (Very roughly) estimates the size of the scene.
    if nargin < 2
        mode = 'BoundingBox';
    end
    
    switch mode
        case 'BoundingBox'
            obj.updateFull();

            numObs = numel(obj.observations);

            t = zeros(3, 2*numObs);

            for i = 1:numObs
                observation = obj.observations{i};
                cameraM = observation.cameraNode.depthM(observation.cameraStateIndices, 1);
                pointM = observation.pointNode.depthM(observation.pointStateIndices, 1);
                t(:, 2*i-1) = cameraM(1:3, 4);
                t(:, 2*i) = pointM(1:3, 4);
            end

            s = max(max(t, [], 2) - min(t, [], 2));
            if s < eps
                s = 1;
            end
        case 'ObservationDistance'
            numObs = numel(obj.observations);
            s = 0;
            for i = 1:numObs
                observation = obj.observations{i};
                Qs = observation.estimatedTransformations();
                for j = 1:size(Qs, 1)
                    Q = Qs{j, 5};
                    s = max(s, norm(Q(1:3, 4)));
                end
            end
    end
end

