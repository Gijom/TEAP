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

%> @file RES_feat_minmax.m
%> @brief Computes the peak-to-peak value of a respiration signal (aka greatest breath).
%> @param RESsignal the RES signal.
%> @retval  minmax: the greatest breath of the patient.
%> @author Copyright Guillaume Chanel 2013
%> @author Copyright Frank Villaro-Dixon, BSD Simplified, 2014
function [minmax] = RES_feat_minmax(RESsignal)

%Make sure we have a RES signal
RESsignal = RES__assert_type(RESsignal);

%Compute the features
if(~Signal__has_preproc_lowpass(RESsignal))
	warning(['For the function to work well, you should low-pass the signal' ...
	         '. Preferably with a median filter']);
end

raw = Signal__get_raw(RESsignal);

%%FIXME: this may be not always true ! Must find on single wave
minmax = max(raw) - min(raw);

