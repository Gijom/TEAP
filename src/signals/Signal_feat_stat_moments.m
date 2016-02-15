%> @file Signal_feat_stat_moments.m
%> @brief Computes the statistical moments for the input signals

%> @param  Signal

%> @retval  MU: the calculated std, using the @c mean() function
%> @retval STD: the calculated std, using the @c std() function
%> @retval KU: the calculated Kurtosis, using the @c kurtosis() function
%> @retval SK: the calculated skewness, using the @c skewness() function

%> @author Copyright Moahmmad Soleymani and Frank Villaro-Dixon, BSD Simplified, 2015
function [mean_,std_, kurtosis_, skewness_]= Signal_feat_stat_moments(Signal)

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


