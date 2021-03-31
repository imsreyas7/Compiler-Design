%{
    #include<stdio.h>
    #include<stdlib.h>
    #include<string.h>
    #include "y.tab.h"
    int debug=0;
    int line=0;
%}
%%
[ \t]+ ;
\n {line++;}
[0-9]+ { if(debug)printf("%s is an integer\n", yytext);return INT;}
("int"|"float"|"char"|"double") {if(debug)printf("%s is a data type\n", yytext);return DTYPE; }
"if" {return IF;}
"while" {return WHILE;}
"else" {return ELSE;}
[_a-zA-Z][a-zA-Z0-9_]* { if(debug)printf("%s is an identifier\n", yytext);return ID; }
";" {if(debug)printf("End of statement\n");return EOS;}
(">"|"<"|"<="|">="|"!="|"==") { return COMPARSION_OP; }
("+="|"-="|"*="|"/="|"=") { if(debug)printf("%s is an assign op\n", yytext);return ASSIGN_OP; }
">>" { return RSHIFT; }
"<<" {return LSHIFT; }
"!" { return NOT; }
"{" { return *yytext; }
"}" { return *yytext; }
"||" {return OR; }
"&&" {return AND; }
[+\-^*/,().] {return *yytext;}
. {
  fprintf(stderr,"Unknown token found: <%s>\n", yytext);
}
%%