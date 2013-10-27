project: lex.l bison.y
	bison -d bison.y
	flex lex.l
	gcc -o 201101143 bison.tab.c lex.yy.c -lfl
clean:
	rm bison.tab.c lex.yy.c bison.tab.h 201101143
