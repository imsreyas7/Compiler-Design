%{
#include<stdio.h>
#include<stdlib.h>
int count  = 0;
%}

keyword     "auto"|"break"|"case"|"char"|"const"|"continue"|"default"|"do"|"double"|"else"|"enum"|"extern"|"float"|"for"|"goto"|"if"|"int"|"long"|"register"|"return"|"short"|"signed"|"sizeof"|"static"|"struct"|"switch"|"typedef"|"union"|"unsigned"|"void"|"volatile"|"while"
numconst    [-+]?[0-9]+(\.[0-9]+)?
charconst   '.'
stringconst ".*"
function    [a-zA-Z_][a-zA-Z0-9_]*[(].*[)]
iden        [a-zA-Z_][a-zA-Z0-9_]*
preprcssdir #.+
relop       ">="|"<="|"=="|"!="|">"|"<"
arthop      "+"|"-"|"*"|"%"|"/"
arthasn     "+="|"-="|"*="|"%="|"/="
assign      "="
scmt        [/][/].*
mcmt        [/][*](.|[\n\r])*[*][/]


%%

{preprcssdir} {printf("PD ");}
{keyword}   {printf("KW ");}
{function}  {printf("FN ");}
{numconst}  {printf("NUMCONST ");}
{charconst}  {printf("CHARCONST ");}
{stringconst}  {printf("STRCONST ");}
{relop} {printf("RELOP ");}
{arthasn} {printf("ARITHASSIGNOP ");}
{arthop} {printf("ARTHOP ");}
{assign} {printf("ASSIGN ");}
[,{}();] {printf("SP ");}
{iden}  {printf("ID ");}
{scmt}  {printf("SCMT");}
{mcmt}  {printf("MCMT");}
\n  {printf("\n");}
. {}

%%
int yywrap() {
    return 1;
}

int main() {
    char filename[100];

    printf("\n\t\tSimple Lexical Analyzer\n");
    printf("\nEnter filename containing code : ");
    scanf(" %[^\n]", filename);

    yyin = fopen(filename, "r+");
    yylex();
    return 0;
}