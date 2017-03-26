domains
  nama_peserta,desain,nama_panitia= symbol
  skor = unsigned 
  
predicates
  nondeterm nama(nama_peserta)
  nondeterm panitia(nama_panitia)
  nondeterm lomba(desain,nama_peserta)
  nondeterm semi_final(nama_peserta,skor)
  nondeterm pemenang(desain,nama_peserta)
  nondeterm babak_final(nama_peserta,skor)
  nondeterm bukan_pemenang(desain,nama_peserta)
  nondeterm calon_pemenang(desain,nama_peserta)

clauses
  panitia("Reza").
  
  nama("Adam").
  nama("Nando").
  nama("Iqbal").
  nama("Budi").
  nama("Vandi").
  
  lomba(poster,"Adam").
  lomba(baliho,"Nando").
  lomba(logo,"Iqbal").
  lomba(logo,"Budi").
  lomba(logo,"Vandi").
  
  semi_final("Adam",3570).
  semi_final("Nando",3280).
  semi_final("Iqbal",3630).
  semi_final("Budi",3440).
  semi_final("Vandi",3557).
  
  babak_final("Adam",4890).
  babak_final("Nando",4890).
  babak_final("Iqbal",5230).
  babak_final("Budi",4898).
  babak_final("Vandi",4890).
  
  calon_pemenang(iqbal,Nama_peserta):-
  	nama(Nama_peserta),
  	babak_final(Nama_peserta,5230).

  pemenang(Desain,Nama_peserta):-
        write("*****************PEMENANG****************"),nl,
	lomba(Desain,Nama_peserta),
	babak_final(Nama_peserta,Skor),
	Skor > 5000.
  
  bukan_pemenang(Desain,Nama_peserta):-
  	write("*****************FINALIS****************"),nl,
	lomba(Desain,Nama_peserta),
	semi_final(Nama_peserta,Skor),
	Skor < 5000.

  
	

goal
  panitia(Panitia);nl,  
  bukan_pemenang(Desain,Nama_pesertaa);nl,
  pemenang(Desain,Nama_peserta);nl.