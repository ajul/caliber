function updateIteration( obj, includePredictions )
%UPDATEOBSERVATIONS 
    for i = 1:length(obj.observations)
        obj.observations{i}.updateIteration();
    end
    
    if includePredictions
        for i = 1:length(obj.predictions)
            obj.predictions{i}.updateIteration();
        end
    end

end

