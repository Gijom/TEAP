function [bpm delta_t t] = PICtoBPM(listePic, fe)
%Computes BPM and IBI from a list of pics
% INPUTS:
%  listePic: list of samples containing a pic
%  fe: sampling frequency
%
% OUTPUTS:
%  bpm: beat per minuts
%  delta_t: Interbeat intervals (IBI)
%  t: sample (possibly 1/2 samples) at which the IBI is computed, this is
%     in fact the average of the start and end beats samples (i.e. the HR
%     considered to lies inbetween the two beats).
%
% Author: Guillaume Chanel

bpm =[];
t = [];
deltaSamp = [];
for(j=2:length(listePic))
	deltaSamp(j-1) = listePic(j)-listePic(j-1);
	if(deltaSamp(j-1) <= 0)
		error('L''ecart entre deux pic doit etre de 1 minimum');
	end
	bpm(j-1) = 60/(deltaSamp(j-1)*(1/fe));
	t(j-1) = mean([listePic(j-1) listePic(j)]);
end
delta_t = deltaSamp / fe;

