clear
clc
close all
%uupdate the follosing path to match your local ones
addpath('machine_learning_codes/');
load('DEAP/physio_data/deap_features.mat')
ctr = 0;
for part = 1:32
    for trial = 1:40
        %if the feedback record is empty the trial was missing so skip it
        if isempty(features(part,trial).feedback)
            continue
        end
        ctr = ctr+1;
        EEG_feats(ctr,:) = features(part,trial).EEG_feats(:)';
        periph_feats(ctr,:) =  [features(part,trial).EMG_feats(:)' ...
            features(part,trial).GSR_feats features(part,trial).RES_feats ...
            features(part,trial).BVP_feats];
        part_vect(ctr) = part;
        trial_vect(ctr) =  trial;
        
        % self rported arousal and valence which was not used in any of the
        % original articles
        %Soleymani, Mohammad, et al. "Continuous emotion detection in response to music videos." Automatic Face & Gesture Recognition and Workshops (FG 2011), 2011 IEEE International Conference on. IEEE, 2011.
        %centered for regression
        arousal_reported(ctr) = (features(part,trial).feedback.felt_arousal-5);
        valence_reported(ctr) = (features(part,trial).feedback.felt_valence-5);
        dominance_reported(ctr) = (features(part,trial).feedback.felt_dominance-5);
        liking_reported(ctr) = (features(part,trial).feedback.felt_liking-5);
        
        %translation of reported keywords to two levels of arousal and
        %valence and likability
        %Koelstra, Sander, et al. "Deap: A database for emotion analysis; using physiological signals." Affective Computing, IEEE Transactions on 3.1 (2012): 18-31.
        arousal_feltclass(ctr) = (features(part,trial).feedback.felt_arousal>5)+1; % 1 for low and 2 for high
        valence_feltclass(ctr) = (features(part,trial).feedback.felt_valence>5)+1; % 1 for low and 2 for high
        dominance_feltclass(ctr) = (features(part,trial).feedback.felt_dominance>5)+1; % 1 for low and 2 for high
        liking_feltclass(ctr) = (features(part,trial).feedback.felt_liking>5)+1; % 1 for low and 2 for high
    end
    %normalize per participant
    EEG_feats(part_vect==part,:) = zscore(EEG_feats(part_vect==part,:));
    periph_feats(part_vect==part,:) = zscore(periph_feats(part_vect==part,:));
    
end
parameters.verbose = false;

