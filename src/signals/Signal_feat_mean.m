%> @brief Computes the mean of a signal
%> @param Signal: The signal you want to calculate the mean
%> @retval  MEAN: the mean, calculated using the mean() function
%
%> @author Copyright Frank Villaro-Dixon, BSD Simplified, 2014
function [MEAN] = Signal_feat_mean(Signal)

Signal__assert_mine(Signal);
raw = Signal__get_raw(Signal);

MEAN = mean(raw);


