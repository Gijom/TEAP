function mstd = BVP_feat_std(BVPSignal)
%Computes the std of a BVP signal
% Inputs:
%  BVPs: the BVP signal
% Outputs:
%  mstd: the signal's std
%
%Copyright Frank Villaro-Dixon Creative Commons BY-SA 4.0 2014


%Make sure we have an BVP signal
BVPSignal = BVP_assert_type(BVPSignal);

mstd = Signal_feat_std(BVPSignal);

end

