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

%> @file ECG_feat_IBImean.m
%> @brief Computes the InterBeatInterval mean of an ECG signal
%> @param  ECGSignal: the ECG signal
%> @retval IBIMean: the InterBeatInterval mean
%
%> @author Copyright Guillaume Chanel 2013
%> @author Copyright Frank Villaro-Dixon, BSD Simplified, 2014
function IBIMean = ECG_feat_IBImean(ECGSignal)


%Make sure we have an ECG signal
ECGSignal = ECG__assert_type(ECGSignal);

%Compute IBI
ECG__compute_IBI(ECGSignal);

%Compute average
IBIMean = mean(Signal__get_raw(ECGSignal.IBI));

end

