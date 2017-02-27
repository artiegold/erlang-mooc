%%%%%%%%%%%%%%
%% shapes.erl
%%%%%%%%%%%%%%
-module(shapes).

-export([area/1, perimeter/1, make_circle/2, make_triangle/3, make_rectangle/2,
	enclose/1]).

% convenience constructors

% defined by center and radius
make_circle({X, Y}, Radius) -> {circle, {X, Y}, Radius}.

% defined by three points
make_triangle({X1, Y1}, {X2, Y2}, {X3, Y3}) -> {triangle, {{X1, Y1}, {X2, Y2}, {X3, Y3}}}.

% defined by a center point and a height and width
make_rectangle({X, Y}, {H, W}) -> {rectangle, {X, Y}, {H, W}}.

% distance between two points
dist({X1, Y1}, {X2, Y2}) -> 
	D1 = X1 - X2,
	D2 = Y1 - Y2,
	math:sqrt(D1 * D1 + D2 * D2).

% area
area({circle, _, Radius}) -> math:pi() * Radius * Radius;
area({rectangle, _, {H, W}}) -> H * W;
area({triangle, {P1, P2, P3}}) ->
	A = dist(P1, P2),
	B = dist(P2, P3),
	C = dist(P3, P1),
	S = (A+B+C)/2,
	math:sqrt(S*(S-A)*(S-B)*(S-C)).

%perimeter
perimeter({circle, _, Radius}) -> 2 * math:pi() * Radius;
perimeter({rectangle, _, {H, W}}) -> H + H + W + W;
perimeter({triangle, {P1, P2, P3}}) -> dist(P1,P2) + dist(P2, P3) + dist(P3, P1).

% enclosing rectangle (defined as a rectangle, as above)
enclose({circle, Center, Radius}) ->
	Size = Radius + Radius,
	make_rectangle(Center, {Size, Size});
enclose({rectangle, Center, Size}) -> {rectangle, Center, Size};
enclose({triangle, {X1, Y1}, {X2, Y2}, {X3, Y3}}) ->
	MinX = min(X1, min(X2, X3)),
	MaxX = max(X1, max(X2, X3)),
	MinY = min(Y1, min(Y2, Y3)),
	MaxY = max(Y1, max(Y2, Y3)),
	make_rectangle({(MinX + MaxX)/2, (MinY + MaxY)/2}, {MaxX - MinX, MaxY - MinY}).
