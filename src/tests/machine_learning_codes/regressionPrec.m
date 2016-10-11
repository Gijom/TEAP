function [evals] = regressionPrec(labels,  groundTruth)
%Mohammad Soleymani Imperial College London, 2013
%m.soleymani@imperial.ac.uk
%function [evals] =
%regressionPrec(labels, groundTruth)
%This function gives you pearson, Kendall tau ranking correlation, linear
%distances
%it is assumed that the labels (estimated and correct) are numeric
%inputs:
% labels: the esimated labels
% groundTruth: ground truth (correct labels)
%outputs:
%evals : the structure with all the outputs mentioned above

labels = labels(:);
groundTruth = groundTruth(:);
[r p]= corr([groundTruth labels]);
evals.rho  = r(2,1);
evals.p_pearson = p(2,1);      
[r,p] = corr([groundTruth labels],'type','Spearman');
evals.r_sp  = r(2,1);
evals.p_sp = p(2,1);
evals.MSE_avg = mean((groundTruth-labels).^2);
evals.RMSE = sqrt(mean((groundTruth-labels).^2));
evals.MSE_std = std((groundTruth-labels).^2);
evals.MAE = mean(abs(groundTruth-labels));