parameters.normalize = 2;
parameters.nbClasses = 2;
parameters.lower_limit = -0.5;
parameters.upper_limit = 0.5;
parameters.grid_search = true;
parameters.featSelection = 'Fisher';
parameters.classifier = 'diaglinear';
parameters.cross_validation = 'leave-one-out';
for subject = 1:32
    idx = part_vect ==subject;
    if parameters.verbose
        fprintf('Classifying samples from subject %d\n',subject);
        
        fprintf('EEG signals\n');
    end
    %EEG cross validation arousal reported binary class
    [estimated_self_arousal_EEG{subject}, scores_self_arousal_EEG{subject}, evals_self_arousal_EEG{subject}]  = ...
        cross_validation_module(EEG_feats(idx,:), arousal_feltclass(idx), [], parameters);
    
    %EEG cross validation valence reported binary class
    [estimated_self_valence_EEG{subject}, scores_self_valence_EEG{subject}, evals_self_valence_EEG{subject}]  = ...
        cross_validation_module(EEG_feats(idx,:), valence_feltclass(idx), [], parameters);
    %EEG cross validation dominance reported binary class
    [estimated_self_dominance_EEG{subject}, scores_self_dominance_EEG{subject}, evals_self_dominance_EEG{subject}]  = ...
        cross_validation_module(EEG_feats(idx,:), dominance_feltclass(idx), [], parameters);
    %EEG cross validation liking reported binary class
    [estimated_self_liking_EEG{subject}, scores_self_liking_EEG{subject}, evals_self_liking_EEG{subject}]  = ...
        cross_validation_module(EEG_feats(idx,:), liking_feltclass(idx), [], parameters);
    if parameters.verbose 
        fprintf('Peripheral signals signals\n');
    end
    %Peripheral cross validation arousal reported binary class
    [estimated_self_arousal_periph{subject}, scores_self_arousal_periph{subject}, evals_self_arousal_periph{subject}]  = ...
        cross_validation_module(periph_feats(idx,:), arousal_feltclass(idx), [], parameters);
    
    %Peripheral cross validation valence reported binary class
    [estimated_self_valence_periph{subject}, scores_self_valence_periph{subject}, evals_self_valence_periph{subject}]  = ...
        cross_validation_module(periph_feats(idx,:), valence_feltclass(idx), [], parameters);
    %Peripheral cross validation dominance reported binary class
    [estimated_self_dominance_periph{subject}, scores_self_dominance_periph{subject}, evals_self_dominance_periph{subject}]  = ...
        cross_validation_module(periph_feats(idx,:), dominance_feltclass(idx), [], parameters);
    %Peripheral cross validation liking reported binary class
    [estimated_self_liking_periph{subject}, scores_self_liking_periph{subject}, evals_self_liking_periph{subject}]  = ...
        cross_validation_module(periph_feats(idx,:), liking_feltclass(idx), [], parameters);
    f1s_self_arousal_EEG(subject) = mean(evals_self_arousal_EEG{subject}.f1s);
    f1s_self_valence_EEG(subject) = mean(evals_self_valence_EEG{subject}.f1s);
    f1s_self_dominance_EEG(subject) = mean(evals_self_dominance_EEG{subject}.f1s);
    f1s_self_liking_EEG(subject) = mean(evals_self_liking_EEG{subject}.f1s);
    
    cr_self_arousal_EEG(subject) = evals_self_arousal_EEG{subject}.classification_rate;
    cr_self_valence_EEG(subject) = evals_self_valence_EEG{subject}.classification_rate;
    cr_self_dominance_EEG(subject) = evals_self_dominance_EEG{subject}.classification_rate;
    cr_self_liking_EEG(subject) = evals_self_liking_EEG{subject}.classification_rate;
    
    f1s_self_arousal_periph(subject) = mean(evals_self_arousal_periph{subject}.f1s);
    f1s_self_valence_periph(subject) = mean(evals_self_valence_periph{subject}.f1s);
    f1s_self_dominance_periph(subject) = mean(evals_self_dominance_periph{subject}.f1s);
    f1s_self_liking_periph(subject) = mean(evals_self_liking_periph{subject}.f1s);
    
    cr_self_arousal_periph(subject) = evals_self_arousal_periph{subject}.classification_rate;
    cr_self_valence_periph(subject) = evals_self_valence_periph{subject}.classification_rate;
    cr_self_dominance_periph(subject) = evals_self_dominance_periph{subject}.classification_rate;
    cr_self_liking_periph(subject) = evals_self_liking_periph{subject}.classification_rate;
    
    
end




fprintf('EEG deap paper eq. arousal results recognition rate = %1.2f(%1.2f) averaged F1 = %1.2f(%1.2f)\n', ...
    mean(cr_self_arousal_EEG), std(cr_self_arousal_EEG), mean(f1s_self_arousal_EEG), std(f1s_self_arousal_EEG));

fprintf('EEG deap paper eq. valence results recognition rate = %1.2f(%1.2f) averaged F1 = %1.2f(%1.2f)\n', ...
    mean(cr_self_valence_EEG), std(cr_self_valence_EEG), mean(f1s_self_valence_EEG), std(f1s_self_valence_EEG));

fprintf('EEG deap paper eq. dominance results recognition rate = %1.2f(%1.2f) averaged F1 = %1.2f(%1.2f)\n', ...
    mean(cr_self_dominance_EEG), std(cr_self_dominance_EEG), mean(f1s_self_dominance_EEG), std(f1s_self_dominance_EEG));

fprintf('EEG deap paper eq. liking results recognition rate = %1.2f(%1.2f) averaged F1 = %1.2f(%1.2f)\n', ...
    mean(cr_self_liking_EEG), std(cr_self_liking_EEG), mean(f1s_self_liking_EEG), std(f1s_self_liking_EEG));



fprintf('periph deap paper eq. arousal results recognition rate = %1.2f(%1.2f) averaged F1 = %1.2f(%1.2f)\n', ...
    mean(cr_self_arousal_periph), std(cr_self_arousal_periph), mean(f1s_self_arousal_periph), std(f1s_self_arousal_periph));

