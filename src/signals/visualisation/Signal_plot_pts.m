function Signal_plot_pts(Signal, xvals, yvals, props)
%Plots some (xval, yval) points on the graph. You have to use this function if
% your xvals are in the frame domain (aka not secs like the graph produced by
% Signal_plot. This function just divides xval by Signal_get_samprate(Signal).
% HOLDs ON the graph, so you don't have to do it yourself ;)
% Inputs:
%  Signal: your signal
%  xvals: the x values of your points. IN FRAMES (not secs !)
%  yvals: the y values
%  props: plot properties (like 'r*')
%
%Copyright Frank Villaro-Dixon Creative Commons BY-SA 4.0 2014

samprate = Signal_get_samprate(Signal);

xvals = xvals / samprate;

hold on;
plot(xvals, yvals, props);
hold off;
