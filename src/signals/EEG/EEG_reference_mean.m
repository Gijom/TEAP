function EEGSignal = EEG_reference_mean(EEGSignal)
%Creates a reference for the EEG signal; aka 'normalises' the signal
% Inputs:
%  EEGSignal: the EEG signal
% Outputs:
%  EEGSignal: the referenced EEG signal
%
%Copyright Frank Villaro-Dixon Creative Commons BY-SA 4.0 2014

if(nargin ~= 1 || nargout ~= 1)
	error('Usage: EEGSignal = EEG_reference_mean(EEGSignal);');
end

EEG__assert_type(EEGSignal);

raw = Signal__get_raw(EEGSignal);

electrodes = fieldnames(raw);

for i = [1:length(electrodes)]
	%Take the signal we want
	electrode = EEG_get_channel(EEGSignal, electrodes{1});

	eMean = mean(electrode);
	electrode = electrode - eMean;
	EEGSignal = EEG_set_channel(EEGSignal, electrodes{1}, electrode);
	%TODO: set up flag to say referenced
end
