%> @brief Computes the variance of a signal
%> @param  Signal
%> @retval  var: the calculated var, using the @c var() function
%
%> @author Copyright Frank Villaro-Dixon, BSD Simplified, 2014
function [variance] = Signal_feat_var(Signal)

Signal__assert_mine(Signal);

raw = Signal__get_raw(Signal);

variance = var(raw);


