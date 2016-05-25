%Launches the toolbox

%Where the toolbox is
[folder, ~, ~] = fileparts(mfilename('fullpath'));
folder(folder=='\')='/';
%Add all the folders of the toolbox
addpath(genpath(folder))
clear folder

% The main documentation for TEAP, to be used by doxygen
% \mainpage TEAP
% \section What is TEAP ?
% \section Baby don't hurt me, no more
