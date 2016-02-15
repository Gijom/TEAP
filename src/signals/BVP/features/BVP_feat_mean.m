%> @brief Computes the mean of a @b BVP signal
%> @param  BVPs: the BVP signal
% Outputs:
%> @retval  mmean: the signal's mean
%
%> @author Copyright Frank Villaro-Dixon, BSD Simplified, 2014
function mmean = BVP_feat_mean(BVPSignal)

%Make sure we have an BVP signal
BVPSignal = BVP__assert_type(BVPSignal);

mmean = Signal_feat_mean(BVPSignal);

end

