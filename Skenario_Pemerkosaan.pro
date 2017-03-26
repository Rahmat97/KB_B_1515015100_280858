domains
nama,jenis_kelamin,pekerjaan,benda,penyebab,zat=symbol
umur = integer

predicates
nondeterm 
diperkosa(symbol,symbol)
nondeterm 
orang(symbol,integer,symbol,symbol)
nondeterm
memiliki_noda(symbol,symbol)
nondeterm
tewas(symbol)
nondeterm 
pemerkosa(symbol)
nondeterm
alasan(symbol)
nondeterm
tewas_dengan(symbol,symbol)
nondeterm
memiliki(symbol,symbol)
nondeterm 
atau(symbol,symbol)
nondeterm 
kemungkinan_memiliki(symbol,symbol)
nondeterm 
disangka(symbol)

clauses
orang(iqbal,20,m,mahasiswa).
orang(reza,25,m,pegawai).
orang(rizky,27,m,business).
orang(roland,50,m,buruh).

diperkosa(mariana,iqbal).
diperkosa(ezra,roland).
diperkosa(rhea,reza).

tewas_dengan(ezra,pisau).
tewas(ezra).

alasan(sakit_hati).
alasan(nafsu).
alasan(cemburu).


memiliki_noda(reza,lumpur).
memiliki_noda(ezra,darah).
memiliki_noda(roland,darah).
memiliki_noda(rizky,es_krim).
memiliki_noda(mariana,kotoran_hewan).

memiliki(reza,kayu).
memiliki(iqbal,kayu).
memiliki(roland,pisau).

atau(pisau,kapak).
atau(kayu,balok).
atau(garpu_rumput,tombak).


kemungkinan_memiliki(X,pisau) :-orang(X,_,_,penjual_buah).
kemungkinan_memiliki(X,kayu) :-orang(X,_,_,kuli_bangunan).
kemungkinan_memiliki(X,Benda) :-memiliki(X,Benda).


disangka(X):-tewas_dengan(ezra,Senjata) ,atau(Benda,Senjata) ,kemungkinan_memiliki(X,Benda).
disangka(X) :-alasan(cemburu),orang(X,_,m,_),diperkosa(lisa,X).
disangka(X) :-alasan(sakit_hati),orang(X,_,f,_),diperkosa(X,Lakilaki),diperkosa(ezra,Lakilaki).
disangka(X) :-alasan(nafsu),orang(X,_,_,buruh).
pemerkosa(X) :-orang(X,_,_,_),tewas(Terbunuh),
Terbunuh <> X,disangka(X),
memiliki_noda(X,Zat),memiliki_noda(Terbunuh,Zat).

Goal
pemerkosa(X). 

