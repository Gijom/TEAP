function [BulkSig] = Bulk_load_eeglab(EEGV)
%Loads an EEGLab variable, into a TEAPhysio bulk signal, containing EEG, ECG,
%GSR, etc.
% Inputs:
%  EEGV: the variable given by EEGLab (ex: load A.mat; Bulk_load_eeglab(EEG))
% Outputs:
%  BulkSig: a TEAPhysio bulk signal vector
%
%Copyright Frank Villaro-Dixon Creative Commons BY-SA 4.0 2014

if(nargin ~= 1)
	error('Usage: BulkSig = Bulk_load_eeglab(EEGV)');
end


%Number of epochs:
nEpochs = length(EEGV.epoch);


%foreach epoch
for iEpoch = [1:nEpochs]
	clear Bulk;
	Bulk.tatat = 42;

	Bulk = addGSR(Bulk, iEpoch);

	BulkSig(iEpoch) = Bulk;
end



%GSR
function BulkSig = addGSR(BulkSig, iEpoch);
	GSRChannel = 41; %FIXME: my examples don't work: negative RES
	if(strcmp('GSR1', EEGV.chanlocs(GSRChannel).labels) ~= 1)
		disp(['nonon: ' EEGV.chanlocs(GSRChannel).labels]);
		return;
	end

	data = EEGV.data(GSRChannel, :, iEpoch);
	reshaped = reshape(data, 1, length(data));
	plot(reshaped)
	GSRSig = GSR_aqn_variable(reshaped, EEGV.srate);
	Bulk.(GSR_get_name()) = GSRSig;
end



end

