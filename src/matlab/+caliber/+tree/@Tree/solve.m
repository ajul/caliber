function [initializer, optimizer] = solve( obj, tweaks, initializerOptions, optimizerOptions )
%SOLVE 
    
    if nargin < 3
        initializerOptions = caliber.init.optionsSet();
    end
    
    if nargin < 4
        optimizerOptions = optimset();
    end
    
    initializer = caliber.init.Initializer(obj);
    optimizer = caliber.opt.Optimizer(obj);
    optimizer.addTweaks(tweaks);
    success = initializer.solve(initializerOptions);
    
    if ~success
        optimizer = [];
        return;
    end
    
    optimizer.solve(optimizerOptions);
end