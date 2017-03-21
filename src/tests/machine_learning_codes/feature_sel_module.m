function [iFeatSelected, train_data, test_data] = feature_sel_module(train_data, test_data, labelsTrain, parameters)
%feature selection module
iFeatSelected = [];
train_data(isnan(train_data)) = 0;
if ~isfield(parameters, 'pca_tresh')
    pca_tresh = 0.95;
else
    pca_tresh = parameters.pca_tresh;
end
if ~isfield(parameters, 'is_regression')
    parameters.is_regression = 0;
end
cca_tresh = 12;
nbFeatures = size(train_data,2);
switch parameters.featSelection             
    case 'forward'
        c = cvpartition(labelsTrain,'k',10);
        opts = statset('display','iter');
        classifier = 'diaglinear';
        priorP = ones(1,parameters.nbClasses)/parameters.nbClasses;
        fun = @(XT,yT,Xt,yt)...
            (((sum((yt==2)&(classify(Xt,XT,yT,classifier,priorP)==1))/sum(yt==2))*10+(sum((yt==1)&(classify(Xt,XT,yT,classifier,priorP)==2))/sum(yt==1)))/11);
        [inmodel, ~]= sequentialfs(fun,train_data,labelsTrain,'cv',c,'direction','forward', 'options',opts); %
        iFeatSelected = find(inmodel);
                case 'Fisher'
        [listFeatures,FC] = fisherCrit(train_data,labelsTrain, parameters.nbClasses);
       FisherThreshold = 0.3;
        iFeatSelected = listFeatures(FC>FisherThreshold);
        if length(iFeatSelected) < 3
            iFeatSelected = listFeatures(1:3);
        end

    case 'none'
        iFeatSelected = 1:size(train_data,2);
end
if isempty(iFeatSelected)
iFeatSelected = 1:nbFeatures;
train_data  = train_data(:,iFeatSelected);
test_data = test_data(:,iFeatSelected);
end
