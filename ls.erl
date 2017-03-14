-module(ls).
-export([maxx/1, nub/1, nubx/1]).

maxx([X]) -> X;
maxx([X|XS]) -> 
	Y = maxx(XS),
	if X>Y  -> X; 
	true    -> Y
	end.

nub([]) -> [];
nub([X|XS]) -> [X|lists:filter(fun (Y)->Y/=X end, nub(XS))].

nubx(XS) -> nub2(XS, []).

nub2([], ACC) -> ACC;
nub2([X|XS],ACC) -> nub2(XS, [X|lists:filter(fun (Y)->Y/=X end,ACC)]).
