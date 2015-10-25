import caliber.math.*

n = 1000;
noise = 0.1;
Ms = cell(n, 1);

baseM = randRigid()

for i = 1:n
    Ms{i} = randRigid(noise, noise) * baseM;
end

estM = meanRigid(Ms)