lambda = 2 
for i=1:100
    random_sample = poissrnd(lambda,1,100)>0.25
    save(sprintf('datafile_%02d',i),'random_sample');
    
end
