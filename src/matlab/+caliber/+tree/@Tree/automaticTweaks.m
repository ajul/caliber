function [ tweakSpecs ] = automaticTweaks( obj, mode )
%AUTOMATICTWEAKS Summary of this function goes here
%   Detailed explanation goes here
    
    tweakSpecs = {};
    
    hasUnknownTransformations = 0;
    
    for i = 1:length(obj.nodeList)
        node = obj.nodeList{i};
        keys = fieldnames(node.data);
        
        stateIndices = ~node.isKnown();
        if any(stateIndices)
            hasUnknownTransformations = 1;
        end
        
        for j = 1:length(keys)
            k = keys{j};
            switch mode
				case 'extrinsic'
					switch k
						case {'r', 't'}
							if any(stateIndices)
								tweakSpecs = [tweakSpecs; {node.name, k, 'all', stateIndices}];
							end
					end
				otherwise
					switch k
						case 'resolution'
							% generally not a parameter
						case 'K'
							tweakSpecs = [tweakSpecs; {node.name, k, logical([1 0 1; 0 1 1; 0 0 0]), []}];
						case {'r', 't'}
							if any(stateIndices)
								tweakSpecs = [tweakSpecs; {node.name, k, 'all', stateIndices}];
							end
						otherwise
							tweakSpecs = [tweakSpecs; {node.name, k, 'all', []}];
					end
            end
        end
    end
    
    if ~hasUnknownTransformations
        warning('caliber:tree', 'automaticTweaks() found no unknown transformations--did you remember to call it before Initializer.solve()?');
    end
end

