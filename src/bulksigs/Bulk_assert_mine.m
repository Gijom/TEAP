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

%> @file Bulk_assert_mine.m
%> @brief Asserts that the signal is a TEAPhysio bulk signal

%> @param BulkSignal the signal to test
%Copyright Frank Villaro-Dixon, BSD Simplified, 2014

function Bulk_assert_mine(BulkSignal)

if(nargin ~= 1)
	error('Usage: Bulk_assert_mine(BulkSignal)');
end

if(length(BulkSignal) ~= 1)
	error(['You seem to have given a bulk signal with multiple epochs. ' ...
	       'Could you please choose the epoch you want (eg: with Bulk(1))']);
end

if(isfield(BulkSignal, 'TEAPhysio'))
	if(BulkSignal.TEAPhysio == 'B')
		return;
	end
end

error('The signal given is not a TEAPhysio one')

%!error(Bulk_assert_mine(42))
%!error(Bulk_assert_mine())

