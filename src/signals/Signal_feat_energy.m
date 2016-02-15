%> @file Signal_feat_energy.m
%> @brief Computes the energy of a signal
%> @param  Signal:
%> @retval ENR the energy, as the sum of each (element squared)
%
%> @author Copyright Frank Villaro-Dixon, BSD Simplified, 2014
function [ENR] = Signal_feat_energy(Signal)

Signal__assert_mine(Signal);
raw = Signal__get_raw(Signal);

ENR = sum(raw .^ 2);


