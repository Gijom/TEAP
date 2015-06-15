function [mean_,std_, kurtosis_, skewness_]= Signal_feat_stat_moments(Signal)
%Computes the statistical moments for the input signals
% Inputs:
%  Signal
% Outputs:
%  MU: the calculated std, using the mean() function
%  STD: the calculated std, using the std() function
%  KU: the calculated Kurtosis, using the kurtosis() function
%  SK: the calculated skewness, using the skewness() function

%Copyright Moahmmad Soleymani and Frank Villaro-Dixon, BSD Simplified, 2015

Signal__assert_mine(Signal);

raw = Signal__get_raw(Signal);
if ~isvector(raw)
    mean_ = mean(raw,2)';
    std_ = std(raw,[],2)';
    kurtosis_ = kurtosis(raw,[],2)';
    skewness_ = skewness(raw,[],2)';
    
else
    
    mean_ = mean(raw);
    std_ = std(raw);
    kurtosis_ = kurtosis(raw);
    skewness_ = skewness(raw);
    
end