fprintf('periph deap paper eq. valence results recognition rate = %1.2f(%1.2f) averaged F1 = %1.2f(%1.2f)\n', ...
    mean(cr_self_valence_periph), std(cr_self_valence_periph), mean(f1s_self_valence_periph), std(f1s_self_valence_periph));

fprintf('periph deap paper eq. dominance results recognition rate = %1.2f(%1.2f) averaged F1 = %1.2f(%1.2f)\n', ...
    mean(cr_self_dominance_periph), std(cr_self_dominance_periph), mean(f1s_self_dominance_periph), std(f1s_self_dominance_periph));

fprintf('periph deap paper eq. liking results recognition rate = %1.2f(%1.2f) averaged F1 = %1.2f(%1.2f)\n', ...
    mean(cr_self_liking_periph), std(cr_self_liking_periph), mean(f1s_self_liking_periph), std(f1s_self_liking_periph));





save results_DEAP evals_self_arousal_EEG evals_self_valence_EEG ...
    evals_self_dominance_EEG evals_self_liking_EEG evals_self_arousal_periph ...
    evals_self_valence_periph evals_self_dominance_periph evals_self_liking_periph




parameters.normalize = 3;
%regression
parameters.nbClasses = -1;
parameters.lower_limit = -0.5;
parameters.upper_limit = 0.5;
parameters.grid_search = true;
parameters.featSelection = 'none';
parameters.classifier = 'ridge_reg';
<<<<<<< HEAD
parameters.cross_validation = 'leave-one-out';%'one-participant-out';%'k-fold';%
=======
parameters.cross_validation = 'leave-one-out';
>>>>>>> upstream/master
for subject = 1:32
    if parameters.verbose
        fprintf('Regression for samples from subject %d\n',subject);
        
        fprintf('EEG signals\n');
    end
    idx = part_vect ==subject;
    %EEG cross validation arousal reported binary class
    [estimated_self_arousal_EEG{subject}, scores_self_arousal_EEG{subject}, evals_self_arousal_EEG{subject}]  = ...
        cross_validation_module(EEG_feats(idx,:), arousal_reported(idx), [], parameters);
    
    %EEG cross validation valence reported binary class
    [estimated_self_valence_EEG{subject}, scores_self_valence_EEG{subject}, evals_self_valence_EEG{subject}]  = ...
        cross_validation_module(EEG_feats(idx,:), valence_reported(idx), [], parameters);
    %EEG cross validation dominance reported binary class
    [estimated_self_dominance_EEG{subject}, scores_self_dominance_EEG{subject}, evals_self_dominance_EEG{subject}]  = ...
        cross_validation_module(EEG_feats(idx,:), dominance_reported(idx), [], parameters);
    %EEG cross validation liking reported binary class
    [estimated_self_liking_EEG{subject}, scores_self_liking_EEG{subject}, evals_self_liking_EEG{subject}]  = ...
        cross_validation_module(EEG_feats(idx,:), liking_reported(idx), [], parameters);
    
    if parameters.verbose
        fprintf('Peripheral signals\n');
    end
    %Peripheral cross validation arousal reported binary class
    [estimated_self_arousal_periph{subject}, scores_self_arousal_periph{subject}, evals_self_arousal_periph{subject}]  = ...
        cross_validation_module(periph_feats(idx,:), arousal_reported(idx), [], parameters);
    
    %Peripheral cross validation valence reported binary class
    [estimated_self_valence_periph{subject}, scores_self_valence_periph{subject}, evals_self_valence_periph{subject}]  = ...
        cross_validation_module(periph_feats(idx,:), valence_reported(idx), [], parameters);
    %Peripheral cross validation dominance reported binary class
    [estimated_self_dominance_periph{subject}, scores_self_dominance_periph{subject}, evals_self_dominance_periph{subject}]  = ...
        cross_validation_module(periph_feats(idx,:), dominance_reported(idx), [], parameters);
    %Peripheral cross validation liking reported binary class
    [estimated_self_liking_periph{subject}, scores_self_liking_periph{subject}, evals_self_liking_periph{subject}]  = ...
        cross_validation_module(periph_feats(idx,:), liking_reported(idx), [], parameters);
    RMSE_self_arousal_EEG(subject) = evals_self_arousal_EEG{subject}.RMSE;
    RMSE_self_valence_EEG(subject) = evals_self_valence_EEG{subject}.RMSE;
    RMSE_self_dominance_EEG(subject) = evals_self_dominance_EEG{subject}.RMSE;
    RMSE_self_liking_EEG(subject) = evals_self_liking_EEG{subject}.RMSE;
    
    MAE_self_arousal_EEG(subject) = evals_self_arousal_EEG{subject}.MAE;
    MAE_self_valence_EEG(subject) = evals_self_valence_EEG{subject}.MAE;
    MAE_self_dominance_EEG(subject) = evals_self_dominance_EEG{subject}.MAE;
    MAE_self_liking_EEG(subject) = evals_self_liking_EEG{subject}.MAE;
    
    RMSE_self_arousal_periph(subject) = evals_self_arousal_periph{subject}.RMSE;
    RMSE_self_valence_periph(subject) = evals_self_valence_periph{subject}.RMSE;
    RMSE_self_dominance_periph(subject) = evals_self_dominance_periph{subject}.RMSE;
    RMSE_self_liking_periph(subject) = evals_self_liking_periph{subject}.RMSE;
    
    MAE_self_arousal_periph(subject) = evals_self_arousal_periph{subject}.MAE;
    MAE_self_valence_periph(subject) = evals_self_valence_periph{subject}.MAE;
    MAE_self_dominance_periph(subject) = evals_self_dominance_periph{subject}.MAE;
    MAE_self_liking_periph(subject) = evals_self_liking_periph{subject}.MAE;
    
    
