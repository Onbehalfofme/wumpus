start:-
    gold(1,1,[], Minimal_Length, 0, 1),
    (Minimal_Length \= 27 ->
    print('Minimal length is '),
    writeln(Minimal_Length)).



pit(2,1).
pit(2,2).
%pit(2,3).
pit(2,4).
%pit(2.5).


wumpus(1,4).



stench(X, Y):-
    X1 is X - 1, 
    wumpus(X1, Y);
    X2 is X + 1, 
    wumpus(X2, Y);
    Y1 is Y - 1, 
    wumpus(X, Y1);
    Y2 is Y + 1, 
    wumpus(X, Y2).




gold(1, 5, L, 0, _, _):-
    
    append(L, [[1,5]], Result),
    writeln(Result), 
    !.




gold(_, 6, _, N, _, _):- N is 26,!.
gold(_, 0, _, N, _, _):- N is 26,!.
gold(6, _, _, N, _, _):- N is 26,!.
gold(0, _, _, N, _, _):- N is 26,!.





gold(X, Y, _, N, _, _):-
    pit(X, Y),
    N is 26, !.

gold(X, Y, _, N, Killed, _):-
    wumpus(X, Y),
    Killed == 0,
    N is 26, !.





gold(X, Y, Visited, N, _, HasArrow):-  
    (member([X,Y],Visited) ->  
    N is 26,
    !;  
    Y1 is Y + 1,
    stench(X, Y),
    HasArrow == 1,      
    wumpus(X, Y1),
    append(Visited, [[X, Y]], Visited2),
    append(Visited2, ["Wumpus dies"], Visited1),
    gold(X, Y1, Visited1, N1, 1, 0),
    N is N1 + 1).

gold(X, Y, Visited, N, _, HasArrow):-   
    (member([X,Y],Visited) ->  
    N is 26,
    !; 
    Y1 is Y - 1,
    stench(X, Y),
    HasArrow == 1,      
    wumpus(X, Y1),
    append(Visited, [[X, Y]], Visited2),
    append(Visited2, ["Wumpus dies"], Visited1),
    gold(X, Y1, Visited1, N1, 1, 0),
    N is N1 + 1).

gold(X, Y, Visited, N, _, HasArrow):-  
    (member([X,Y],Visited) ->  
    N is 26,
    !;  
    X1 is X + 1,
    stench(X, Y),
    HasArrow == 1,      
    wumpus(X1, Y),
    append(Visited, [[X, Y]], Visited2),
    append(Visited2, ["Wumpus dies"], Visited1),
    gold(X1, Y, Visited1, N1, 1, 0),
    N is N1 + 1).

gold(X, Y, Visited, N, _, HasArrow):-   
    (member([X,Y],Visited) ->  
    N is 26,
    !; 
    X1 is X - 1,
    stench(X, Y),
    HasArrow == 1,      
    wumpus(X1, Y),
    append(Visited, [[X, Y]], Visited2),
    append(Visited2, ["Wumpus dies"], Visited1),
    gold(X1, Y, Visited1, N1, 1, 0),
    N is N1 + 1).


gold(X, Y, Visited, N, _, HasArrow):-  
    (member([X,Y],Visited) ->  
    N is 26,
    !;  
    X1 is X + 1,
    stench(X, Y),
    HasArrow == 1,      
    \+wumpus(X1, Y),
    append(Visited, [[X, Y]], Visited2),
    append(Visited2, ["You missed"], Visited1),
    gold(X1, Y, Visited1, N1, 0, 0),
    N is N1 + 1).

gold(X, Y, Visited, N, _, HasArrow):-  
    (member([X,Y],Visited) ->  
    N is 26,
    !;  
    X1 is X - 1,
    stench(X, Y),
    HasArrow == 1,      
    \+wumpus(X1, Y),
    append(Visited, [[X, Y]], Visited2),
    append(Visited2, ["You missed"], Visited1),
    gold(X1, Y, Visited1, N1, 0, 0),
    N is N1 + 1).

gold(X, Y, Visited, N, _, HasArrow):-  
    (member([X,Y],Visited) ->  
    N is 26,
    !;  
    Y1 is Y + 1,
    stench(X, Y),
    HasArrow == 1,      
    \+wumpus(X, Y1),
    append(Visited, [[X, Y]], Visited2),
    append(Visited2, ["You missed"], Visited1),
    gold(X, Y1, Visited1, N1, 0, 0),
    N is N1 + 1).

gold(X, Y, Visited, N, _, HasArrow):-  
    (member([X,Y],Visited) ->  
    N is 26,
    !;  
    Y1 is Y - 1,
    stench(X, Y),
    HasArrow == 1,      
    \+wumpus(X, Y1),
    append(Visited, [[X, Y]], Visited2),
    append(Visited2, ["You missed"], Visited1),
    gold(X, Y1, Visited1, N1, 0, 0),
    N is N1 + 1).




gold(X, Y, Visited, N, Killed, HasArrow):-   
    append(Visited, [[X, Y]], Visited1),
    (member([X,Y],Visited) ->  
    N is 26,
    !; 
    X1 is X + 1,
    Y1 is Y + 1,
    X2 is X - 1,
    Y2 is Y - 1,
    gold(X1, Y, Visited1, N1, Killed, HasArrow),
    gold(X, Y1, Visited1, N2, Killed, HasArrow),
    gold(X2, Y, Visited1, N3, Killed, HasArrow),
    gold(X, Y2, Visited1, N4, Killed, HasArrow),
    N is min(min(N1, N2), min(N3, N4)) + 1).