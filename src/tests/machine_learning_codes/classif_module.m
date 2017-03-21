function [estimated, scores, estimated_training, scores_training] = classif_module(xTrain, xVal, xTest, labels_train, labels_val, parameters)
%classification module,
%Mohammad Soleymani, 1 October 2012, m.soleymani@imperial.ac.uk
%IN:
%xTrain = training samples, if non sequnetional, each row is one sample, each
%column is a feature
%xTest = test samples
%labels_train = training ground truth labels_train
%prameters gridSearch 0 = no grid search for svm , 1 = grid search for svm
% OUT:
%estimated = estimated labels_train on the test set
%scores = confidence scores on the estimations
% estimated_training : classfied labels_train on training set


if nargin<6
    parameters.grid_search = 1;
    parameters.priorP = ones(1,parameters.nbClasses)/parameters.nbClasses;
end

if ~isfield(parameters, 'priorP')
    parameters.priorP = ones(1,parameters.nbClasses)/parameters.nbClasses;
end

labels_unique = unique(labels_train);
if ~isfield(parameters,'nbClasses')
    parameters.nbClasses = length(labels_unique);
end




switch(parameters.classifier)
    case 'SVMRbf'
        Cs = 2.^[-5:5];
        Gammas = 2.^[-5:5];
        if parameters.grid_search
            perf_metr_m = zeros(length(Cs),length(Gammas));
            perf_metr_sd = zeros(length(Cs),length(Gammas));
            parameters.nbFolds = 5;
            folds  = kfold_gen(labels_train,parameters);
            paramSV = '';
            for k = 1:parameters.nbClasses
                paramSV = [paramSV '-w' num2str(labels_unique(k)) ' ' num2str(length(labels_train)/sum(labels_train==labels_unique(k))) ' ' ];
            end
            for iC = 1:length(Cs)
                for iGamma = 1:length(Gammas)
                    svm_prms = ['-s 0 -t 2 -d 3 -c ' num2str(Cs(iC)) ' -h 0 -b 1 -g ' num2str(Gammas(iGamma)) ' ' paramSV];
                    lbls_fld = ones(size(labels_train));
                    nbTrials = length(labels_train);
                    for k = 1:parameters.nbFolds
                        test_set = folds{k};
                        train_set = setdiff(1:nbTrials,test_set);
                        model = svmtrain(labels_train(train_set), xTrain(train_set,:), svm_prms);
                        [lbls_fld(test_set)] = svmpredict(labels_train(test_set), ...
                            xTrain(test_set,:), model);
                    end
                    [~, ~, ~, f1s] = classificationPrec(lbls_fld,  labels_train, parameters.nbClasses);
                    perf_metr_m(iC,iGamma) = mean(f1s);
                    perf_metr_sd(iC,iGamma) = std(f1s);
                end
            end
            f1_max =  max(perf_metr_m(:));
            iBest = find(perf_metr_m == f1_max);
            if length(iBest)>1
                temp = perf_metr_sd(:);
                sd_min = min(temp(iBest));
            else
                sd_min = perf_metr_sd(iBest);
            end
            [iBestC iBestGamma] = find(perf_metr_m==f1_max & perf_metr_sd==sd_min,1,'first');
            disp(['Best C = ' num2str(Cs(iBestC)) ' Best Gamma  = ' num2str(Gammas(iBestGamma)) ', f1  = ' num2str(f1_max)]);
            svm_prms = ['-s 0 -t 2 -d 3 -c ' num2str(Cs(iBestC)) ' -h 0 -b 1 -g ' num2str(Gammas(iBestGamma)) ' ' paramSV];
        else
            svm_prms = '-s 0 -t 2 -d 3 -c 1 -g 0.15 -h 0 -b 1 ';
        end
        model = svmtrain(labels_train, xTrain, svm_prms);
        if parameters.is_fusion
            [estimated_training, ~, post_p_tr] = svmpredict(labels_train, xTrain, model,' -b 1');
            scores_training(:,model.Label) = post_p_tr;
        end
        [estimated, ~, post_p] = ...
            svmpredict(ones(size(xTest,1),1), xTest, model,' -b 1');
        scores(:,model.Label) = post_p;
    case 'ridge_reg'
        b = ridge(labels_train,xTrain,10,0);
        estimated= b(1)*ones(size(xTest,1),1);
        estimated = estimated+ xTest*b(2:end);
        estimated(estimated<parameters.lower_limit) = parameters.lower_limit;
        estimated(estimated>parameters.upper_limit) = parameters.upper_limit;
        scores = zeros(length(estimated),1);
    case 'lin_reg'
        xTrain = [ones(size(xTrain,1),1) xTrain];
        b = regress(labels_train,xTrain);
        estimated= b(1)*ones(size(xTest,1),1);
        estimated = estimated+ xTest*b(2:end);
        estimated(estimated<parameters.lower_limit) = parameters.lower_limit;
        estimated(estimated>parameters.upper_limit) = parameters.upper_limit;
        scores = zeros(length(estimated),1);
    case 'SVRLin'
        x = xTrain;
        y = labels_train;
        x_val = xVal;
        y_val = labels_val;
        clear xTrain
        if size(y,1)<size(y,2)
            y = y';
        end

        Cs = 10.^[-4:4];

        if parameters.grid_search
            perf_metr_m = zeros(length(Cs),1);
            perf_metr_sd = zeros(length(Cs),1);
            params = parameters;
            params.nbFolds = 3;
            folds  = kfold_gen(y,params);
            for iC = 1:length(Cs)

                svm_prms = ['-s 11 -c ' num2str(Cs(iC))];
                lbls_fld = ones(size(y));
                nbTrials = length(y);
                if isempty(xVal)
                    for k = 1:length(folds)
                        test_set = folds{k};
                        train_set = setdiff(1:nbTrials,test_set);
                        %model = svmtrain( y(train_set), x(train_set,:), svm_prms);
                        model = train(y(train_set), sparse(x(train_set,:)), svm_prms);
                        %                         [lbls_fld(test_set)] = svmpredict(y(test_set), ...
                        %                             x(test_set,:), model);
                        [lbls_fld(test_set)] = predict(y(test_set), ...
                            sparse(x(test_set,:)), model);
                    end
                    [evals] = regressionPrec(lbls_fld,  y);
                else
                    model = train(y, sparse(x), svm_prms);
                    %                         [lbls_fld(test_set)] = svmpredict(y(test_set), ...
                    %                             x(test_set,:), model);
                    lbls_est = predict(y_val, ...
                        sparse(x_val), model);
                    [evals] = regressionPrec(lbls_est,  y_val);
                end


                perf_metr_rho(iC) = evals.rho;
                perf_metr_rmse(iC) = evals.RMSE;
            end
            inds = find(perf_metr_rmse==min(perf_metr_rmse));
            if length(inds) >1

                iBestC = inds(perf_metr_rho(inds) == max(perf_metr_rho(inds)));
            else
                iBestC = inds;
            end
            rmse_min = min(perf_metr_rmse(:));

            disp(['Best C = ' num2str(Cs(iBestC))  ', RMSE  = ' num2str(rmse_min)]);

            svm_prms = ['-s 11 -c ' num2str(Cs(iBestC)) ];
        else
            svm_prms = '-s 11  -c 10 ';

        end

        model = train(y, sparse(x), svm_prms);
        estimated = predict(ones(size(xTest,1),1), sparse(xTest), model);
        estimated(estimated<parameters.lower_limit) = parameters.lower_limit;
        estimated(estimated>parameters.upper_limit) = parameters.upper_limit;


        scores = zeros(length(estimated),1);
    case 'SVR_RBF'
        addpath('../toolboxes/libsvm-3.19/matlab');
        x = xTrain;
        y = labels_train;

        x_val = xVal;
        y_val = labels_val;
        if size(y,1)<size(y,2)
            y = y';
        end

        Cs = 2.^[-3:3];%5 10 % instead of starting at -6
        Gammas = 1/size(xTrain,2);%2.^[-15:2:-9];%instead of +9
        %

        if parameters.grid_search
            perf_metr_m = zeros(length(Cs),length(Gammas));
            perf_metr_sd = zeros(length(Cs),1);
            parameters.nbFolds = 3;
            nbFolds = 2;
            folds  = kfold_gen(y,parameters);
            for iC = 1:length(Cs)
                for iGamma = 1:length(Gammas)
                    svm_prms = ['-s 4 -t 2 -d 3 -c ' num2str(Cs(iC)) ' -g ' num2str(Gammas(iGamma))  ' -h 0' ];
                    lbls_fld = ones(size(y));
                    nbTrials = length(y);
                    if isempty(xVal)

                        for k = 1:parameters.nbFolds
                            test_set = folds{k};
                            train_set = setdiff(1:nbTrials,test_set);
                            model = svmtrain(y(train_set), x(train_set,:), svm_prms);
                            [lbls_fld(test_set)] = svmpredict(y(test_set), ...
                                x(test_set,:), model);
                        end
                        [evals] = regressionPrec(lbls_fld,  y);
                    else
                        model = svmtrain(y, x, svm_prms);

                        lbls_est = svmpredict(y_val, ...
                            x_val, model);
                        [evals] = regressionPrec(lbls_est,  y_val);

                    end
                    perf_metr_rho(iC,iGamma) = evals.rho;
                    perf_metr_rmse(iC,iGamma) = evals.RMSE;
                end

            end
            inds = find(perf_metr_rmse==min(perf_metr_rmse(:)));
            if length(inds) >1

                iBests = inds(find(perf_metr_rho(inds) == max(perf_metr_rho(inds)),1,'first'));

            else
                iBests = inds;
            end

            [iBestC iBestGamma] = find(perf_metr_rmse==perf_metr_rmse(iBests) ...
                & perf_metr_rho==perf_metr_rho(iBests),1,'first');
            disp(['Best C = ' num2str(Cs(iBestC)) ' Best Gamma  = ' num2str(Gammas(iBestGamma)) ', rho  = ' num2str(max(perf_metr_rho(:)))]);

            rho_max = max(perf_metr_rho(:));
            svm_prms = ['-s 4 -t 2 -d 3 -c ' num2str(Cs(iBestC)) ' -g ' num2str(Gammas(iBestGamma)) ' -h 0' ];
        else
            svm_prms = '-s 4 -t 2 -d 3 -c 10 -g 0.01 -h 0 ';

        end


        model = svmtrain(y, x, svm_prms);
        estimated = svmpredict(ones(size(xTest,1),1), xTest, model);
        estimated(estimated<parameters.lower_limit) = parameters.lower_limit;
        estimated(estimated>parameters.upper_limit) = parameters.upper_limit;
        scores = zeros(length(estimated),1);
   case {'diaglinear' 'linear' 'quadratic' 'diagquadratic'}
            try
                [estimated,~,scores] = classify(xTest, xTrain,labels_train,parameters.classifier);
            catch
                disp('pooled variance problem - passing')
                estimated = ones(size(xTest,1));
                scores = zeros(size(xTest,1),parameters.nbClasses);
            end
            try
                [estimated_training, ~, scores_training]  = classify(xTrain, xTrain, labels_train,parameters.classifier);
            catch
                disp('pooled variance problem for training - passing')
                estimated_training = ones(size(xTrain,1));
                scores_training = zeros(size(xTrain,1),parameters.nbClasses);
            end

end
