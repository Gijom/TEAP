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

%> @file Signal_plot.m
%> @brief Plots a signal: value vs time, between startT and entT.
%> @c Signal_plot(sig); @c Signal_plot(sig, start); @c Signal_plot(sig, start, end);
%> @attention NOTA BENE: if you want to display a bulk signal instead, use Bulk_plot(Bulk);

%> @param  Signal: the sigal to plot
%> @param  startT: the start time, in frames (optional)
%> @param  endT: the end time, or 0 if all the signal (optional)
%
%> @author Copyright Frank Villaro-Dixon, 2014
function Signal_plot(Signal, startT, endT)

raw = Signal__get_raw(Signal);

if(nargin < 2)
	startT = 1;
	endT = 0;
elseif(nargin < 3)
	endT = 0;
end

%mainly (only?) for EEG
if(isstruct(raw))
	figure; %FIXME: embed within
	%use things like parent=axes('Parent'); or things like that

	fields = fieldnames(raw);
	sq = ceil(sqrt(size(fields, 1)));
	for i = [1:size(fields)]
		subplot(sq, sq, i);

		%This is a copy !
		Sig_copy = Signal__set_raw(Signal, raw.(fields{i}));
		Sig_copy = Signal__set_signame(Sig_copy, [Signal__get_signame(Signal) ' - ' ...
		                                       fields{i}]);

		Signal_plot(Sig_copy, startT, endT);
	end
	return
else %for 1D signals
	Signal_plot1D(Signal, startT, endT);
end

