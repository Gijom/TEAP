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
%> @file Signal_plot1D.m
%> @brief Plots a signal: value vs time, between startT and entT.
%> @c Signal_plot1D(sig); @c Signal_plot1D(sig, start); @c Signal_plot1D(sig, start, end);
%> @attention NOTA BENE: if you want to display a bulk signal instead, use Bulk_plot(Bulk);
% 
%> @param  Signal: the sigal to plot
%> @param  startT: the start time, in frames (optional)
%> @param  endT: the end time, or 0 if all the signal (optional)
%
%> @author Copyright Frank Villaro-Dixon, 2014
function Signal_plot1D(Signal, startT, endT)

raw = Signal__get_raw(Signal);
samprate = Signal__get_samprate(Signal);

name = Signal__get_signame(Signal);
signal_unit = Signal__get_unit(Signal);

if(nargin == 2)
	raw = raw(startT:end);
elseif(nargin == 3)
	if(endT == 0)
		raw = raw(startT:end);
	else
		raw = raw(startT:endT);
	end
end


xes = [1:length(raw)];

seconds = xes / samprate;

plot(seconds, raw);


offset = Signal__get_offset(Signal);

%The signal may be offseted with Signal__get_window. If so, say it
if(offset ~= 0)
	offsetT = offset / samprate;
	xlabel(['Seconds - ' num2str(offsetT) ' (offset)']);
else
	xlabel('Seconds');
end

%The y label title
if(Signal__has_preproc_lowpass(Signal))
	comments = ' (low passed)';
else
	comments = '';
end

ylabel([name ' (' signal_unit ')' comments]);


%The graph title
title([name ' vs Seconds']);


