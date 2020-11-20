#include "../input.lp".

% Determine left/right x-coordinates
side(X, left) :- SX = #max{ X' : position((X',_)) },  X<=(SX+1)/2, position((X,_)).
side(X, right) :- SX = #max{ X' : position((X',_)) }, X> (SX+1)/2, position((X,_)).

% Group robots into left/right side wrt their initial position
leftRobot :- position((X,_)), side(X, left).
rightRobot :- position((X,_)), side(X, right).

% Forbid robots to occupy a position on the other side
leftRobot :- position((X,_)), not side(X, right).
rightRobot :- position((X,_)), not side(X, left).
