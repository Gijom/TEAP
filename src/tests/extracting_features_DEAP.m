%extracting features from DEAP database
%path where the mat files are stored
clear;clc;
TEAP_path = '/home/soleyman/work/codes/TEAP/src';
curr_path = cd;
eval(['cd ' TEAP_path]);
init
eval(['cd ' curr_path]);
physio_path = '/user/mmi/emotion/data/DEAP/physio_data';
if ~exist([physio_path '/s30_eeglab.mat'],'file')
    loading_DEAP(physio_path);
end

for subject=1:32
    eeglab_file = sprintf('%s/s%0.2d_eeglab.mat',physio_path,subject);
    %loading the file
    bulk = Bulk_load(eeglab_file);
    %exracting EMG feaures
    [EMG_feats, EMG_feats_names] = EMG_feat_extr(bulk);
    %extracting EEG features
    [EEG_feats, EEG_feats_names] = EEG_feat_extr(bulk);
    %extracting GSR features
    [GSR_feats, GSR_feats_names] = GSR_feat_extr(bulk);
    %extracting BVP features
    [BVP_feats, BVP_feats_names] = BVP_feat_extr(bulk);
    %extracting skin temperature features
    [HST_feats, HST_feats_names] = HST_feat_extr(bulk);
    %extracting respiration features
    [RES_feats, RES_feats_names] = RES_feat_extr(bulk);
    fprintf('extracted all the features for subject %d\n',subject);
    
    
end
