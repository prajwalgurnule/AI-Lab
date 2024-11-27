/* 
Waterjug problem solved in Prolog (SWI-Prolog). 
Usage: test_dfs(jugs, Moves). 
*/ 

% Solve the Water Jug problem using Depth-First Search

solve_dfs(State, History, []) :- final_state(State). 
solve_dfs(State, History, [Move|Moves]) :- 
 move(State, Move), 
 update(State, Move, State1), 
 legal(State1), 
 not(member(State1, History)), 
 solve_dfs(State1, [State1|History], Moves). 
test_dfs(Problem, Moves) :- 
 initial_state(Problem, State), solve_dfs(State, [State], Moves). 
capacity(1, 10). 
capacity(2, 7). 
initial_state(jugs, jugs(0, 0)). 
final_state(jugs(0, 6)). 
%final_state(jugs(4, 0)). 
legal(jugs(V1, V2)). 
move(jugs(V1, V2), fill(1)) :- capacity(1, C1), V1 < C1, capacity(2, C2), 
V2 < C2. 
move(jugs(V1, V2), fill(2)) :- capacity(2, C2), V2 < C2, capacity(1, C1), 
V1 < C1. 
move(jugs(V1, V2), empty(1)) :- V1 > 0. 
move(jugs(V1, V2), empty(2)) :- V2 > 0. 
move(jugs(V1, V2), transfer(1, 2)). 
move(jugs(V1, V2), transfer(2, 1)). 
adjust(Liquid, Excess, Liquid, 0) :- Excess =< 0. 
adjust(Liquid, Excess, V, Excess) :- Excess > 0, V is Liquid - Excess. 
update(jugs(V1, V2), fill(1), jugs(C1, V2)) :- capacity(1, C1). 
update(jugs(V1, V2), fill(2), jugs(V1, C2)) :- capacity(2, C2). 
update(jugs(V1, V2), empty(1), jugs(0, V2)). 
update(jugs(V1, V2), empty(2), jugs(V1, 0)). 
update(jugs(V1, V2), transfer(1, 2),jugs(NewV1, NewV2)) :- 
 capacity(2, C2), 
 Liquid is V1 + V2, 
 Excess is Liquid - C2, 
 adjust(Liquid, Excess, NewV2, NewV1). 
update(jugs(V1, V2), transfer(2, 1),jugs(NewV1, NewV2)) :- 
 capacity(1, C1), 
 Liquid is V1 + V2, 
 Excess is Liquid - C1, 
 adjust(Liquid, Excess, NewV1, NewV2). 
