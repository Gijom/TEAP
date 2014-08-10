function [BulkSig] = Bulk_add_signal(BulkSig, signame, sig)
%Adds a signal to the bulk signal (and I love repetitions)
% Inputs:
%  BulkSig: the bulk collection
%  signame: the signal name (ex: 'HST')
%  sig: the actual signal (ex: after HST_aqn_variable)
% Outputs:
%  BulkSig: the bulksignal with the signal added
%
%Copyright Frank Villaro-Dixon Creative Commons BY-SA 4.0 2014

if(nargin ~= 3 || nargout ~= 1)
	error('Usage: BulkSig = Bulk_add_signal(BulkSig, signame, sig)');
	%Again, fuck matlab for not having a print_usage like command
end

Bulk_assert_mine(BulkSig);

if(isfield(BulkSig, signame))
	warning(['You are trying to add a signal that is already on the bulk'
	         ' signal. Il this wanted ?']);
 end

BulkSig.(signame) = sig;

