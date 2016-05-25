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

%> @file Signal__assert_type.m
%> @brief Checks that the signal given on the input is of the type nameWanted
%> This function is mainly used by @b SSS_assert_type(Sig), with params @b Sig and @b SSS.

%> @attention NOTA BENE: in the case that Signal is a BULK signal, this function will
%> return, if it exists, the wanted signal, or fail if it doesn't.

%> @param  Signal: The signal you want to make sure of the type (can be a BULK signal,
%>          in that case, will take the component.
%> Bulk: if the input is a bulk than the bulk is also returned to keep a
%>        backup of it. An empty vector is returned if the input is not a Bulk
%> @param  nameWanted: the type the signal must be of (ex: 'GSR').

%> @retval  Signal: the signal. Can be the same as the input if single signal, or the
%>          signal from the bulk if the input signal is a bulk one.

function [Signal, Bulk] = Signal__assert_type(Signal, nameWanted)

if(nargin ~= 2 || nargout > 2)
	%If matlab was clever, they'd have implemented print_usage, like octave
	error('Usage: [Signal, Bulk] = Signal__assert_type(Signal, nameWanted)')
end

if(~isfield(Signal, 'TEAPhysio'))
	error('The signal seems not to be a TEAP one.');
end

if(length(Signal) ~= 1)
	error(['You seem to have given a bulk signal with multiple epochs. ' ...
	       'Could you please choose the epoch you want (eg: with Bulk(1))']);
end

%Initialize bulk to empty (in the case the input was not bulk)
Bulk = [];

%can either be a Bulk or a single signal
if(Signal.TEAPhysio == 'S') %Single speed ^W Signal
	Signal__assert_mine(Signal);
elseif(Signal.TEAPhysio == 'B') %Bulk signal
	%We have to choose the signal that we want
    Bulk = Signal;
	Signal = Bulk_get_signal(Signal, nameWanted); %Will fail if does not exist
else
	error('The signal type is unknown. Should either be Signal or Bulk');
end

%And then, compare their name (redundant for 2nd case, but anyways :p)
name = Signal__get_signame(Signal);
if(~strcmp(name, nameWanted))
	error(['Signal is of type: ' name '. Should be ' nameWanted])
end
