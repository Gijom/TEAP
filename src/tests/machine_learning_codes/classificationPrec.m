function [classificationRate, prec, recall, f1s] = classificationPrec(labels,  groundTruth, nbClasses)
%Mohammad Soleymani cvml Lab., University of Geneva, 2009
%mohammad.soleymani@unige.ch
%function [classificationRate, prec,f1s,recall,accuracy] =
%classificationPrec(labels, groundTruth, nbClasses)
%This function gives you precisions, recalls, f1 scores for each class
%separately and classification rate overally
%it is assumed that the labels (estimated and correct) are numeric and they
%start by 1 and continues. e.x. for binary classification labels should be
%1 and 2
%inputs:
% labels: the esimated labels
% groundTruth: ground truth (correct labels)
% nbClasses: number of classes
%outputs:
%classificationRate : the number of correctly classified samples divided by
%all samples
% prec: precisions for each class
% recall: recall for each class
% f1s: f1 score for each class

labels = labels(:);
groundTruth = groundTruth(:);
if nargin < 3
    nbClasses = max(groundTruth);
end
prec = zeros(1, nbClasses);
recall = zeros(1, nbClasses);
for i = 1:nbClasses
    TP = sum(labels==i & groundTruth==i);
    FP = sum(labels==i & groundTruth~=i);
    FN = sum(labels~=i & groundTruth==i);
    prec(i) = TP/(TP+FP);
    recall(i) = TP/(TP+FN);
end

f1s = 2*prec.*recall./(prec+recall);
classificationRate =  sum(labels==groundTruth)/length(labels);
f1s(isnan(f1s)) = 0;
