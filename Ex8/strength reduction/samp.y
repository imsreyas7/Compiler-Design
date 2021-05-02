%{
#include<stdio.h>
#include<stdlib.h>
#include<math.h>
#include<string.h>
int yylex(void);
int yyerror(char *);
#include "y.tab.h"
int cc = 1, tc = 1, nc = 1, sc = 0;
%}
%token TERM RELOP OP ADD POW POW2
%union
{
    int intval;
    float floatval;
    char *str;
}
%type<str> TERM RELOP OP ADD POW POW2
%%
line: TERM '=' TERM ADD '0'';' {if(strcmp($1, $3)!=0)
                                  printf("%s = %s\n",$1, $3);} line
    | TERM '=' '0' ADD TERM';' {if(strcmp($1, $5)!=0)
                                  printf("%s = %s\n",$1, $5);} line
    | TERM '=' TERM ADD TERM';'   {printf("%s = %s %s %s\n", $1,$3,$4,$5);} line
    | TERM '=' TERM '*' '1'';' {if(strcmp($1, $3)!=0)
                                  printf("%s = %s\n",$1, $3);} line
    | TERM '=' '1' '*' TERM';' {if(strcmp($1, $5)!=0)
                                  printf("%s = %s\n",$1, $5);} line
    | TERM '=' TERM '*' '0'';' {printf("%s = 0\n",$1);} line
    | TERM '=' '0' '*' TERM';' {printf("%s = 0\n",$1);} line
    | TERM '=' TERM '/' '1'';' {if(strcmp($1, $3)!=0)
                                  printf("%s = %s\n",$1, $3);} line
    | TERM '=' TERM '*' TERM';'   {printf("%s = %s * %s\n", $1,$3,$5);} line
    | TERM '=' TERM '/' TERM';'   {printf("%s = %s / %s\n", $1,$3,$5);} line
    | TERM '=' TERM POW '1'';'   { if(strcmp($1, $3)!=0)
                                      printf("%s = %s\n", $1,$3);} line
    | TERM '=' TERM POW '0'';'   { printf("%s = 1\n", $1);} line
    | TERM '=' '1' POW TERM';'   { printf("%s = 1\n", $1);} line
    | TERM '=' '0' POW TERM';'   { printf("%s = 0\n", $1);} line
    | TERM '=' TERM POW2';'   { printf("%s = %s * %s\n", $1,$3,$3);} line
    | /* empty */

%%
int yyerror(char* s)
{
  fprintf(stderr, "%s\n", s);
  return 0;
}
int yywrap()
{
  return 1;
}
int main()
{
  yyparse();
  printf("\n");
  return 0;
}
