%{
    #include <stdlib.h>
    #include <stdio.h>
    int yylex(void);
    extern FILE* yyin;
    #include "y.tab.h"
    int error = 0;
    /*extern int debug;*/
    extern int line;
%}
%token INT ASSIGN_OP COMPARSION_OP ID DTYPE LSHIFT RSHIFT NOT AND OR EOS IF ELSE WHILE

%%
program : statement EOS programPrime
        | loop_block programPrime
        | cond_statement programPrime
        ;

programPrime:   program
            |
            ;
statement: declaration
        | expr  {printf("Expression found!\n");}
        | ID ASSIGN_OP expr {printf("Expression found!\n");}
        | cond_statement
        ;
cond_statement  : IF '(' expr ')' statement EOS optional 
                ;
optional    : ELSE statement EOS{printf("IF with else!\n");}
            |                    {printf("IF without else!\n");}
            ;

loop_block  : WHILE '(' expr ')' '{' statement EOS loop_optional
            ;
loop_optional   : '}' {printf("While loop found!\n");}
                | statement EOS
                | loop_optional
                ;
    
declaration : DTYPE ID ASSIGN_OP INT { printf("Declaration with assignment found!\n");}
            | DTYPE ID {printf("Declaration found!\n");}
            | DTYPE ID ASSIGN_OP expr {printf("Declaration with expr found!\n");}
            ;

expr    : expr '+' expr 
        | expr '-' expr 
        | expr '*' expr 
        | expr '/' expr 
        | expr '^' expr 
        | expr AND expr 
        | expr OR expr 
        | NOT expr 
        | '(' expr ')' 
        | expr LSHIFT expr 
        | expr RSHIFT expr 
        | expr COMPARSION_OP expr
        | INT
        | INT '.' INT 
        | ID
        ;
%%
int yyerror(){
    fprintf(stderr, "Syntax is NOT valid!Error at line %d\n", line);
    error = 1;
    return 0;
}

int yywrap(){
    return 1;
}

int main(int argc, char **argv){
    /*yydebug = 1;*/
    if(argc != 2){
        fprintf(stderr, "Enter file name as argument!\n");
        return 1;
    }
    yyin = fopen(argv[1], "rt");
    if (!yyin){
        fprintf(stderr, "File not found!\n");
        return 2;
    }
    yyparse();
    if(!error){
        printf("Valid syntax!\n");
    }
    return 0;
}