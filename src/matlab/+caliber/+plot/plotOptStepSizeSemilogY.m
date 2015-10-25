function stop = plotOptStepSizeSemilogY(x,optimValues,state)

stop = optimplotstepsize(x,optimValues,state);
set(gca, 'YScale', 'log');

end

