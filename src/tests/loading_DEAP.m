%we assume the pre-processed physilogical signals in mat file from  DEAP data is being used
%this script loads the DEAP data and converts it to the EEGLAB format that
%is readable by TEAP
%I added minimally required fields to the structure
%Mohammad Soleymani June 2015 mohammad.soleymani@unige.ch
function loading_DEAP(physio_files_path)
%Takes the path physio_files_path and writes the mat files in eeglab format
%acceptable by TEAP
 
electrode_labels = {'Fp1', 'AF3', 'F3', 'F7', 'FC5', 'FC1', 'C3', 'T7', 'CP5', ...
    'CP1', 'P3', 'P7', 'PO3', 'O1', 'Oz', 'Pz', 'Fp2', 'AF4', ...
    'Fz', 'F4', 'F8', 'FC6', 'FC2', 'Cz', 'C4', 'T8', 'CP6', ...
    'CP2', 'P4', 'P8', 'PO4', 'O2','hEOG','vEOG','zEMG','tEMG','GSR','RESP','BVP','HST'};




phys_data.srate = 128;
phys_data.ref= 'common';
phys_data.trials = 40;
phys_data.nbchan=41; %added one since ground is added
for i = 1:40
    phys_data.chanlocs(i).labels = electrode_labels{i};
end
phys_data.chanlocs(41).labels = 'GND'; %ground channel
for subject=1:32
    fprintf('loading and converting subject %0.2d\n',subject);
    %file name to load
    mat_file = sprintf('%s/s%0.2d.mat',physio_files_path,subject);
    load(mat_file);
    ratings{subject} = labels;
    % we add a zero channel to be used as the second lead for the EMG
    % signal
    phys_data.data = zeros(size(data,2)+1,size(data,3),size(data,1));
    for epoch = 1:40
        for chan = 1:40
            phys_data.data(chan,:,epoch) = squeeze(data(epoch, chan, :));
        end
    end
    eeglab_file = sprintf('%s/s%0.2d_eeglab.mat',physio_files_path,subject);
    save(eeglab_file,'phys_data');
end

fprintf('Done! Successfully converted the mat files\n',subject);
