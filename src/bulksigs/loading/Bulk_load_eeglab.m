%This file is part of TEAP.
%
%TEAP is free software: you can redistribute it and/or modify
%it under the terms of the GNU General Public License as published by
%the Free Software Foundation, either version 3 of the License, or
%(at your option) any later version.
%
%TEAP is distributed in the hope that it will be useful,
%but WITHOUT ANY WARRANTY; without even the implied warranty of
%MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%GNU General Public License for more details.
%
%You should have received a copy of the GNU General Public License
%along with TEAP.  If not, see <http://www.gnu.org/licenses/>.

%> @file Bulk_load_eeglab.m
%> @brief Loads an EEGLab variable, into a TEAP bulk signal, containing EEG, ECG,
%> GSR, etc.

%> @param EEGV the variable given by EEGLab (ex: load A.mat; Bulk_load_eeglab(EEG))

%> @retval BulkSig a TEAP bulk signal vector

function [BulkSig] = Bulk_load_eeglab(EEGV)
%Copyright Frank Villaro-Dixon, 2014

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

