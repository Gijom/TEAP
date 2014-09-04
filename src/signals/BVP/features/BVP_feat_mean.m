function mmean = BVP_feat_mean(BVPSignal)
%Computes the mean of a BVP signal
% Inputs:
%  BVPs: the BVP signal
% Outputs:
%  mmean: the signal's mean
%
%Copyright Frank Villaro-Dixon Creative Commons BY-SA 4.0 2014


%Make sure we have an BVP signal
BVPSignal = BVP_assert_type(BVPSignal);

mmean = Signal_feat_mean(BVPSignal);

end

