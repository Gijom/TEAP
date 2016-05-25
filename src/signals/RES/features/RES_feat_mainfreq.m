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

%> @file RES_feat_mainfreq.m
%> @brief Computes the main frequency of a respiration signal.

%> @param  RESsignal: the RES signal.

%> @retval mainFreq: the main respiration frequency, given in Hz

%> @author Copyright Guillaume Chanel 2013
%> @author Copyright Frank Villaro-Dixon, 2014

function [mainFreq] = RES_feat_mainfreq(RESsignal)


%Make sure we have a RES signal
RESsignal = RES__assert_type(RESsignal);


raw = Signal__get_raw(RESsignal);
fs = Signal__get_samprate(RESsignal);

%Make a filter for our signal
Fpeak = 0.375;  % Peak Frequency
BW    = 0.5;    % Bandwidth
Apass = 1;      % Bandwidth Attenuation
[b, a] = iirpeak(Fpeak/(fs/2), BW/(fs/2), Apass);
Resp_filt = filtfilt(b, a, raw);

if length(Resp_filt)<60*fs
    warning('Resp signal too short cannot calculate the spectral features - result of the central respiration frequency is not goign to be reliable')
end
%Compute the energy spectrum
win_length = round(length(Resp_filt)/4.5);
nfft = sqrt(2^ceil(log2(win_length)));

if nfft<256
    nfft = 256;
end
%had to specify for compatibility between octave and matlab
[RespPower, fResp] = pwelch(Resp_filt, win_length, 0.5, nfft, fs,'power');

%Take the frequencies we want
iFreqInterest = find(0.16 <= fResp & fResp <= 0.6);

[dummy, iMainFreq] = max(RespPower(iFreqInterest));

mainFreq = fResp(iFreqInterest(iMainFreq));
% if isempty(mainFreq)
%     mainFreq = NaN;
% end
    
