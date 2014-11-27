/* Hongzi Mao 2002 5238 */

append([], X, X). 
append([X|Y], Z, [X|W]) :- append(Y,Z,W).

aRev([H|T],A,R) :- aRev(T,[H|A],R). 
aRev([],A,A).
rev(L,R) :- aRev(L,[],R).

listmirrorlr([X|Y], R, [X|Z]) :- listmirrorlr(Y, [X|R], Z), !.
listmirrorlr([],Y,Y).
listmirror(X,Y) :- listmirrorlr(X, [], Y).

listdiff([],_,[]).
listdiff([X|Y],Z,[X|W]) :- not(member(X,Z)), listdiff(Y,Z,W), !.
listdiff([X|Y],Z,W) :- member(X,Z), listdiff(Y,Z,W), !.

insert(X, [], [X]) :- !.
insert(X, [Y|Z], [Y|L]) :- X>Y, insert(X, Z, L), !.
insert(X, [Y|Z], [X|L]) :- X=<Y, L=[Y|Z], !.

bitsgen(0,[]).
bitsgen(M,[0|L]) :- M>0, N is M-1, bitsgen(N, L). 
bitsgen(M,[1|L]) :- M>0, N is M-1, bitsgen(N, L).

preorder(nil, []).
preorder(t(N,R,L), [N|Y]) :- preorder(R, LR), preorder(L, LL), append(LR, LL, Y).
 
