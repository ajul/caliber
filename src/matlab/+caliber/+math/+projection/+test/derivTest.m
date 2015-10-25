function derivTest( f, arg1, arg2, darg1, darg2, h)
%DERIVTEST 

    if nargin < 6
        h = 1e-6;
    end
    
    ret = f(arg1, arg2);
    
    fprintf('Testing argument 1...\n');
    
    computed = f(arg1, arg2, 1, darg1)
    finiteDifferences = (f(arg1 + h/2 * darg1, arg2) - f(arg1 - h/2 * darg1, arg2)) / h
    
    fprintf('Testing argument 2...\n');
    computed = f(arg1, arg2, 2, darg2)
    finiteDifferences = (f(arg1, arg2 + h/2 * darg2) - f(arg1, arg2 - h/2 * darg2)) / h

end

