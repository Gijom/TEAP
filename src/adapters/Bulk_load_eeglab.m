function [BulkSig] = Bulk_load_eeglab(EEGLabVar)
%Loads an EEGLab variable, into a TEAPhysio bulk signal, containing EEG, ECG,
%GSR, etc.
% Inputs:
%  EEGLabVar: the variable given by EEGLab (ex: load A.mat; Bulk_load_eeglab(EEG))
% Outputs:
%  BulkSig: a TEAPhysio bulk signal
%
%Copyright Frank Villaro-Dixon Creative Commons BY-SA 4.0 2014

if(nargin ~= 1)
	error('Usage: BulkSig = Bulk_load_eeglab(EEGLabVar)');
end

%Operate channel by channel

BulkSig.tatat = 42;

for ichannel = [1:size(EEGLabVar.chanlocs)]
	chanName = EEGLabVar.chanlocs(ichannel).labels;

	BulkSig = processChannel(ichannel, BulkSig);
end

function [BulkSig] = processChannel(ichannel, BulkSig)
	disp(['I have ' num2str(ichannel) ' - ' EEGLabVar.chanlocs(ichannel).labels]);
	chanName = EEGLabVar.chanlocs(ichannel).labels;

	switch(chanName)
	case 'GSR1'
		GSRSig = GSR_aqn_variable(
		Bulk
end


end

