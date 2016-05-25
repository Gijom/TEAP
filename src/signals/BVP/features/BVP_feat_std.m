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

%> @file BVP_feat_std.m
%> @brief Computes the std of a BVP signal
%> @param  BVPs: the BVP signal
%> @retval  mstd: the signal's std
%
%> @author Copyright Frank Villaro-Dixon, BSD Simplified, 2014
function mstd = BVP_feat_std(BVPSignal)

%Make sure we have an BVP signal
BVPSignal = BVP__assert_type(BVPSignal);

mstd = Signal_feat_std(BVPSignal);

end

