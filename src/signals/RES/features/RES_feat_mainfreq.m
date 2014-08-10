function [mainFreq] = RES_feat_mainfreq(RESsignal)
%Computes the main frequency of a respiration signal.
% Inputs:
%  RESsignal: the RES signal.
%
%Outputs:
%  mainFreq: the main respiration frequency, given in Hz
%
%Copyright Guillaume Chanel 2013
%Copyright Frank Villaro-Dixon Creative Commons BY-SA 4.0 2014


%Make sure we have a RES signal
RES_assert_type(RESsignal);


raw = Signal_get_raw(RESsignal);
fs = Signal_get_samprate(RESsignal);

%Make a filter for our signal
Fpeak = 0.375;  % Peak Frequency
BW    = 0.5;    % Bandwidth
Apass = 1;      % Bandwidth Attenuation
[b, a] = iirpeak(Fpeak/(fs/2), BW/(fs/2), Apass);
Resp_filt = filtfilt(b, a, raw);


%Compute the energy spectrum
[RespPower, fResp] = pwelch(Resp_filt, 30*fs, [], [], fs); %30 seconds segment

%Take the frequencies we want
iFreqInterest = find(0.16 <= fResp & fResp <= 0.6);


[dummy, iMainFreq] = max(RespPower(iFreqInterest));

mainFreq = fResp(iFreqInterest(iMainFreq));

