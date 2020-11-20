#include "../input.lp".

% Aux predicates to represent products that are ordered and shelved, resp.
ordered(order(O),product(A),N) :- init(object(order,O),   value(line,(A,N))).
shelved(shelf(S),product(A),N) :- init(object(product,A), value(on,  (S,N))).

% Guess assignments
{ assign(R,S,P) } :- isRobot(R), isShelf(S), isStation(P).

% For each station and product, the assignment must allow for the fulfillment of the sum of
% requested quantities by all orders
orderedAtStation(A, M, P) :- isProduct(A), isStation(P),
                             M = #sum{ N, O : ordered(O,A,N), target(O,P) }.
:- orderedAtStation(A, M, P), #sum{ N,S : assign(_,S,P), shelved(S,A,N) } < M.

% Do not assign more than one robot per shelf
:- isShelf(S), #count{ R : assign(R,S,_) } > 1.

% Determine left/right x-coordinates
sideLeft :- SX = #max{ X' : position((X',_)) },  X<=(SX+1)/2, position((X,_)).
sideRight :- SX = #max{ X' : position((X',_)) }, X> (SX+1)/2, position((X,_)).

% Group robots, shelve and picking stations into left & right wrt their initial x-coordinates
leftItem :- position(_,C,T), sideLeft.
rightItem :- position(_,C,T), sideRight.

% Restrict movement of left/rigth robots to the respective half of the grid
leftItem :- position(_,C,T), not sideRight.
rightItem :- position(_,C,T), not sideLeft.

% Use all robots
:- isRobot(R), not assign(R,_,_).

% Output
#show assign/3.
#show init/2.


