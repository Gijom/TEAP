%> @file BVP_feat_var.m
%> @brief Computes the variance of a @b BVP signal
%> @param  BVPSignal: the @b BVP signal
%> @retval mvar: the signal's variance
%
%> @author Copyright Frank Villaro-Dixon, BSD Simplified, 2014
function mvar = BVP_feat_var(BVPSignal)

%Make sure we have an BVP signal
BVPSignal = BVP__assert_type(BVPSignal);

mvar = Signal_feat_var(BVPSignal);

end

