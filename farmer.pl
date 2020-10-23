%%format  [wolf,goat,cabbage,farmer]
%%start = [l,l,l,l]
%%  end = [r,r,r,r]

%%no wolf and goat without farmer
notallowed(State):-
    State = [l,l,_,r].
notallowed(State):-
    State = [r,r,_,l].

%%no goat and cabbage without farmer
notallowed(State):-
    State = [_,l,l,r].
notallowed(State):-
    State = [_,r,r,l].

%%only 1 or 0 animals can move per state,
%%and this must be in the same direction as the farmer.
one_moves(State1,State2):-
    State1 = [l,B,C,l],
    State2 = [r,B,C,r].
one_moves(State1,State2):-
    State1 = [r,B,C,r],
    State2 = [l,B,C,l].
one_moves(State1,State2):-
    State1 = [A,B,l,l],
    State2 = [A,B,r,r].
one_moves(State1,State2):-
    State1 = [A,B,r,r],
    State2 = [A,B,l,l].
one_moves(State1,State2):-
    State1 = [A,l,C,l],
    State2 = [A,r,C,r].
one_moves(State1,State2):-
    State1 = [A,r,C,r],
    State2 = [A,l,C,l].
one_moves(State1,State2):-
    State1 = [A,B,C,_],
    State2 = [A,B,C,_].

%%recursively ensure every sequential 2 states are valid
valid([[_,_,_,_]]).
valid([X|Y]):-
    nth0(0, Y, Z),
    one_moves(X, Z),
    \+ notallowed(X),
    valid(Y).

solution(Beginning, End, Steps):-
    %%first step must be the beginning
    nth0(0, Steps, Beginning),

    %%last state must be the solution
    last(Steps, End),

    valid(Steps).