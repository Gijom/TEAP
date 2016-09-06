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

%> @file Bulk_load.m
%> @brief Loads a bdf file, into a TEAP bulk signal, containing EEG, ECG,
%> GSR, etc.
%> @param file_name: this variable includes the full path; 
%> it can be any file supported by biogs sload/sopn

%> @retval BulkSig a TEAP bulk signal vector

function [BulkSig] = Bulk_load(file_name)
%Copyright Mohammad Soleymani, 2014

if(nargin ~= 1)
	error('Usage: BulkSig = Bulk_load(phys_data)');
end

if (~exist(file_name, 'file'))
	error('Usage: the input file does not exist');
end
% if it is a mat file; it is assumed to be an EEGLAB file
if strcmp(file_name(end-2:end),'mat')
	S = load(file_name);
	vars = fieldnames(S);
	phys_data = S.(vars{1});
else %otherwise load the file
	phys_data = pop_biosig(file_name);
end

%initialize signals to load
config_file;

%initialize EEG electrode labels
signals = {};
electrode_labels = struct;
config_file;

%Number of epochs:
nEpochs = length(phys_data.epoch);


%foreach epoch
if nEpochs>0
	for iEpoch = [1:nEpochs]
		Bulk = Bulk_new_empty();
		for signal = signals
			eval(['Bulk = add' signal{1} '(Bulk, iEpoch, electrode_labels.' signal{1} ');']);
		end
		BulkSig(iEpoch) = Bulk;
		clear Bulk;
	end
else
	Bulk = Bulk_new_empty();
	for signal = signals
		eval(['Bulk = add' signal{1} '(Bulk, 0, electrode_labels.' signal{1} ');']);
	end
	BulkSig(1) = Bulk;
	clear Bulk;
	
end

%EEG
	function BulkSig = addEEG(BulkSig, iEpoch,correspondance)
		numel = length(correspondance);
		datlen = length(phys_data.data(1, :, 1));
		data = zeros(numel, datlen);
		
		for i = [1:numel]
			chaname = strtrim(correspondance{i});
			chan = findMyChannel(chaname);
			%		disp(['Will do ' chaname ' - ' num2str(chan)]);
			if(chan == 0)
				warning(['The EEG channel ' correspondance{i} ' does not '...
					'exist. Aborting EEG']);
				return;
			end
			if iEpoch ==0
				data(i,:) = squeeze(phys_data.data(chan, :));
			else
				data(i, :) = squeeze(phys_data.data(chan, :, iEpoch));
			end
		end
		
		EEGSig = EEG_aqn_variable(correspondance, data, phys_data.srate);
		BulkSig = Bulk_add_signal(BulkSig, EEG__get_signame(), EEGSig);
	end

%GSR
	function BulkSig = addGSR(BulkSig, iEpoch,correspondance)
		GSRChannel = findMyChannel(correspondance{1});
		if(GSRChannel == 0)
			return;
		end
		if iEpoch ==0
			data = phys_data.data(GSRChannel, :);
		else
			data = phys_data.data(GSRChannel, :, iEpoch);
		end
		
		GSRSig = GSR_aqn_variable(squeeze(data), phys_data.srate);
		BulkSig = Bulk_add_signal(BulkSig, GSR__get_signame(), GSRSig);
	end

%Temp/HST
	function BulkSig = addHST(BulkSig, iEpoch,correspondance)
		HSTChannel = findMyChannel(correspondance{1});
		if(HSTChannel == 0)
			return;
		end
		if iEpoch ==0
			data = phys_data.data(HSTChannel, :);
		else
			data = phys_data.data(HSTChannel, :, iEpoch);
		end
		
		HSTSig = HST_aqn_variable(squeeze(data), phys_data.srate);
		BulkSig = Bulk_add_signal(BulkSig, HST__get_signame(), HSTSig);
	end

%Respiration
	function BulkSig = addRES(BulkSig, iEpoch,correspondance)
		RESChannel = findMyChannel(correspondance{1});
		if(RESChannel == 0)
			return;
		end
		if iEpoch ==0
			data = phys_data.data(RESChannel, :);
		else
			data = phys_data.data(RESChannel, :, iEpoch);
		end
		
		RESSig = RES_aqn_variable(squeeze(data), phys_data.srate);
		BulkSig = Bulk_add_signal(BulkSig, RES__get_signame(), RESSig);
	end

%BVT/Plet
	function BulkSig = addBVP(BulkSig, iEpoch,correspondance)
		BVPChannel = findMyChannel(correspondance{1});
		if(BVPChannel == 0)
			return;
		end
		if iEpoch ==0
			data = phys_data.data(BVPChannel, :);
		else
			data = phys_data.data(BVPChannel, :, iEpoch);
		end
		
		BVPSig = BVP_aqn_variable(squeeze(data), phys_data.srate);
		BulkSig = Bulk_add_signal(BulkSig, BVP__get_signame(), BVPSig);
	end

%EMG
	function BulkSig = addEMG(BulkSig, iEpoch,correspondance)
		for i = 1:length(correspondance)
			EMGChannel(i) = findMyChannel(correspondance{i});
		end
		if any(EMGChannel == 0)
			return;
		end
		if iEpoch ==0
			data = phys_data.data(EMGChannel, :);
		else
			data = phys_data.data(EMGChannel, :, iEpoch);
		end
		temp = squeeze(zeros(size(data,1)/2,size(data,2),size(data,3)));
		if mod(size(data,1),2)==0
			for j = 1:size(data,1)/2
				temp(j,:,:) = data(j*2-1,:,:) - data(j*2,:,:); %subtracting two leads
			end
			data = temp;
		else
			error('Usage: You need two leads!');
		end
			EMGSig = EMG_aqn_variable(squeeze(data), phys_data.srate);
			BulkSig = Bulk_add_signal(BulkSig, EMG__get_signame(), EMGSig);
	end

%ECG
	function BulkSig = addECG(BulkSig, iEpoch,correspondance)
		for i = 1:length(correspondance)
			ECGChannel(i) = findMyChannel(correspondance{i});
		end
		if any(ECGChannel == 0)
			return;
		end
		if iEpoch ==0
			data = phys_data.data(ECGChannel, :);
		else
			data = phys_data.data(ECGChannel, :, iEpoch);
			data = squeeze(data);
		end
		if size(data,1)==2
			data = data(1,:,:) - data(2,:,:); %subtracting two leads
		elseif size(data,1)>2
			error('Usage: We dont support more than two leads at the moment!');
		else
			error('Usage: You need two leads at least!');
		end
		
		ECGSig = ECG_aqn_variable(data, phys_data.srate);
		BulkSig = Bulk_add_signal(BulkSig, ECG__get_signame(), ECGSig);
	end

%Find my channel
	function iChannel = findMyChannel(chanName)
		for iChannel = [1:length(phys_data.chanlocs)]
			%		disp(['Will compare ' chanName ' and ' phys_data.chanlocs(iChannel).labels]);
			if(strcmp(chanName, phys_data.chanlocs(iChannel).labels) == 1)
				return;
			end
		end
		iChannel = 0;
        warning(['Could not find channel ' chanName ', it will not be included in the bulk. Please correct the configuration file (config_file.m) accordingly'])
	end


end

