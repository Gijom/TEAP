function [name] = EEG_get_elname(number)
%Gets the electrode name from a number
% Inputs:
%  number: the electrode number (eg: 2)
% Outputs:
%  name: the name (eg: 'AF3')
%
%Copyright Frank Villaro-Dixon, BSD Simplified, 2014

correspondance = ['Fp1'; 'AF3'; 'F3'; 'F7'; 'FC5'; 'FC1'; 'C3'; 'T7'; 'CP5'; ...
                  'CP1'; 'P3'; 'P7'; 'PO3'; 'O1'; 'Oz'; 'Pz'; 'Fp2'; 'AF4'; ...
                  'Fz'; 'F4'; 'F8'; 'FC6'; 'FC2'; 'Cz'; 'C4'; 'T8'; 'CP6'; ...
                  'CP2'; 'P4'; 'P8'; 'PO4'; 'O2'];

name = strtrim(correspondance(number, :));


