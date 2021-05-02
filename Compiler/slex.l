%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

#include "y.tab.h"

%}

term    ([a-zA-Z\_][a-zA-Z0-9]*)
digit   ([0-9]+)
%%

{term}      {yylval.str = strdup(yytext); return TERM;}
{digit}     {yylval.ival = atoi(yytext); return INT;}
[\n]         {return *yytext;}
[ \t]     {}
.           {return *yytext;}

%%
