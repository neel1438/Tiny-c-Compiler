%{
	#include <string.h>
	#include<stdlib.h>
	#include<stdio.h>
	#include "bison.tab.h"
	int linenumb=1;
	char flag='b';
%}

INT_LIT    [0-9]+
ID ([a-zA-Z_][a-zA-Z0-9_]*)
ws [ \t]

%%

"class" 	{ return CLASS;}
"main"		{ return MAIN; }
{ws}+  		{ 				     }

"(" |
")" |
"[" |
"=" |
"+" |
"-" |
"*" |
"/" |
">" |
"<" |
"]" |
"{" |
"}" |
"!" |
"," |
";"		{ return yytext[0]; } 


">="		{ return GR; }
"<="		{ return LS; }
"=="		{ return EQ; }
"!="		{ return NEQ; }
"&&"		{ return AND;}
"||"		{ return OR; }

"char"		{ return CHAR;	 }
\"(.)*\"	{ yylval.s=strtok(yytext,"\"");
		  return STR_LIT; 		     }
"goto"		{ flag='a'; return GOTO; }

"boolean" 	{ return BOOLEAN;}
	
"true"		{ yylval.s= yytext; return BOOL_LIT; }
"false"		{ yylval.s= yytext; return BOOL_LIT; }

"int"		{ return INT; 	 }

"if"		{ return IF;   }
"read"		{ return READ; }
"then"		{ return THEN; }
"print"		{ return PRINT;}
\'(.)\'		{ yylval.c=yytext[1];
		  return CHAR_LIT; 		     }

{ID}:		{ yylval.s = strtok(yytext,":");
		  return LABEL; 		     }
{INT_LIT} 	{ yylval.d = atoi(yytext);
		  return INT_LIT; 		     }
{ID}		{ yylval.s = yytext;
		  if(flag=='a'){
			  flag='b';
			  return LABEL;
		  }
		  else{
			  return ID;
		  } 				     }
\n		{ linenumb++;			     }

.		{ printf(" Error at character %c in line %d\n ", *yytext,linenumb); exit(1);}
%%
