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
%signals should be  in columns for pwelch to work for a multi-channel case
%like when we have more than one EMG signal
if size(raw,1)<size(raw,2)
    raw = raw';
end
welch_window_size = fs* 10;
if 1/min(bands(:))> welch_window_size/fs
        warning('This welch window size is too small for your bands and the results are incorrect- consider increasing it');
end

powerBands = nan(min(size(raw)),size(bands,1));

if size(raw,2)< welch_window_size +fs
    warning('singal too short for the welch size');
end
if size(raw,2)< welch_window_size +1
    warning('singal too short for the welch size and this method will not work')

else
    
    for i = 1:size(raw,2)
        [P(:,i),f] = pwelch(raw,welch_window_size,[],[],fs);
    end
    %features for every band
    
    
    for j = 1:size(raw,2)
        for i = 1:size(bands,1)
            powerBands(j,i) = log(sum(P(f> bands(i,1)& f<=bands(i,2),j))+eps);
        end
    end
    
end



