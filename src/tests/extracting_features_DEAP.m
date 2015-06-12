%extracting features from DEAP database
%path where the mat files are stored
clear;clc;
TEAP_path = 
physio_path = '/user/mmi/emotion/data/DEAP/physio_data';
loading_DEAP(physio_path);
clear

for subject=1:32
    eeglab_file = sprintf('%s/s%0.2d_eeglab.mat',physio_path,subject);
    %loading the file
    bulk = Bulk_load(eeglab_file);
    %exracting EMG feaures
    
end
