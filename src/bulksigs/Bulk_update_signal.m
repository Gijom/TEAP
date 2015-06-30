function [BulkSig] = Bulk_update_signal(BulkSig, signame, sig)
%Update a signal to the bulk signal
% Inputs:
%  BulkSig: the bulk collection
%  signame: the signal name (ex: 'HST')
%  sig: the actual signal (ex: after HST_aqn_variable)
% Outputs:
%  BulkSig: the bulksignal with the signal updated
%
%Copyright Frank Villaro-Dixon, Guillaume Chanel, BSD Simplified, 2014

if(nargin ~= 3 || nargout ~= 1)
	error('Usage: BulkSig = Bulk_add_signal(BulkSig, signame, sig)');
	%Matlab does not have a print_usage like command
end

Bulk_assert_mine(BulkSig);
BulkSig.(signame) = sig;

