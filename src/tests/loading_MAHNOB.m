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
electrode_labels_orig =  {'Fp1', 'AF3', 'F3', 'F7', 'FC5', 'FC1', 'C3', 'T7', 'CP5', ...
    'CP1', 'P3', 'P7', 'PO3', 'O1', 'Oz', 'Pz', 'Fp2', 'AF4', ...
    'Fz', 'F4', 'F8', 'FC6', 'FC2', 'Cz', 'C4', 'T8', 'CP6', ...
    'CP2', 'P4', 'P8', 'PO4', 'O2','EXG1','EXG2','EXG3','EXG4','EXG5', ...
    'EXG6','EXG7','EXG8','GSR1','GSR2','Erg1','Erg2','Resp','Temp','Status'};
electrode_labels = {'Fp1', 'AF3', 'F3', 'F7', 'FC5', 'FC1', 'C3', 'T7', 'CP5', ...
    'CP1', 'P3', 'P7', 'PO3', 'O1', 'Oz', 'Pz', 'Fp2', 'AF4', ...
    'Fz', 'F4', 'F8', 'FC6', 'FC2', 'Cz', 'C4', 'T8', 'CP6', ...
    'CP2', 'P4', 'P8', 'PO4', 'O2','EXG2','EXG3', ...
    'GSR1','Resp','Temp','Status'};

feltEmotCode = 0:12;
feltEmos = {'Neutral', 'Anger', 'Disgust', 'Fear', 'Joy', 'Sadness', ...
    'Surprise', 'Scream', 'Bored', 'Sleepy', 'Unknown','Amusement', 'Anxiety'};

n_chans = 38;

MAHNOB_path = '/user/mmi/emotion/data/MAHNOB-HCI/Sessions/';
path_towrite = '/user/mmi/emotion/data/MAHNOB-HCI/teapformat';
addpath('/home/soleyman/work/codes/mylibs')
sessions = dir(MAHNOB_path);
cntr = 0;

phys_data.srate = 256;
phys_data.ref= 'common';
phys_data.trials = 1;
phys_data.nbchan = n_chans; %added one since ground is added
phys_data.epoch = 1;

for i = 1:n_chans
    phys_data.chanlocs(i).labels = electrode_labels{i};
end
phys_data.chanlocs(n_chans+1).labels = 'GND';
for i = 1:length(sessions)
    if strcmp(sessions(i).name(1) ,'.') || ~sessions(i).isdir
        continue
    end
    cntr =  cntr +1;
    new_path = [MAHNOB_path sessions(i).name '/'];
    files_of = dir([new_path '*.bdf']);
    % we need at least one bdf file
    if length(files_of)<1
        continue
    end
    s = strsplit(files_of.name ,'_');
    if strcmp(s{3},'N')
        continue
    end
    subj_id = str2double(s{2});
    trial_id = str2double(s{4}(6:end));
    bdf = openbdf([new_path files_of.name]);
    fprintf('loading and converting subject %0.2d trial %0.2d\n',subj_id,trial_id);
    data = readbdf(bdf,1:bdf.Head.NRec);
    phys_data.data = zeros(n_chans+1,size(data.Record,2)-60*phys_data.srate);
    for j = 1:n_chans
        phys_data.data(j,:) = data.Record(strcmp(electrode_labels{j},electrode_labels_orig),30*phys_data.srate+1:end-30*phys_data.srate);
    end
    eeglab_file = sprintf('%s/s%0.2d_t%0.2d_eeglab.mat',path_towrite,subj_id,trial_id);
    save(eeglab_file,'phys_data');
    fid = fopen([new_path 'session.xml']);
    fgetl(fid);
    tmp_str = fgetl(fid);
    if strcmp(tmp_str(strfind(tmp_str,'feltEmo')+10),'"')
        feedback.felt_emotion = feltEmos{str2double(tmp_str(strfind(tmp_str,'feltEmo')+9))+1};
        feedback.felt_emotion_id = str2double(tmp_str(strfind(tmp_str,'feltEmo')+9));
    else
        feedback.felt_emotion = feltEmos{str2double(tmp_str(strfind(tmp_str,'feltEmo')+9:strfind(tmp_str,'feltEmo')+10))+1};
        feedback.felt_emotion_id = str2double(tmp_str(strfind(tmp_str,'feltEmo')+9:strfind(tmp_str,'feltEmo')+10));
    end
    feedback.felt_arousal = str2double(tmp_str(strfind(tmp_str,'feltArsl')+10));
    feedback.felt_valence = str2double(tmp_str(strfind(tmp_str,'feltVlnc')+10));
    feedback.felt_control = str2double(tmp_str(strfind(tmp_str,'feltCtrl')+10));
    feedback.felt_predict = str2double(tmp_str(strfind(tmp_str,'feltPred')+10));
    s= strsplit(tmp_str(strfind(tmp_str,'mediaFile'):end),'"');
    feedback.media_file = s{2};
    feedback_file = sprintf('%s/s%0.2d_t%0.2d_feedback.mat',path_towrite,subj_id,trial_id);
    save(feedback_file,'feedback');
end




fprintf('Done! Successfully converted the mat files\n');
