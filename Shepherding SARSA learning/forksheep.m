function [] = forksheep(A)
global xs ys % position variable

for nsheep = 1:20
    xs(nsheep) = A(nsheep,1);
    ys(nsheep) = A(nsheep,2);
end