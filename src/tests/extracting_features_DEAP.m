%extracting features from DEAP database
%path where the mat files are stored
%You need to go to http://www.eecs.qmul.ac.uk/mmv/datasets/deap/ to get the data
%You should download the mat files and the ratings and set the correct path
clear;clc;
TEAP_path = fileparts(pwd);
curr_path = cd;
eval(['cd ' TEAP_path]);
init
eval(['cd ' curr_path]);
%replace the following line by where your phsyio data is located
physio_path = 'DEAP/physio_data/';
%replcae the following path with your local path of the ratings
feedbacks = readtable('DEAP/metadata/participant_ratings.csv');
if ~exist([physio_path '/s30_eeglab.mat'],'file')
    loading_DEAP(physio_path);
end
for subject=1:32
    eeglab_file = sprintf('%ss%0.2d_eeglab.mat',physio_path,subject);
    %loading the file
    bulk = Bulk_load(eeglab_file);
    %exracting EMG feaures
    %TODO extract by subject by epoch
    for epoch =  1:40
        [features(subject,epoch).EMG_feats, features(subject,epoch).EMG_feats_names] = ...
            EMG_feat_extr(bulk(epoch));
        %extracting EEG features
        [features(subject,epoch).EEG_feats, features(subject,epoch).EEG_feats_names] = ...
            EEG_feat_extr(bulk(epoch));
        %extracting GSR features
        [features(subject,epoch).GSR_feats, features(subject,epoch).GSR_feats_names] = ...
            GSR_feat_extr(bulk(epoch));
        %extracting BVP features
        [features(subject,epoch).BVP_feats, features(subject,epoch).BVP_feats_names] = ...
            BVP_feat_extr(bulk(epoch));
        %extracting skin temperature features
        % we skip this since there appear to be problems with the HST
        % signal in the mat files - they are incorrect
        %[features(subject,epoch).HST_feats, features(subject,epoch).HST_feats_names] = ...
        %    HST_feat_extr(bulk(epoch));
        %extracting respiration features
        [features(subject,epoch).RES_feats, features(subject,epoch).RES_feats_names] = ...
            RES_feat_extr(bulk(epoch));
        feedback = feedbacks(feedbacks.Participant_id==subject & feedbacks.Experiment_id==epoch,:);
        features(subject,epoch).feedback.felt_arousal = feedback.Arousal;
        features(subject,epoch).feedback.felt_valence = feedback.Valence;
        features(subject,epoch).feedback.felt_dominance = feedback.Dominance;
        features(subject,epoch).feedback.felt_liking = feedback.Liking;
        features(subject,epoch).feedback.felt_familiarity = feedback.Familiarity;
        fprintf('extracted all the features for subject %d epoch %d\n',subject, epoch);
    end
end


%we store the features in the same path where the signals were
save([physio_path 'deap_features.mat'],'features');


fprintf('Done! Successfully extracted the feaures\n');
