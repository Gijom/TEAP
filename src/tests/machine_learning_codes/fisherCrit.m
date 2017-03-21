function [listeFeatures, FC] = fisherCrit(features, labels, nbClasses)

nbFeatures = size(features, 2);
nbSamples = size(features, 1);

FC = zeros(nbFeatures,1);

meanSamples = mean(features,1);

%pour chaque feature on calcul son critere de fisher
for(iFeat = 1:nbFeatures)
    inter = 0;
    intra = 0;
    for(iClass =1:nbClasses)
        meanClass = mean(features(labels==iClass,iFeat));
        inter = inter + sum(labels==iClass)*(meanClass - meanSamples(iFeat))^2;
        for(spl = find(labels==iClass)')
            intra = intra + (features(spl,iFeat) - meanClass)^2;
        end
    end
    FC(iFeat) = inter / intra;
end
FC(isnan(FC)) = 0;
[FC listeFeatures] = sort(FC,'descend');
listeFeatures = listeFeatures';
