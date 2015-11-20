function EEGSignal = EEG_reference_mean(EEGSignal)
%re-references the EEG signals to their mean
%Creates a reference for the EEG signal; removed average reference' the signal
% Inputs:
%  EEGSignal: the EEG signal
% Outputs:
%  EEGSignal: the referenced EEG signal
%
%Copyright Frank Villaro-Dixon, BSD Simplified, 2014

if(nargin ~= 1 || nargout ~= 1)
	error('Usage: EEGSignal = EEG_reference_mean(EEGSignal);');
end

EEGSignal = EEG__assert_type(EEGSignal);

raw = Signal__get_raw(EEGSignal);

eMean = mean(cell2mat(struct2cell(raw)));

electrodes = fieldnames(raw);


for i = [1:length(electrodes)]
	%Take the signal we want
	electrode = EEG_get_channel(EEGSignal, electrodes{i});
	electrode = electrode - eMean;
	EEGSignal = EEG_set_channel(EEGSignal, electrodes{i}, electrode);
	%TODO: set up flag to say referenced
end
