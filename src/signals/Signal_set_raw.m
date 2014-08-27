function Signal = Signal_set_raw(Signal, raw)
%Sets the raw data of the signal S

if(nargin ~= 2)
	error('Usage: Signal = Signal_set_raw(Signal, raw)');
end

if(nargout ~= 1)
	error('You need to retrieve the function''s result. Else, it''s useless !');
end

Signal_assert_mine(Signal);

Signal.raw = double(raw);

%!error(Signal_set_raw())
%!error(Signal_set_raw(42))
%!error(Signal_set_raw(42, [1 2 3 4]))
%!error(Signal_set_raw(Signal_new_empty(), [1 2 3 4])) %No result retreived
%!assert(Signal_set_raw(Signal_new_empty(), [1 2 3 4]).raw, [1 2 3 4])

