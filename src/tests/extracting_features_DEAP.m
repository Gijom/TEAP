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
    %it is already baselined
    bulk = Signal__set_absolute(bulk, true);
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
        [features(subject,epoch).HST_feats, features(subject,epoch).HST_feats_names] = ...
            HST_feat_extr(bulk(epoch));
        %extracting respiration features
        [features(subject,epoch).RES_feats, features(subject,epoch).RES_feats_names] = ...
            RES_feat_extr(bulk(epoch));
        fprintf('extracted all the features for subject %d epoch %d\n',subject, epoch);
        %todo store it somebwere
    end
end
