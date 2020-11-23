#include "../input.lp".

% Determine left/right x-coordinates
side(X, left) :- SX = #max{ X' : position((X',_)) },  X<=(SX+1)/2, position((X,_)).
side(X, right) :- SX = #max{ X' : position((X',_)) }, X> (SX+1)/2, position((X,_)).

% Group robots into left/right side wrt their initial position
leftRobot :- position(R,(X,_),0), side(X, left), isRobot(R).
rightRobot :- position(R,(X,_),0), side(X, right), isRobot(R).

% Forbid robots to occupy a position on the other side
leftRobot :- position(R,(X,_),_), not side(X, right), isRobot(R).
rightRobot :- position(R,(X,_),_), not side(X, left), isRobot(R).


