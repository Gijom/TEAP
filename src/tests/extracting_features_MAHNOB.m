%we assume the pre-processed physilogical signals in mat file from  DEAP data is being used
%this script loads the MAHNOB data and converts it to the EEGLAB format that
%is readable by TEAP
%I assume the data is in MAHNOB_path
%I added minimally required fields to the structure
%Mohammad Soleymani June 2015 mohammad.soleymani@unige.ch
%Takes the path physio_files_path and writes the mat files in eeglab format
%acceptable by TEAP
%for ECG we take the ECG2-ECG3 as the lead
clc
clear
close all

MAHNOB_path = '/user/mmi/emotion/data/MAHNOB-HCI/teapformat/';
addpath('/home/soleyman/work/codes/mylibs')
cntr = 0;
files_physio = dir([MAHNOB_path '*_eeglab.mat']);
%there is only one epoch
epoch = 1;
for i = 1:length(files_physio)
    fprintf('loading file %s\n',files_physio(i).name);
    s = strsplit(files_physio(i).name ,'_');
    subj_id = str2double(s{1}(2:3));
    trial_id = str2double(s{2}(2:3));    
    eeglab_file = sprintf('%s%s',MAHNOB_path,files_physio(i).name);
    %loading the file
    bulk = Bulk_load(eeglab_file);
    %loading feedbacks
    feedback_file = strrep(eeglab_file, 'eeglab', 'feedback');
    load(feedback_file);
    features(subj_id,trial_id).feedback = feedback;
    %extracting ECG features
    [features(subj_id,trial_id).ECG_feats, features(subj_id,trial_id).ECG_feats_names] = ...
        ECG_feat_extr(bulk(epoch));
    %extracting EEG features
    %average re-referencing 
    EEGSignal = EEG_reference_mean(bulk(epoch));
    [features(subj_id,trial_id).EEG_feats, features(subj_id,trial_id).EEG_feats_names] = ...
        EEG_feat_extr(EEGSignal);
    %extracting GSR features
    [features(subj_id,trial_id).GSR_feats, features(subj_id,trial_id).GSR_feats_names] = ...
        GSR_feat_extr(bulk(epoch));
    %extracting BVP features
    %[features(subj_id,trial_id).BVP_feats, features(subj_id,trial_id).BVP_feats_names] = ...
    %            BVP_feat_extr(bulk(epoch));
    %extracting skin temperature features
    [features(subj_id,trial_id).HST_feats, features(subj_id,trial_id).HST_feats_names] = ...
        HST_feat_extr(bulk(epoch));
    %extracting respiration features
    [features(subj_id,trial_id).RES_feats, features(subj_id,trial_id).RES_feats_names] = ...
        RES_feat_extr(bulk(epoch));
    fprintf('extracted all the features for subject %d trial %d\n',subj_id, trial_id);
    
end

save('mahnob_features.mat','features');


fprintf('Done! Successfully extracted the feaures\n');
