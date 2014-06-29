function Signal = DMY_aqn_file(filename)
% DMY_AQN_FILE gets a DMY signal from a filename

Signal = DMY_new_empty();
Signal = Signal_set_samprate(10); %Hz
Signal = Signal_set_raw(rand(1, 60));


end

