function mvar = BVP_feat_var(BVPSignal)
%Computes the variance of a BVP signal
% Inputs:
%  BVPs: the BVP signal
% Outputs:
%  mvar: the signal's variance
%
%Copyright Frank Villaro-Dixon, BSD Simplified, 2014


%Make sure we have an BVP signal
BVPSignal = BVP__assert_type(BVPSignal);

mvar = Signal_feat_var(BVPSignal);

end

