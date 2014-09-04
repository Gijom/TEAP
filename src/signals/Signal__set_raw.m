function Signal = Signal__set_raw(Signal, raw)
%Sets the raw data of the signal S

if(nargin ~= 2)
	error('Usage: Signal = Signal__set_raw(Signal, raw)');
end

if(nargout ~= 1)
	error('You need to retrieve the function''s result. Else, it''s useless !');
end

Signal__assert_mine(Signal);

Signal.raw = double(raw);

%!error(Signal__set_raw())
%!error(Signal__set_raw(42))
%!error(Signal__set_raw(42, [1 2 3 4]))
%!error(Signal__set_raw(Signal__new_empty(), [1 2 3 4])) %No result retreived
%!assert(Signal__set_raw(Signal__new_empty(), [1 2 3 4]).raw, [1 2 3 4])

