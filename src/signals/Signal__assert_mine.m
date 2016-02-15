%> @file Signal__assert_mine.m
%> @brief Asserts that the signal is a TEAPhysio one

%> @param  Signal: the signal to test

%> @author Copyright Frank Villaro-Dixon, BSD Simplified, 2014
function Signal__assert_mine(Signal)

if(nargin ~= 1)
	error('Usage: Signal__assert_mine(Signal)');
end

%TODO: implement the display of a bulk ?
if(length(Signal) == 1) %Avoid multiple bulk case for instance
    if(isfield(Signal, 'TEAPhysio'))
        if(Signal.TEAPhysio == 'S')
            return;
        end
    end
end

error('The signal given is not a TEAPhysio one')

%!error(Signal__assert_mine(42))
%!error(Signal__assert_mine())

