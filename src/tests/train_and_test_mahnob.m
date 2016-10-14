clear
clc
close all
%You need libsvm to run this code you can download it from http://www.csie.ntu.edu.tw/~cjlin/libsvm/
%excluding participants database paper
%excl_part = [9 12 15];
%excluding participants multimodal paper
excl_part = [ 3 9 12 15 16 26];
%replcea the following with the corerect feature path
load('mahnob_features.mat')
load clipCodeCoversion
clipValences = [1 1 3 2 2   3 3 3 2 3   1 1 1 1 2   1 2 3 2 3];
clipArousals = [3 3 2 3 2   2 2 1 2 2   3 2 3 2 1   3 1 3 1 3];

emoWords = [{'Sadness'} {'Joy'} {'Disgust'} {'Neutral'} ...
    {'Amusement'} {'Anger'} {'Fear'} {'Surprise'} {'Anxiety'}];
emoMapArousal = [1;2;1; 1;2;3; 3;3;3];
emoMapValence = [1;3;1; 2;3;1; 1;2;1];
addpath('machine_learning_codes/');
%replace the following with your libsvm path
addpath('libsvm-3.19/matlab');
ctr = 0;
for part = 1:30
    if any(excl_part ==part)
        continue
    end
    for trial = 1:20
        %if the feedback record is empty the trial was missing so skip it
        if isempty(features(part,trial).feedback)
            continue
        end
        ctr = ctr+1;
        EEG_feats(ctr,:) = features(part,trial).EEG_feats(:)';
        periph_feats(ctr,:) =  [features(part,trial).ECG_feats ...
            features(part,trial).GSR_feats features(part,trial).RES_feats ...
            features(part,trial).HST_feats];
        part_vect(ctr) = part;
        trial_vect(ctr) =  trial;
        
        % self rported arousal and valence which was not used in any of the
        % original articles
        arousal_reported(ctr) = features(part,trial).feedback.felt_arousal;
        valence_reported(ctr) = features(part,trial).feedback.felt_valence;
        %translation of reported keywords to three levels of arousal and valence
        %Soleymani et al. "A multimodal database for affect recognition and implicit tagging."%
        %Affective Computing, IEEE Trans. 3.1 (2012): 42-55.
        arousal_keyword(ctr) = emoMapArousal(strcmp(features(part,trial).feedback.felt_emotion,emoWords));
        valence_keyword(ctr) = emoMapValence(strcmp(features(part,trial).feedback.felt_emotion,emoWords));
        %the following labels are for
        %Soleymani et al.
        %"Multimodal emotion recognition in response to videos."
        %Affective Computing, IEEE Trans. 3.2 (2012): 211-223.
        arousal_expected(ctr) = clipArousals(clipCodesConv(part,trial));
        valence_expected(ctr) = clipValences(clipCodesConv(part,trial));
    end
    %normalize per participant
    EEG_feats(part_vect==part,:) = zscore(EEG_feats(part_vect==part,:));
    periph_feats(part_vect==part,:) = zscore(periph_feats(part_vect==part,:));
    
end

parameters.normalize = 3;
parameters.nbClasses = 3;
parameters.grid_search = true;
parameters.featSelection = 'none';
parameters.classifier = 'SVMRbf';
parameters.cross_validation = 'one-participant-out';%'k-fold';%'leave-one-out';
if length(excl_part)==3
    
    %EEG cross validation arousal reported keyword
    [estimated_self_arousal_EEG, scores_self_arousal_EEG, evals_self_arousal_EEG]  = ...
        cross_validation_module(EEG_feats, arousal_keyword, part_vect, parameters);
    
    
    %EEG cross validation valence reported keyword
    [estimated_self_valence_EEG, scores_self_valence_EEG, evals_self_valencel_EEG]  = ...
        cross_validation_module(EEG_feats, valence_keyword, part_vect, parameters);
    
    %Peripheral cross validation arousal reported keyword
    [estimated_self_arousal_periph, scores_self_arousal_periph, evals_self_arousal_periph]  = ...
        cross_validation_module(periph_feats, arousal_keyword, part_vect, parameters);
    
    %Peripheral cross validation valence reported keyword
    [estimated_self_valence_periph, scores_self_valence_periph, evals_self_valence_periph]  = ...
        cross_validation_module(periph_feats, valence_keyword, part_vect, parameters);
    
    
    fprintf('EEG database paper eq. arousal results recognition rate = %1.3f averaged F1 = %1.3f\n', ...
        evals_self_arousal_EEG.classification_rate, mean(evals_self_arousal_EEG.f1s))
    fprintf('EEG database paper eq. valence results recognition rate = %1.3f averaged F1 = %1.3f\n', ...
        evals_self_valencel_EEG.classification_rate, mean(evals_self_valencel_EEG.f1s))
    fprintf('Peripheral database paper eq. arousal results recognition rate = %1.3f averaged F1 = %1.3f\n', ...
        evals_self_arousal_periph.classification_rate, mean(evals_self_arousal_periph.f1s))
    fprintf('Peripheral database paper eq. valence results recognition rate = %1.3f averaged F1 = %1.3f\n', ...
        evals_self_valence_periph.classification_rate, mean(evals_self_valence_periph.f1s))
    save results_dbpaper evals_self_arousal_EEG evals_self_valencel_EEG evals_self_arousal_periph evals_self_valence_periph
else
    %
    % %EEG cross validation arousal expected
    [estimated_expected_arousal_EEG, scores_expected_arousal_EEG, evals_expected_arousal_EEG]  = ...
        cross_validation_module(EEG_feats, arousal_expected, part_vect, parameters);
    %
    %
    % %EEG cross validation valence reported keyword
    [estimated_expected_valence_EEG, scores_expected_valence_EEG, evals_expected_valencel_EEG]  = ...
        cross_validation_module(EEG_feats, valence_expected, part_vect, parameters);
    %
    % %Peripheral cross validation arousal reported keyword
    [estimated_expected_arousal_periph, scores_expected_arousal_periph, evals_expected_arousal_periph]  = ...
        cross_validation_module(periph_feats, arousal_expected, part_vect, parameters);
    %
    % %Peripheral cross validation valence reported keyword
    [estimated_expected_valence_periph, scores_expected_valence_periph, evals_expected_valence_periph]  = ...
        cross_validation_module(periph_feats, valence_expected, part_vect, parameters);
    
    
    fprintf('EEG TAFFC multimodal paper eq.. arousal results recognition rate = %1.3f averaged F1 = %1.3f\n', ...
        evals_expected_arousal_EEG.classification_rate, mean(evals_expected_arousal_EEG.f1s))
    fprintf('EEG TAFFC multimodal paper eq.. valence results recognition rate = %1.3f averaged F1 = %1.3f\n', ...
        evals_expected_valencel_EEG.classification_rate, mean(evals_expected_valencel_EEG.f1s))
    fprintf('Peripheral TAFFC multimodal paper eq.. arousal results recognition rate = %1.3f averaged F1 = %1.3f\n', ...
        evals_expected_arousal_periph.classification_rate, mean(evals_expected_arousal_periph.f1s))
    fprintf('Peripheral TAFFC multimodal paper eq.. valence results recognition rate = %1.3f averaged F1 = %1.3f\n', ...
        evals_expected_valence_periph.classification_rate, mean(evals_expected_valence_periph.f1s))
    %
    save results_taffc_mm_paper evals_expected_arousal_EEG evals_expected_valencel_EEG evals_expected_arousal_periph evals_expected_valence_periph
end

