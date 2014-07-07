function Signal_assert_mine(Signal)
%Asserts that the signal is a TEAPhysio one
% Inputs:
%  Signal: the signal to test
%
%Copyright Frank Villaro-Dixon Creative Commons BY-SA 4.0 2014

if(nargin ~= 1)
	error('Usage: Signal_assert_mine(Signal)');
end

if(~isfield(Signal, 'TEAPhysio'))
	error('The signal given is not a TEAPhysio one')
end

%!error(Signal_assert_mine(42))
%!error(Signal_assert_mine())
