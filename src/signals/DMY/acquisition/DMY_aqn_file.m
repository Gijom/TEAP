function Signal = DMY_aqn_file(filename)
% DMY_AQN_FILE gets a DMY signal from a filename

Signal = DMY_new_empty();

Signal.sampFreq = 10; %Hz
Signal.raw = rand(1, 60);


end

