domains
  bagi,kurang = integer

predicates
  pengurangan(kurang,kurang,kurang) - procedure (i,i,o)
  pembagian(bagi,bagi,bagi) - procedure (i,i,o)

clauses
  pengurangan(X,Y,Kurang):-
	Kurang=X-Y.
  pembagian(X,Y,Bagi):-
	Bagi=X/Y.

goal
  pengurangan(54,9,Kurang),
  pembagian(6,3,Bagi).