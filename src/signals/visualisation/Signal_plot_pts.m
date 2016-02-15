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

