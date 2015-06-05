function [name] = EEG_get_elname(num)
%Gets the electrode name from a number
% Inputs:
%  number: the electrode number (eg: 2)
% Outputs:
%  name: the name (eg: 'AF3')
%
%Copyright Frank Villaro-Dixon, BSD Simplified, 2014

 
name = electrode_labels.EEG{num};


