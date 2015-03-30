function [Result] = DMY_feat_feat1(Signal)
%Computes feature feat1 from a DMY signal Signal. The result is stored in the
%signal cache, then returned.
%if the feature was already comptued for this signal, only fetches-it.
%NB: if you want to use the cache, you have to reassign the signal: eg.
% [featureWanted Signal] = DMY_feat_feat1(Signal)

Signal = DMY_assert_type(Signal)


Result = 42;
