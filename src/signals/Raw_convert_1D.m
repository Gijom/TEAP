function Raw = Raw_convert_1D(Raw)
%Takes a raw signal and reshapes-it into a good form (aka 1D horizontal signal,
% [1xN];

[y, x] = size(Raw);

if(y ~= 1) %If somewhat vertical
	if(x ~= 1) %but also somewhat horizontal
		error('Signal should be a 1D vector')
	end
	%Auto reshape with warning
	Raw = reshape(Raw, 1, length(Raw));
	warning('Signal should be [1xN] (aka horizontal). Automaticly reshaped');
end



