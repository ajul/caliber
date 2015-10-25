classdef Optimizer < handle
    %Optimizer: Main class for nonlinear optimization stage
    
    properties
        
    end
    
    properties (SetAccess = protected)
        tree;
        
        tweaks;
        tweakLengths;
        lsqnonlinReturnValues; 
    end
    
    methods
        %% Constructor and problem definition
        function obj = Optimizer(tree)
            % Constructor.
            obj.tree = tree;
            obj.tweaks = {};
            obj.tweakLengths = [];
            obj.lsqnonlinReturnValues = [];
        end
        
        function addTweaks(obj, tweakSpecs)
            if ischar(tweakSpecs)
                tweakSpecs = obj.tree.automaticTweaks(tweakSpecs);
            end
            
            for i = 1:size(tweakSpecs, 1)
                tweakSpec = tweakSpecs(i, :);
                nodes = tweakSpec{1};
                if ~iscell(nodes)
                    nodes = {nodes};
                end
                [paramNames, paramIndices, states] = tweakSpecs{i, 2:4};
                for j = 1:numel(nodes)
                    node = obj.tree.getNode(nodes{j});
                    
                    [currTweaks, currTweakLengths] = caliber.opt.Tweak.makeTweaks(node, paramNames, paramIndices, states );
                    obj.tweaks = [obj.tweaks; currTweaks];
                    obj.tweakLengths = [obj.tweakLengths; currTweakLengths];
                end
            end
        end
        
        %% Solve and result methods
        function [x,resnorm,residual,exitflag,output,lambda,jacobian] = solve(obj, options)
            % Solves the system using lsqnonlin. options are passed to the
            % solver; some options are set by default.
            import caliber.plot.plotOptResNormSemilogY
            import caliber.plot.plotOptStepSizeSemilogY
            
            tStart = tic;
            
            if isempty(obj.tree.observations)
                error('caliber:optimizer', 'Attempted to solve() with no observations.');
            end
            
            obj.updateFull();
            
            defaultopts = optimset('ScaleProblem', 'Jacobian', 'Jacobian', 'on', 'PlotFcns', {@plotOptResNormSemilogY; @plotOptStepSizeSemilogY});
            % defaultopts = optimset(defaultopts, 'DerivativeCheck', 'on');
            if nargin < 2
                options = defaultopts;
            else
                options = optimset(defaultopts, options);
            end
            [x,resnorm,residual,exitflag,output,lambda,jacobian] = lsqnonlin(obj.getOptFn, obj.getTweakValues(), [], [], options);
            obj.updateFull();

            
			tElapsed = toc(tStart);
			fprintf(1, '%f seconds elapsed for Optimizer.solve()\n', tElapsed);
            
            obj.lsqnonlinReturnValues = {x,resnorm,residual,exitflag,output,lambda,jacobian};
            obj.printSolutionStats();
        end
        
        function result = getTweakValues(obj)
            % Gets a column vector of tweaks values
            n = size(obj.tweaks, 1);
            result = cell(n, 1);
            for i = 1:n
                tweak = obj.tweaks{i};
                result{i} = tweak.getValues();
            end
            result = cell2mat(result);
        end
        
        function obj = setTweakValues(obj, values)
            % given a vector of tweak values, assigns them to the
            % appropriate nodes/parameters
            values = mat2cell(values, obj.tweakLengths);
            for i=1:length(obj.tweaks)
                obj.tweaks{i}.setValues(values{i});
            end
            
            obj.updateIteration(0);
        end
        
        function node = getNode(obj, nodeid)
            % Casts nodeid into a node handle.
            if isa(nodeid, 'char')
                node = obj.nodes(nodeid);
            elseif isnumeric(nodeid)
                node = obj.nodeList(nodeid);
            else
                node = nodeid;
            end
        end
        
        function errors = computeErrors(obj, mode, separate)
            % computes a vector of image errors
            if nargin < 2
                mode = 'unweighted';
            end
            
            if nargin < 3
                separate = 0;
            end
            
            switch(mode)
                case 'unweighted'
                    obsList = obj.tree.observations;
                    weighted = 0;
                case 'weighted'
                    obsList = obj.tree.observations;
                    weighted = 1;
                case 'predict'
                    obsList = obj.tree.predictions;
                    weighted = 0;
            end
            
            errors = cell(length(obsList), 1);
            for i=1:length(obsList)
                currErrors = obsList{i}.reprojectionError();
                if weighted
                    weight = obj.tree.observationWeights(i);
                    currErrors = currErrors * weight;
                end
                errors{i} = currErrors;
            end
            
            if ~separate
                errors = cell2mat(errors);
            end
        end
        
        function errorJacobian = computeErrorJacobian(obj)
            % computes the error Jacobian
            numTweaks = size(obj.tweaks, 1);
            numObs = length(obj.tree.observations);
            
            errorJacobian = cell(numObs, numTweaks);
            
            parfor i=1:numel(errorJacobian)
                [obsIndex, tweakIndex] = ind2sub([numObs, numTweaks], i);
                observation = obj.tree.observations{obsIndex};
                weight = obj.tree.observationWeights(obsIndex);
                tweak = obj.tweaks{tweakIndex};
                errorJacobian{i} = observation.reprojectionErrorJacobian(tweak) * weight;
            end
            errorJacobian = cell2mat(errorJacobian);
        end
        
        function stateIndices = getStateIndices(obj, states)
            if isnumeric(states)
                stateIndices = states;
                return;
            end
            stateIndices = zeros(length(obj.nodeList), 1);
            for i = 1:length(stateIndices)
                stateName = obj.nodeList{i}.name;
                if isKey(states, stateName)
                    stateIndices(i) = states(stateName);
                else
                    stateIndices(i) = 1;
                end
            end
        end
        
        function updateFull(obj)
            obj.tree.updateFull();
        end
        
        function updateIteration(obj, includePredictions)
            obj.tree.updateIteration(includePredictions);
        end
    end
    
    methods (Access = protected)
        
        function [imageErrors, errorJacobian] = errorFunction(obj, values)
            % assigns the tweak values and computes the error for each
            % image
            obj.setTweakValues(values);
            imageErrors = obj.computeErrors('weighted');
            
            if nargout > 1
                errorJacobian = obj.computeErrorJacobian();
            end
        end
        
        function optfn = getOptFn(obj)
            % "casts" the error function method into a function
            optfn = @(x) obj.errorFunction(x);
        end
    end
    
end

