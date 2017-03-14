-module(listfuncs).

-export([double/1,double2/1,double2x/2, evens/1, evens_/1, evens_acc/2, taken/3, 
		group_by/3, take/2, group/2, median/1]).

double([]) -> [];
double([X|Xs]) -> [2 * X | double(Xs)].

double2([]) -> [];
double2(Xs) -> double2x(Xs, []).

double2x([], Acc) -> lists:reverse(Acc);
double2x([X|Xs], Acc) -> double2x(Xs, [2*X|Acc]).

evens([]) -> [];
evens([X|Xs]) when X rem 2 == 0 -> [X|evens(Xs)];
evens([_|Xs])              -> evens(Xs).

evens_acc([], Acc) -> lists:reverse(Acc);
evens_acc([X|Xs], Acc) when X rem 2 == 0 -> evens_acc(Xs, [X|Acc]);
evens_acc([_|Xs], Acc)                   -> evens_acc(Xs, Acc).

evens_(Xs) -> evens_acc(Xs,[]).

take(N, Xs) -> 
	{T, _ } = taken(N, Xs, []),
	T.

taken(0, Xs, Acc) -> {lists:reverse(Acc), Xs};
taken(_, [], Acc) -> {lists:reverse(Acc), []};
taken(N, [X|Xs], Acc) -> taken(N-1, Xs, [X|Acc]).
	
group(N, XS) -> group_by(N, XS, []).
group_by(0, _, _) -> [];
group_by(_, [], Acc) -> lists:reverse(Acc);
group_by(N, Xs, Acc) -> 
	{Taken, Left} = taken(N, Xs, []),
	group_by(N, Left, [Taken|Acc]).

median(XS) -> 
	Sorted = lists:sort(XS),
	Length = length(XS),
	Mid = Length div 2,
	if 
		Length rem 2 == 0 -> (lists:nth(Mid - 1, Sorted) + lists:nth(Mid, Sorted))/ 2.0;		
		true              -> lists:nth(Mid - 1, Sorted)
	end. 

