%Launches the toolbox

%Where the toolbox is
[folder, ~, ~] = fileparts(mfilename('fullpath'));
folder(folder=='\')='/';
%Add all the folders of the toolbox
addpath(genpath(folder))
clear folder

