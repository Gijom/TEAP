function [powerBands] = Signal_feat_bandEnergy(Signal, bands)
%Computes the standard deviation of a given signal
% Inputs:
%  Signal
%  bands: a 2 x n dimenional array including the bands lower and upper
%  bounds
% Outputs:
%  band energy:it calculates energy in different bands
%
%Copyright Mohammad Soleymani, BSD Simplified, 2015


Signal__assert_mine(Signal);

raw = Signal__get_raw(Signal);

fs = Signal__get_samprate(Signal);

[P,f] = pwelch(raw,[],[],[],fs, 'power');
%features for every band
powerBands = zeros(size(bands,1),1);

for i = 1:size(bands,1)
    powerBands(i) = log(sum(P(f> bands(i,1)& f<=bands(i,2)))+eps);
end

    



