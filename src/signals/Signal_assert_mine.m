function Signal_assert_mine(Signal)
%Asserts that the signal is a TEAPhysio one
% Inputs:
%  Signal: the signal to test
%
%Copyright Frank Villaro-Dixon Creative Commons BY-SA 4.0 2014

if(~isfield(Signal, 'TEAPhysio'))
	error('The signal given is not a TEAPhysio one')
end


