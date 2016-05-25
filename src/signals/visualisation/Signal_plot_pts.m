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

%> @file Signal_plot_pts.m
%> @brief Plots some (xval, yval) points on the graph. You have to use this function if
%> your xvals are in the frame domain (aka not secs like the graph produced by
%> @c Signal_plot. This function just divides xval by @c Signal__get_samprate(Signal).
%> HOLDs ON the graph, so you don't have to do it yourself ;)
%
%> @param  Signal: your signal
%> @param  xvals: the x values of your points. IN FRAMES (not secs !)
%> @param  yvals: the y values
%> @param  props: plot properties (like 'r*')
%
%> @author Copyright Frank Villaro-Dixon, BSD Simplified, 2014
function Signal_plot_pts(Signal, xvals, yvals, props)

samprate = Signal__get_samprate(Signal);

xvals = xvals / samprate;

hold on;
plot(xvals, yvals, props);
hold off;

