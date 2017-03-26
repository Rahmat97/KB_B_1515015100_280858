/*****************************************************************************

		Copyright (c) 1984 - 2000 Prolog Development Center A/S

 Project:  
 FileName: CH04E12.PRO
 Purpose: 
 Written by: PDC
 Modifyed by: Eugene Akimov
 Comments: 
******************************************************************************/

domains
  name,sex,occupation,object,vice,substance = symbol % menggunakan tipe data simbol
  age=integer 	% age(usia) menggunakan tipe data integer

predicates %untuk menggambarkan fakta-fakta yang ada di fungsi clauses
  person(name,age,sex,occupation) - nondeterm (o,o,o,o), nondeterm (i,o,o,i), nondeterm (i,o,i,o) %memberikan pernyataan dari person(orang) yang terdiri dari nama, usia, jenis kelamin, dan pekerjaan
  had_affair(name,name) - nondeterm (i,i), nondeterm (i,o) %memberikan pernyataan fakta dari selingkuh yaitu berupa nama dan nama
  killed_with(name,object) - determ (i,o)	%memberikan pernyataan fakta dari terbunuh dengan yaitu berupa nama dan benda yang digunakan
  killed(name) - procedure (o)		%memberikan pernyataan fakta dari terbunuh yaitu berupa nama
  killer(name) - nondeterm (o)		%memberikan pernyataan fakta dari pembunuh yaitu berupa nama
  motive(vice) - nondeterm (i)		%memberikan pernyataan fakta dari motif yaitu berupa vice(alasan)
  smeared_in(name,substance) - nondeterm (i,o), nondeterm (i,i)		%memberikan pernyataan fakta dari smeared(berlumur) yaitu berupa nama dan zat
  owns(name,object) - nondeterm (i,i)		%memberikan pernyataan fakta dari memiliki yaitu berupa nama dan benda
  operates_identically(object,object) - nondeterm (o,i)		%memberikan pernyataan fakta dari beroperasi_mirip yaitu berupa benda dan benda
  owns_probably(name,object) - nondeterm (i,i)		%memberikan pernyataan fakta dari kemungkinan_memiliki yaitu berupa nama dan benda
  suspect(name) - nondeterm (i)		%memberikan pernyataan fakta dari dicurigai yaitu berupa nama

/* * * Facts about the murder * * */
clauses		%memberikan fakta-fakta yang ada untuk diuji dan mencari solusinya
  person(bert,55,m,carpenter).		%fakta bahwa bert adalah seorang tukang kayu yang berusia 55 tahun
  person(allan,25,m,football_player).	%fakta bahwa allan adalah seorang pemain sepakbola yang berusia 25 tahun
  person(allan,25,m,butcher).		%fakta bahwa allan adalah seorang tukang daging juga
  person(john,25,m,pickpocket).		%fakta bahwa john adalah seorang pencopet yang berusia 25 tahun

  had_affair(barbara,john).		%barbara berselingkuh dengan john
  had_affair(barbara,bert).		%barbara berselingkuh dengan bert
  had_affair(susan,john).		%susan berselingkuh dengan john

  killed_with(susan,club).		%fakta susan terbunuh dengan alat pemukul		
  killed(susan).			%fakta bahwa susan terbunuh

  motive(money).		%motif/alasan pembunuhan yaitu uang 
  motive(jealousy).		%motif/alasan pembunuhan yaitu cemburu
  motive(righteousness).	%motif/alasan pembunuhan yaitu rasa dendam

  smeared_in(bert,blood).	%fakta bahwa bert berlumur darah
  smeared_in(susan,blood).	%fakta bahwa susan berlumur darah
  smeared_in(allan,mud).	%fakta bahwa allan berlumur lumpur
  smeared_in(john,chocolate).	%fakta bahwa john berlumur coklat
  smeared_in(barbara,chocolate).%fakta bahwa barbara berlumur coklat

  owns(bert,wooden_leg).	%fakta bert memiliki kaki kayu
  owns(john,pistol).		%fakta john memiliki pistol

