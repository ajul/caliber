function updateFull( obj )
%INITIALIZEOBSERVATIONS Summary of this function goes here
%   Detailed explanation goes here
    for i = 1:length(obj.observations)
        obj.observations{i}.updateFull(obj);
    end

    for i = 1:length(obj.predictions)
        obj.predictions{i}.updateFull(obj);
    end
    
    obj.updateIteration(1);
end

