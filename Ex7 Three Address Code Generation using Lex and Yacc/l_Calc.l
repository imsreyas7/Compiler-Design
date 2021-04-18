%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include "y.tab.h"
%}

term    ([a-zA-Z\_][a-zA-Z\_0-9]*)
num     ([0-9]+)
real    {num}\.{num}    
relop   ("<"|"<="|">"|">="|"=="|"!=")
addop   ("+"|"-")
mulop   ("*"|"/"|"%")
spl     (";"|","|"{"|"}"|"("|")"|"="|"&"|"|"|"!"|":")

%%
"begin"     {return BGN;}
"end"       {return END;}
"if"        {return IF;}
"then"      {return THEN;}
"else"      {return ELSE;}
"integer"   {return INT;}
"char"      {return CHAR;}
"real"      {return REALVAR;}
['].[']     {yylval.ch = yytext[1]; return CHCONST;}
{term}      {yylval.str = strdup(yytext); return VAR;}
{real}      {yylval.floatval = atof(yytext); return REAL;}
{num}       {yylval.intval = atoi(yytext); return NUM;}
{relop}     {yylval.str = strdup(yytext); return RELOP;}
{mulop}     {yylval.str = strdup(yytext); return MULOP;}
{addop}     {yylval.str = strdup(yytext); return ADDOP;}
{spl}       {return *yytext;}
[ \t\n]+    {;}

.           {char errmsg[100];
            strcpy(errmsg, "Invalid Character: ");
            strcat(errmsg, yytext);
            strcat(errmsg, "\n");
            yyerror(errmsg);}

%%