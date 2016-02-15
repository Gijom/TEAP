%> @file BVP__assert_type.m
%> @brief Asserts that the given signal is a @b BVP one
%> Please refer to @c Signal__assert_type for more and extensive documentation ;)
function [Signal, Bulk] = BVP__assert_type(Signal)

if(nargin ~= 1 || nargout > 2)
	error('Usage: [Signal, Bulk] = BVP__assert_type(Signal)');
end


[Signal, Bulk] = Signal__assert_type(Signal, BVP__get_signame());

