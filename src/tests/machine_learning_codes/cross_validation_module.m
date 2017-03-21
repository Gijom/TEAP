function [estimated, scores, evals]  = ...
    cross_validation_module(features, labels, participants_vect, parameters)
%Mohammad Soleymani October 2012
% IN :
%   features : [N*F] database to cross validate, N number of samples, F
%                    number of features
%   labels : [N*1] list of label of each sample, labels ranged from 1 to nbClasses
%   parameters.nbClasses : [1] number of classes in the dataset
%   parameters.classifier : [string] type of classifier to use :
%                       Fisher : LDA
% %                       FisherDiag : LDA with forced diagonal covariance matrix
%                       SVMLin, SVMPoly, SVMSigmoid, SVMRbf : SVM with different kernels
%                       KNN : K-nearest neigbours
%   parameters.nbFolds : [1] number of folds for the k fold cros-validation
% parameters.fusion: fusio method 'sum' 'product'
% parameters.cross_validation: 'leave-one-out', 'one-participant-out'
%   parameters. : [1] parameter is the parameter to find by using cross validation, for
%           example it will be the gamma value for SVM
% OUT :
%   evalMean : mean of the results of each fold
%   evalStd : variance of the results of each fold
%   listEval : list of results for each validation step

parameters.seq_labels = false;
if  ~isfield(parameters,'verbose')
    parameters.verbose = true;
end
labels = labels(:);

if ~isempty(participants_vect)
    participants_codes = unique(participants_vect);
end
if ~isfield(parameters,'nbFolds')
    parameters.nbFolds = 10;
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
nbTrials = size(features,1);
scores = zeros(nbTrials,parameters.nbClasses);
estimated = zeros(nbTrials,1);


%creating folds

if strcmp(parameters.cross_validation,'one-participant-out')
    parameters.nbFolds = length(participants_codes);
    fold = cell(parameters.nbFolds,1);
    for k = 1:parameters.nbFolds
        fold{k} = find(participants_vect == participants_codes(k));
    end
elseif strcmp(parameters.cross_validation,'leave-one-out')
    parameters.nbFolds = nbTrials;
    fold = cell(parameters.nbFolds,1);
    for k = 1:nbTrials
        fold{k} = k;
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% cross validations : classification
for k = 1:parameters.nbFolds
    if parameters.verbose
        fprintf('fold %d of %d\n',k,parameters.nbFolds);
    end
    %determination des ensembles d'apprentissages et de test
    iTest = fold{k};
    trainSet = setdiff(1:nbTrials,iTest);
    xTrain = features(trainSet,:);
    xTest = features(iTest,:);
    labelsTrain = labels(trainSet);
    xTrain, xTest] = normalization_module(xTrain, xTest, parameters);
    [~, xTrain, xTest] = feature_sel_module(xTrain, xTest, labelsTrain, parameters);
    [estimated(iTest), scores(iTest,:)]= classif_module(xTrain, [],xTest, labelsTrain, [], parameters);
    
    
end

if parameters.nbClasses>1
    [evals.classification_rate, evals.prec, evals.recall,evals.f1s] = classificationPrec(estimated, labels, parameters.nbClasses);
else
    [evals] = regressionPrec(estimated,  labels);
end



