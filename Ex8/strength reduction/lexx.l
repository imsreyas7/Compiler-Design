%{
#include<stdio.h>
#include<string.h>
#include "y.tab.h"
%}

term ([a-zA-Z\_][a-zA-Z\_0-9]*|[0-9]+)
relop ("<"|"<="|">"|">="|"=="|"!=")
op ("%")

%%
("0"|"1") {return *yytext;}
"** 2" {yylval.str = strdup(yytext); return POW2; }
"**" {yylval.str = strdup(yytext); return POW; }
{term} { yylval.str = strdup(yytext); return TERM; }
{relop} { yylval.str = strdup(yytext); return RELOP; }
{op} { yylval.str = strdup(yytext); return OP; }
[ \t\n]+ { }
("-"|"+") {yylval.str = strdup(yytext); return ADD;}
("="|";"|"*"|"/") {return *yytext;}
. { printf("unknown token %c.",*yytext);}
%%