%> @file DMY_aqn_file.m
function Signal = DMY_aqn_file(filename)
% DMY_AQN_FILE gets a DMY signal from a filename

Signal = DMY_new_empty();
Signal = Signal__set_samprate(10); %Hz
Signal = Signal__set_raw(rand(1, 60));


end

