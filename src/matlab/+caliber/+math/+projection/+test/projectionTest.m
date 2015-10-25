function projectionTest(projectFn, h, v1, d1, v2, d2)
    v1h = v1 + h * d1;
    v2h = v2 + h * d2;
    
    outPoints = projectFn(v1, v2);
    outPointsh1 = projectFn(v1h, v2);
    outPointsh2 = projectFn(v1, v2h);
    fd1 = (outPointsh1 - outPoints) / h
    fd2 = (outPointsh2 - outPoints) / h
    comp1 = projectFn(v1, v2, 1, d1)
    comp2 = projectFn(v1, v2, 2, d2)
end
