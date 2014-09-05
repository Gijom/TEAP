function [ENR] = Signal_get_enr(Signal)
%Computes the energy of a signal
% Inputs:
%  Signal
% Outputs:
%  ENR: the signal's energy
%
%Copyright Frank Villaro-Dixon MIT LICENSE, 2014

Signal__assert_mine(Signal);
raw = Signal__get_raw(Signal);

ENR = sum(raw.^2);


