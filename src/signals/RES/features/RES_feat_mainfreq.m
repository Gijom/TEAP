function [mainFreq] = RES_feat_mainfreq(RESsignal)
%Computes the main frequency of a respiration signal.
% Inputs:
%  RESsignal: the RES signal.
%
%Outputs:
%  mainFreq: the main respiration frequency, given in Hz
%
%Copyright Guillaume Chanel 2013
%Copyright Frank Villaro-Dixon, BSD Simplified, 2014


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
[RespPower, fResp] = pwelch(Resp_filt, [], [], [], fs,'power');


%Take the frequencies we want
iFreqInterest = find(0.16 <= fResp & fResp <= 0.6);

[dummy, iMainFreq] = max(RespPower(iFreqInterest));

mainFreq = fResp(iFreqInterest(iMainFreq));

