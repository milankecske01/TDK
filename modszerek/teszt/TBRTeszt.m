B=[1 2;7 3;8 4;5 6;9 10];
fa=phytree(B);
szuloIdk=szulok(fa);
szuloIdk(11)=0;
[uj_pointerek_uj_gyok] = TBRPointerCsere(B,szuloIdk,9,5,7,6);