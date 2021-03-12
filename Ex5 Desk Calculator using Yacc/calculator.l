
%{ 
#include<stdio.h> 
#include<math.h>
#include"y.tab.h" 
extern int yylval; 
%} 


%% 
[0-9]+ {yylval=atoi(yytext);return NUMBER;} 

"<=" return le;

">=" return ge;

"==" return eq;

"!=" return neq;

"&&" return and;

"||" return or;

"<<" return bl;

">>" return br;

[\t] ; 
  
[\n] return 0; 
  
. return yytext[0]; 
  
%% 
  
int yywrap() 
{ 
 return 1; 
} 

