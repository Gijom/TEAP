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

%> @file Signal_feat_bandEnergy.m
%> @brief Computes the standard deviation of a given signal
%> @author Copyright Mohammad Soleymani, 2015

%> @param  Signal
%> @param bands a 2 x n dimenional array including the bands lower and upper
%> bounds
%> @retval  band energy:it calculates energy in different bands
function [powerBands] = Signal_feat_bandEnergy(Signal, bands)


Signal__assert_mine(Signal);

raw = Signal__get_raw(Signal);

fs = Signal__get_samprate(Signal);

%signals should be  in columns for pwelch to work for a multi-channel case
%like when we have more than one EMG signal
if size(raw,1)<size(raw,2)
	raw = raw';
end
welch_window_size = fs* 10;

% to check the first band limit after 0
bands_flat = bands(:);
if min(bands_flat)==0
	min_f = bands_flat(find(bands_flat>0,1,'first'));
else
	min_f = min(bands_flat);
end

if 1/min_f> welch_window_size/fs
	warning('This welch window size is too small for your bands and the results are incorrect- consider increasing it');
end

powerBands = nan(min(size(raw)),size(bands,1));

if size(raw,1)< welch_window_size +fs
	warning('singal too short for the welch size');
end
if size(raw,1)< welch_window_size +1
	warning('singal too short for the welch size and this method will not work')

else
	for i = 1:size(raw,2)
		[P(:,i),f] = pwelch(raw(:,i),welch_window_size,[],[],fs);
	end

	%features for every band
	for j = 1:size(raw,2)
		for i = 1:size(bands,1)
			powerBands(j,i) = log(sum(P(f> bands(i,1)& f<=bands(i,2),j))+eps);
		end
	end

end

