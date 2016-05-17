function [MSE] = multiScaleEntropy(data,depth)
%calculates Multiscale entropy; Kim and Andre PAMI 2008
r = 0.2*std(data);
M_max = 2;
MSE = zeros(1,depth);

if (length(data)/depth)<20
    depth = floor(length(data)/20);
end
for i = 1:depth
    temp =  sampenc(multiScale(data,i),M_max,r);
    MSE(i) = temp(2);
end


function scaledVect = multiScale(vect,factorOf)
if factorOf == 1
    scaledVect = vect;
    return
else
    vect = vect(1:floor(length(vect)/factorOf)*factorOf);
    scaledVect = mean(reshape(vect,[factorOf, floor(length(vect)/factorOf)]));
end
