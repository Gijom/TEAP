function [folds]  = kfold_gen(labels,params)

if params.nbClasses<2
    
    folds = cell(params.nbFolds,1);
    samples = 1:length(labels);
    samples = samples(randperm(length(samples)));
    
    nbTrialsPerFold = floor(length(samples) / params.nbFolds); %imprecision si le nombre de trial par classe n'est pas divisible par k (params.nbFolds)
    %On ajoute les indexes pour diviser en k-1 folds
    for k = 1:params.nbFolds-1
        folds{k} = samples((k-1)*nbTrialsPerFold+1:(k*nbTrialsPerFold));
    end
    folds{params.nbFolds} = samples((k*nbTrialsPerFold)+1:length(labels));
    
else
    nbTrialsPerClass = zeros(params.nbClasses,1);
    samples = 1:length(labels);
    samples = samples(randperm(length(samples)));
    folds = cell(params.nbFolds,1);
    if iscell(labels)
        nbTrialsPerFold = round(length(labels) / params.nbFolds); %imprecision si le nombre de trial par classe n'est pas divisible par k (params.nbFolds)
        %On ajoute les indexes pour diviser en k-1 folds
        for k = 1:params.nbFolds-1
            folds{k} = samples((k-1)*nbTrialsPerFold+1:(k*nbTrialsPerFold));
        end
        folds{params.nbFolds} = samples((k*nbTrialsPerFold):length(labels));
        
        
    else
        for c = 1:params.nbClasses
            iCurrentClass = find(labels == c);
            iCurrentClass = randperm(length(iCurrentClass));
            nbTrialsPerClass(c) = length(iCurrentClass);
            nbTrialsPerFold = round(nbTrialsPerClass(c) / params.nbFolds); %imprecision si le nombre de trial par classe n'est pas divisible par k (params.nbFolds)
            %On ajoute les indexes pour diviser en k-1 folds
            for k = 1:params.nbFolds-1
                folds{k} = [folds{k} , iCurrentClass((k-1)*nbTrialsPerFold+1:min(k*nbTrialsPerFold,length(iCurrentClass)))];
            end
            folds{params.nbFolds} = [folds{params.nbFolds} , iCurrentClass((params.nbFolds-1)*nbTrialsPerFold+1:end)];
        end
    end
end