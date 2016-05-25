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

%> @file Bulk_get_signal.m
%> @brief Takes a specific signal from a bulk signal

%> @param BulkSignal the bulk signal containing all the specific signals
%> @param typeWanted the type you want (ex: 'HST', etc. Defined by SSS_get_signame !)

%> @retval Signal the wanted signal. FAILS if does not exist
%Copyright Frank Villaro-Dixon, 2014

function [Signal] = Bulk_get_signal(BulkSignal, typeWanted)

if(nargin ~= 2)
	error('Usage: Signal = Bulk_get_signal(BulkSignal, typeWanted);');
end

Bulk_assert_mine(BulkSignal);

if(~isfield(BulkSignal, typeWanted))
	error(['The signal ' typeWanted ' is not included in this bulk signal']);
end

Signal = BulkSignal.(typeWanted);

