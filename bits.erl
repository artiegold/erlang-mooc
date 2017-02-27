-module(bits).
-export([bits/2,bits/1, bitss/1]).

bits(N) -> bits(N,0).
bits(0,M) -> M;
bits(N,M) -> bits(N div 2, M+(N rem 2)).

bitss(0) -> 0;
bitss(1) -> 1;
bitss(N) -> bitss(N rem 2) + bitss(N div 2).
