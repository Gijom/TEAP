%> @file Bulk_load_eeglab.m
%> @brief Loads an EEGLab variable, into a TEAPhysio bulk signal, containing EEG, ECG,
%> GSR, etc.

%> @param EEGV the variable given by EEGLab (ex: load A.mat; Bulk_load_eeglab(EEG))

%> @retval BulkSig a TEAPhysio bulk signal vector

function [BulkSig] = Bulk_load_eeglab(EEGV)
%Copyright Frank Villaro-Dixon, BSD Simplified, 2014

if(nargin ~= 1)
	error('Usage: BulkSig = Bulk_load_eeglab(EEGV)');
end


%Number of epochs:
nEpochs = length(EEGV.epoch);


%foreach epoch
for iEpoch = [1:nEpochs]
	Bulk = Bulk_new_empty();

	Bulk = addEEG(Bulk, iEpoch);
	Bulk = addGSR(Bulk, iEpoch);
	Bulk = addHST(Bulk, iEpoch);
	Bulk = addRES(Bulk, iEpoch);
	Bulk = addBVP(Bulk, iEpoch);

	BulkSig(iEpoch) = Bulk;
	clear Bulk;
end


%EEG
function BulkSig = addEEG(BulkSig, iEpoch);
correspondance = ['Fp1'; 'AF3'; 'F3'; 'F7'; 'FC5'; 'FC1'; 'C3'; 'T7'; 'CP5'; ...
                  'CP1'; 'P3'; 'P7'; 'PO3'; 'O1'; 'Oz'; 'Pz'; 'Fp2'; 'AF4'; ...
                  'Fz'; 'F4'; 'F8'; 'FC6'; 'FC2'; 'Cz'; 'C4'; 'T8'; 'CP6'; ...
                  'CP2'; 'P4'; 'P8'; 'PO4'; 'O2'];

	numel = size(correspondance, 1);
	datlen = length(EEGV.data(1, :, 1));
	data = zeros(numel, datlen);

	for i = [1:numel]
		chaname = strtrim(correspondance(i, :));
		chan = findMyChannel(chaname);
%		disp(['Will do ' chaname ' - ' num2str(chan)]);
		if(chan == 0)
			warning(['The EEG channel ' correspondance(i, :) ' does not '...
			         'exist. Aborting EEG']);
			return;
		end
		data(1, :) = reshape(EEGV.data(chan, :, iEpoch), 1, datlen);
	end

	EEGSig = EEG_aqn_variable(correspondance, data, EEGV.srate);
	BulkSig = Bulk_add_signal(BulkSig, EEG__get_signame(), EEGSig);
end

%GSR
function BulkSig = addGSR(BulkSig, iEpoch)
	GSRChannel = findMyChannel('GSR1');
	if(GSRChannel == 0)
		return;
	end

	data = EEGV.data(GSRChannel, :, iEpoch);
	reshaped = reshape(data, 1, length(data));

	GSRSig = GSR_aqn_variable(reshaped, EEGV.srate);
	BulkSig = Bulk_add_signal(BulkSig, GSR__get_signame(), GSRSig);
end

%Temp/HST
function BulkSig = addHST(BulkSig, iEpoch)
	HSTChannel = findMyChannel('Temp');
	if(HSTChannel == 0)
		return;
	end

	data = EEGV.data(HSTChannel, :, iEpoch);
	reshaped = reshape(data, 1, length(data));

	HSTSig = HST_aqn_variable(reshaped, EEGV.srate);
	BulkSig = Bulk_add_signal(BulkSig, HST__get_signame(), HSTSig);
end

%Respiration
function BulkSig = addRES(BulkSig, iEpoch)
	RESChannel = findMyChannel('Resp');
	if(RESChannel == 0)
		return;
	end

	data = EEGV.data(RESChannel, :, iEpoch);
	reshaped = reshape(data, 1, length(data));

	RESSig = RES_aqn_variable(reshaped, EEGV.srate);
	BulkSig = Bulk_add_signal(BulkSig, RES__get_signame(), RESSig);
end

%BVT/Plet
function BulkSig = addBVP(BulkSig, iEpoch)
	BVPChannel = findMyChannel('Plet');
	if(BVPChannel == 0)
		return;
	end

	data = EEGV.data(BVPChannel, :, iEpoch);
	reshaped = reshape(data, 1, length(data));

	BVPSig = BVP_aqn_variable(reshaped, EEGV.srate);
	BulkSig = Bulk_add_signal(BulkSig, BVP__get_signame(), BVPSig);
end


%Find my channel
function iChannel = findMyChannel(chanName)
	for iChannel = [1:length(EEGV.chanlocs)]
%		disp(['Will compare ' chanName ' and ' EEGV.chanlocs(iChannel).labels]);
		if(strcmp(chanName, EEGV.chanlocs(iChannel).labels) == 1)
			return;
		end
	end
	iChannel = 0;
end


end

