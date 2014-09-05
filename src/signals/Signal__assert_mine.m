function Signal__assert_mine(Signal)
%Asserts that the signal is a TEAPhysio one
% Inputs:
%  Signal: the signal to test
%
%Copyright Frank Villaro-Dixon MIT LICENSE, 2014

if(nargin ~= 1)
	error('Usage: Signal__assert_mine(Signal)');
end

if(isfield(Signal, 'TEAPhysio'))
	if(Signal.TEAPhysio == 'S')
		return;
	end
end

error('The signal given is not a TEAPhysio one')

%!error(Signal__assert_mine(42))
%!error(Signal__assert_mine())