/* * * Background knowledge * * */

  operates_identically(wooden_leg, club).		%kaki kayu beroperasi_mirip dengan alat pemukul
  operates_identically(bar, club).			%balok beroperasi_mirip dengan alat pemukul
  operates_identically(pair_of_scissors, knife).	%sepasang gunting beroperasi_mirip dengan pisau
  operates_identically(football_boot, club).		%sepatu sepakbola beroperasi_mirip dengan alat pemukul

  owns_probably(X,football_boot):-	% X kemungkinan_memiliki sepatu sepakbola jika
	person(X,_,_,football_player).	% X dan orang yang lain adalah pemain sepakbola
  owns_probably(X,pair_of_scissors):-	% X kemungkinan_memiliki sepasang gunting jika
	person(X,_,_,hairdresser).	% X dan orang yang lain adalah penata rambut
  owns_probably(X,Object):-		% X kemungkinan_memiliki benda jika
	owns(X,Object).			% X memiliki benda

/* * * * * * * * * * * * * * * * * * * * * * *
 * Suspect all those who own a weapon with   *
 * which Susan could have been killed.       *
 * * * * * * * * * * * * * * * * * * * * * * */

  suspect(X):-		% X dicurigai jika
	killed_with(susan,Weapon) , 		% susan terbunuh_dengan senjata dan
	operates_identically(Object,Weapon) ,	% benda tersebut beroperasi_mirip senjata dan
	owns_probably(X,Object).		% X kemungkinan_memiliki benda tersebut

/* * * * * * * * * * * * * * * * * * * * * * * * * *
 * Suspect men who have had an affair with Susan.  *
 * * * * * * * * * * * * * * * * * * * * * * * * * */

  suspect(X):-		% X dicurigai jika
	motive(jealousy),	% motif dari pembunuhan tersebut adalah cemburu dan
	person(X,_,m,_),	% X adalah orang tersebut yang berjenis kelamin m dan
	had_affair(susan,X).	% susan berselingkuh dengan X

/* * * * * * * * * * * * * * * * * * * * *
 * Suspect females who have had an       *
 * affair with someone that Susan knew.  *
 * * * * * * * * * * * * * * * * * * * * */

  suspect(X):-		% X dicurigai jika
	motive(jealousy),	% motif dari pembunuhan tersebut adalah cemburu dan
	person(X,_,f,_),	% X adalah orang tersebut yang berjenis kelamin f dan
	had_affair(X,Man),	% X berselingkuh dengan pria tersebut dan
	had_affair(susan,Man).	% susan berselingkuh dengan pria tersebut

/* * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Suspect pickpockets whose motive could be money.  *
 * * * * * * * * * * * * * * * * * * * * * * * * * * */

  suspect(X):-		% X dicurigai jika
	motive(money),			% motif dari pembunuhan tersebut adalah uang dan
	person(X,_,_,pickpocket).	% X dan yang lainnya adalah seorang pencopet

  killer(Killer):-		% pembunuh tersebut dikatakan pembunuh jika
	person(Killer,_,_,_),	% orang tersebut dan yang lainnya adalah pembunuh dan
	killed(Killed),		% orang tersebut terbunuh dan
	Killed <> Killer, /* It is not a suicide */	% yang terbunuh adalah pembunuh dan
	suspect(Killer),	% pembunuh tersebut dicurigai dan
	smeared_in(Killer,Goo),	% pembunuh berlumur zat dan
	smeared_in(Killed,Goo). % yang terbunuh berlumur zat

goal		% untuk menampilkan hasil eksekusi dari program yang telah dibuat
  killer(X).	% X adalah pembunuhnya
  		% bert adalah pelaku dari pembunuhan tersebut
  		% susan adalah orang yang terbunuh karena bert dan susan berlumur zat yang sama yaitu darah
