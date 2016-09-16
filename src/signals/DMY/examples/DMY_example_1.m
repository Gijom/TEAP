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
%> @file DMY_example_1.m
Sig = DMY_aqn_file();

[feature1 Sig] = DMY_feat_feat1(Sig);

%And once again
[feature Sig] = DMY_feat_feat1(Sig); %Cache used


%Note that with another signal of a different type:
Sig2 = Signal__new_empty();
[feature Sig2] = DMY_feat_feat1(Sig2); %This wont work

