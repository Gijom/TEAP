%> @file EEG_get_elname.m
%> @brief Gets the electrode name from a number

%> @param  number: the electrode number (eg: 2)

%> @retval  name: the name (eg: 'AF3')

%> @author Copyright Frank Villaro-Dixon, BSD Simplified, 2014
function [name] = EEG_get_elname(num)

config_file;
name = electrode_labels.EEG{num};


