%This file is part of TEAP.
%
%TEAP is free software: you can redistribute it and/or modify
%it under the terms of the GNU General Public License as published by
%the Free Software Foundation, either version 3 of the License, or
%(at your option) any later version.
%
%TEAP is distributed in the hope that it will be useful,
%but WITHOUT ANY WARRANTY; without even the implied warranty of
%MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%GNU General Public License for more details.
%
%You should have received a copy of the GNU General Public License
%along with TEAP.  If not, see <http://www.gnu.org/licenses/>.
% 
%> @file Bulk_update_signal.m
%> @brief Updates a signal in the bulk signal
% 
%> @param BulkSig the bulk collection
%> @param signame the signal name (ex: 'HST')
%> @param sig the actual signal (ex: after HST_aqn_variable)
% 
%> @retval BulkSig the bulksignal with the signal updated
function [BulkSig] = Bulk_update_signal(BulkSig, signame, sig)
%Copyright Frank Villaro-Dixon, Guillaume Chanel, 2014

if(nargin ~= 3 || nargout ~= 1)
	error('Usage: BulkSig = Bulk_add_signal(BulkSig, signame, sig)');
	%Matlab does not have a print_usage like command
end

Bulk_assert_mine(BulkSig);
BulkSig.(signame) = sig;

