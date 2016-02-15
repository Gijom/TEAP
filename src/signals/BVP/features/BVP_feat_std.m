%> @brief Computes the std of a BVP signal
%> @param  BVPs: the BVP signal
%> @retval  mstd: the signal's std
%
%> @author Copyright Frank Villaro-Dixon, BSD Simplified, 2014
function mstd = BVP_feat_std(BVPSignal)

%Make sure we have an BVP signal
BVPSignal = BVP__assert_type(BVPSignal);

mstd = Signal_feat_std(BVPSignal);

end

