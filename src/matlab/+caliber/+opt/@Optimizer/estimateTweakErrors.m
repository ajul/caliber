function paramErrors = estimateTweakErrors(obj)
    J = obj.computeErrorJacobian();
    estJinv = sqrt(diag(inv(J' * J)));
    errors = obj.computeErrors('weighted');
    sigma = std(errors);
    paramErrors = estJinv * sigma;
end