end




fprintf('EEG FG paper eq. arousal results MAE = %1.2f(%1.2f) RMSE = %1.2f(%1.2f)\n', ...
    mean(MAE_self_arousal_EEG), std(MAE_self_arousal_EEG), mean(RMSE_self_arousal_EEG), std(RMSE_self_arousal_EEG));

fprintf('EEG FG paper eq. valence results MAE = %1.2f(%1.2f) RMSE = %1.2f(%1.2f)\n', ...
    mean(MAE_self_valence_EEG), std(MAE_self_valence_EEG), mean(RMSE_self_valence_EEG), std(RMSE_self_valence_EEG));

fprintf('EEG FG paper eq. dominance results MAE = %1.2f(%1.2f) RMSE = %1.2f(%1.2f)\n', ...
    mean(MAE_self_dominance_EEG), std(MAE_self_dominance_EEG), mean(RMSE_self_dominance_EEG), std(RMSE_self_dominance_EEG));

fprintf('EEG FG paper eq. liking results MAE = %1.2f(%1.2f) RMSE = %1.2f(%1.2f)\n', ...
    mean(MAE_self_liking_EEG), std(MAE_self_liking_EEG), mean(RMSE_self_liking_EEG), std(RMSE_self_liking_EEG));



fprintf('periph FG paper eq. arousal results MAE = %1.2f(%1.2f) RMSE = %1.2f(%1.2f)\n', ...
    mean(MAE_self_arousal_periph), std(MAE_self_arousal_periph), mean(RMSE_self_arousal_periph), std(RMSE_self_arousal_periph));

fprintf('periph FG paper eq. valence results MAE = %1.2f(%1.2f) RMSE = %1.2f(%1.2f)\n', ...
    mean(MAE_self_valence_periph), std(MAE_self_valence_periph), mean(RMSE_self_valence_periph), std(RMSE_self_valence_periph));

fprintf('periph FG paper eq. dominance results MAE = %1.2f(%1.2f) RMSE = %1.2f(%1.2f)\n', ...
    mean(MAE_self_dominance_periph), std(MAE_self_dominance_periph), mean(RMSE_self_dominance_periph), std(RMSE_self_dominance_periph));

fprintf('periph FG paper eq. liking results MAE = %1.2f(%1.2f) RMSE = %1.2f(%1.2f)\n', ...
    mean(MAE_self_liking_periph), std(MAE_self_liking_periph), mean(RMSE_self_liking_periph), std(RMSE_self_liking_periph));





save results_FG evals_self_arousal_EEG evals_self_valence_EEG ...
    evals_self_dominance_EEG evals_self_liking_EEG evals_self_arousal_periph ...
    evals_self_valence_periph evals_self_dominance_periph evals_self_liking_periph
