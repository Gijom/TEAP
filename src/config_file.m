%signals according to TEAP terms

%this is an example based on the DEAP Dataset (bdf file)
% signals = {'EEG','GSR','HST','RES','BVP'};
% possible values 'EEG','GSR','HST','RES','BVP', ECG'
% signals = {'EEG','GSR','HST','RES','ECG'};
% %electrode lables in the file where they are recorded
% electrode_labels.GSR = {'GSR1'};
% electrode_labels.HST = {'Temp'};
% electrode_labels.RES = {'Resp'};
% % electrode_labels.BVP = {'Plet'};
% electrode_labels.ECG = {'EXG3','EXG2'};%mahnob
%
% %EEG electrod labels
% electrode_labels.EEG  = {'Fp1', 'AF3', 'F3', 'F7', 'FC5', 'FC1', 'C3', 'T7', 'CP5', ...
%             'CP1', 'P3', 'P7', 'PO3', 'O1', 'Oz', 'Pz', 'Fp2', 'AF4', ...
%             'Fz', 'F4', 'F8', 'FC6', 'FC2', 'Cz', 'C4', 'T8', 'CP6', ...
%             'CP2', 'P4', 'P8', 'PO4', 'O2'};


% for DEAP loaded from the mat file (not the bdf files)

signals = {'EEG','GSR','RES','BVP','EMG'};
%electrode labels in the file where they are recorded
 electrode_labels.GSR = {'GSR'};
 electrode_labels.BVP = {'BVP'};
 electrode_labels.RES = {'RESP'};
 electrode_labels.EMG = {'zEMG','GND','tEMG','GND'};%DEAP
%
% %EEG electrod labels
 electrode_labels.EEG  = {'Fp1', 'AF3', 'F3', 'F7', 'FC5', 'FC1', 'C3', 'T7', 'CP5', ...
             'CP1', 'P3', 'P7', 'PO3', 'O1', 'Oz', 'Pz', 'Fp2', 'AF4', ...
             'Fz', 'F4', 'F8', 'FC6', 'FC2', 'Cz', 'C4', 'T8', 'CP6', ...
             'CP2', 'P4', 'P8', 'PO4', 'O2'};

% MAHNOB loaded from the mat file (not the bdf files)

% signals = {'EEG','GSR','HST','RES','ECG'};
% %electrode lables in the file where they are recorded
%  electrode_labels.GSR = {'GSR1'};
%  electrode_labels.HST = {'Temp'};
%  electrode_labels.RES = {'Resp'};
%  electrode_labels.ECG = {'EXG3', 'EXG2'};
% %
% % %EEG electrod labels
%  electrode_labels.EEG  = {'Fp1', 'AF3', 'F3', 'F7', 'FC5', 'FC1', 'C3', 'T7', 'CP5', ...
%              'CP1', 'P3', 'P7', 'PO3', 'O1', 'Oz', 'Pz', 'Fp2', 'AF4', ...
%              'Fz', 'F4', 'F8', 'FC6', 'FC2', 'Cz', 'C4', 'T8', 'CP6', ...
%              'CP2', 'P4', 'P8', 'PO4', 'O2'};
