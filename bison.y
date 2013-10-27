%{
	#include <stdio.h>
	#include<stdlib.h>
	FILE* yyin;
	extern int linenumb;
%}

%union {
	char c;
	char *s;
	int d;
}

%token CLASS MAIN INT CHAR BOOLEAN
%token GR LS EQ NEQ OR AND
%token IF THEN GOTO PRINT READ
%token <d> INT_LIT 
%token <s> ID LABEL BOOL_LIT STR_LIT
%token <c> CHAR_LIT

%left '+' '-' '*' '/'
%left '>' '<' GR LS
%left OR AND EQ NEQ
%right '=' '!'

%%

program: CLASS MAIN '{' list list1 '}' { printf("File has no syntax errors\n"); exit(1);}
       ;

list:
     | field_decl list
     ;



field_decl: type decl
	  ;

type: INT
    | BOOLEAN
    | CHAR
    ;

decl: ID ';'
    | ID '[' INT_LIT ']' ';'
    | ID ','decl
    | ID '[' INT_LIT ']' ',' decl
    ;

list1:
     | statement list1
     ;

statement: labelled_statement
	 | location '=' expr ';'
	 | IF expr THEN GOTO LABEL ';'
	 | GOTO LABEL ';'
	 | method_call ';'
	 ;

labelled_statement: LABEL statement

location: ID
	| ID '[' expr ']'
	;
		  ;

literal: INT_LIT
       | BOOL_LIT
       | CHAR_LIT
       | STR_LIT
       ;


expr: literal
    | location
    | '-' expr
    | '!' expr
    | '(' expr ')'
    | expr '+' expr
    | expr '-' expr
    | expr '*' expr
    | expr '/' expr
    | expr '<' expr
    | expr '>' expr
    | expr LS expr
    | expr GR expr
    | expr EQ expr
    | expr NEQ expr
    | expr AND expr
    | expr OR expr
    ;

lol: expr ',' lol
   | expr
   ;

method_call: PRINT '(' lol ')'
	   | READ '(' location ')'
	   ;


%%

int main(int argc, char **argv){
	yyin=fopen(argv[1],"r");
	yyparse();
	fclose(yyin);
	return 0;
}

yyerror(char *s){
	fprintf(stderr, "ERROR in line %d\n", linenumb);
}
