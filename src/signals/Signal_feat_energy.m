function [ENR] = Signal_feat_energy(Signal)
%Computes the energy of a signal
% Inputs:
%  Signal:
% Outputs:
%  ENR, the energy
%
%Copyright Frank Villaro-Dixon Creative Commons BY-SA 4.0 2014

Signal__assert_mine(Signal);
raw = Signal__get_raw(Signal);

ENR = sum(raw .^ 2);


