%Launches the toolbox

%Where the toolbox is
[folder, ~, ~] = fileparts(mfilename('fullpath'));
folder(folder=='\')='/';
%Add all the folders of the toolbox
addpath(genpath(folder))
clear folder

disp('TEAP loaded - Copyright 2016, TEAP contributors')
disp('This program comes with ABSOLUTELY NO WARRANTY')
disp('This is free software, and you are welcome to redistribute it')
disp('under the GPLv2 licence')
disp('Happy emotion analysis !')



% The main documentation for TEAP, to be used by doxygen
% \mainpage TEAP
% \section What is TEAP ?
% \section Baby don't hurt me, no more
