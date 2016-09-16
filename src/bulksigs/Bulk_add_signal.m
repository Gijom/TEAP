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
%> @file Bulk_add_signal.m
%> @brief Adds a signal to the bulk signal (and I love repetitions)
%
%> @param BulkSig the bulk collection
%> @param signame the signal name (ex: 'HST')
%> @param sig the actual signal (ex: after HST_aqn_variable)
%
%> @retval BulkSig the bulksignal with the signal added
%> @author Copyright Frank Villaro-Dixon, 2014

function [BulkSig] = Bulk_add_signal(BulkSig, signame, sig)

if(nargin ~= 3 || nargout ~= 1)
	error('Usage: BulkSig = Bulk_add_signal(BulkSig, signame, sig)');
	%Matlab does not have a print_usage like command
end

Bulk_assert_mine(BulkSig);

if(isfield(BulkSig, signame))
	warning(['You are trying to add a signal that is already on the bulk signal. Is this wanted ? In the case you want to update the signal preferably use Bulk_update_signal']);
end

BulkSig.(signame) = sig;

