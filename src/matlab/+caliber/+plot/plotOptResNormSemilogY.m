function stop = plotOptResNormSemilogY(x,optimValues,state)

stop = optimplotresnorm(x,optimValues,state);
set(gca, 'YScale', 'log');

end

