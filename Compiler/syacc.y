%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

const int MAXLEN = 1024;

int yyerror(char*);
int yylex(void);
int yywrap();

int label_count() {
    static int label = 0;
    return label++;
}

int var_count() {
    static int varc = 0;
    return varc++;
}

typedef struct Node{
    //Storage Part
    int int_value;
    float float_value;
    char* var;
    char* ovar;
    //Output Part
    char* tac;
    char* opti;
    char* gen;
}Node;

Node* makeNode() {
    Node* temp = (Node*)malloc(sizeof(Node));
    temp->int_value = 0;
    temp->float_value = 0.0;
    temp->var = (char*)malloc(sizeof(char)*MAXLEN);
    temp->ovar = (char*)malloc(sizeof(char)*MAXLEN);
    
    temp->tac = (char*)malloc(sizeof(char)*MAXLEN);
    temp->opti = (char*)malloc(sizeof(char)*MAXLEN);
    temp->gen = (char*)malloc(sizeof(char)*MAXLEN);
    
    return temp;
}

%}

%union {
    int ival;
    float fval;
    char* str;
    struct Node* node;
};
%token <str> TERM
%token <ival> INT
%type  <node> Program Format Statements Statement Assignment Expression E T F 

%left '*''/'
%right '+''-'

%%
Program     : Format {
                    printf("\nA SAMPLE COMPILER\n");
                    printf("\n0. Input Code-\n");
                    system("cat input.txt");
                    printf("\n\n1. Syntax Checker-\nSyntactically  Correct!!\n");
                    printf("\n2. TAC Code-\n%s\n", $1->tac);
                    printf("\n3. Code Optimization-\n%s\n", $1->opti);
                    printf("\n4. Code Generation-\n%s\n", $1->gen);
                    }
            ;
Format      : Statements { $$ = $1; }
            ;
Statements  : Statement Statements { 
                                //printf("")
                                    $$ = makeNode();
                                    sprintf($$->tac, "%s%s", $1->tac, $2->tac);
                                    sprintf($$->opti, "%s%s", $1->opti, $2->opti);
                                    sprintf($$->gen, "%s%s", $1->gen, $2->gen); 
                                    }
            | Statement     { $$ = $1; }
            ;
Statement   : Assignment '\n'{ $$ = $1; }
            ;

Assignment  : TERM '=' Expression {
                        $$ = makeNode();
                        sprintf($$->var, "%s", $1);
                        char line[100];
                        char machine[100];
                        sprintf(line, "%s := %s\n", $$->var, $3->var);
                        sprintf(machine, "MOV %s, R0\nMOV R0, %s\n", $3->var, $$->var);
                        if(strcmp($$->var, $3->var)==0) {
                            sprintf($$->opti,"%s", $3->opti);
                            sprintf($$->gen, "%s", $3->gen);
                        } else {
                            sprintf($$->opti,"%s%s", $3->opti, line);
                            sprintf($$->gen, "%s%s", $3->gen, machine);
                        }

                        sprintf($$->tac, "%s%s", $3->tac, line);

                        
                        }
            ;
Expression  : E         { $$ = $1; }
            ;
E           : E '*' T   {
                        $$ = makeNode();
                        int val = var_count();
                        sprintf($$->var, "t%d", val);
                        char line[100], machine[100];
                        sprintf(line, "%s := %s * %s\n", $$->var, $1->var, $3->var);

                        if(strcmp($3->var,"1")==0) {
                            sprintf($$->opti, "%s%s%s := %s\n", $1->opti, $3->opti, $$->var, $1->var);   
                            sprintf(machine, "MOV %s, R0\nMOV R0, %s\n", $1->var, $$->var);
                            sprintf($$->gen, "%s%s%s", $1->gen, $3->gen, machine);
                        } else if(strcmp($1->var,"1")==0) {
                            sprintf($$->opti, "%s%s%s := %s\n", $1->opti, $3->opti, $$->var, $3->var);   
                            sprintf(machine, "MOV %s, R0\nMOV R0, %s\n", $3->var, $$->var);
                            sprintf($$->gen, "%s%s%s", $1->gen, $3->gen, machine);
                        } else {
                            sprintf($$->opti, "%s%s%s", $1->opti, $3->opti, line);
                            sprintf(machine, "MOV %s, R0\nMUL %s, R0\nMOV R0, %s\n", $1->var, $3->var, $$->var);
                            sprintf($$->gen, "%s%s%s", $1->gen, $3->gen, machine);
                        }
                        
                        sprintf($$->tac, "%s%s%s", $1->tac, $3->tac, line);

                        }
            | E '/' T   {
                        $$ = makeNode();
                        int val = var_count();
                        sprintf($$->var, "t%d", val);
                        char line[100], machine[100];
                        sprintf(line, "%s := %s / %s\n", $$->var, $1->var, $3->var);


                        if(strcmp($3->var,"1")==0) {
                            sprintf($$->opti, "%s%s%s := %s\n", $1->opti, $3->opti, $$->var, $1->var);   
                            sprintf(machine, "MOV %s, R0\nMOV R0, %s\n", $1->var, $$->var);
                            sprintf($$->gen, "%s%s%s", $1->gen, $3->gen, machine);
                        } else {
                            sprintf($$->opti, "%s%s%s", $1->opti, $3->opti, line);
                            sprintf(machine, "MOV %s, R0\nDIV %s, R0\nMOV R0, %s\n", $1->var, $3->var, $$->var);
                            sprintf($$->gen, "%s%s%s", $1->gen, $3->gen, machine);
                        }
                        sprintf($$->tac, "%s%s%s", $1->tac, $3->tac, line);

                        }
            | T         { $$ = $1; }
            ;
T           : F '+' T   {
                        $$ = makeNode();
                        int val = var_count();
                        sprintf($$->var, "t%d", val);
                        char line[100], machine[100];
                        sprintf(line, "%s := %s + %s\n", $$->var, $1->var, $3->var);

                        if(strcmp($3->var,"0")==0) {
                            sprintf($$->opti, "%s%s%s := %s\n", $1->opti, $3->opti, $$->var, $1->var);   
                            sprintf(machine, "MOV %s, R0\nMOV R0, %s\n", $1->var, $$->var);
                            sprintf($$->gen, "%s%s%s", $1->gen, $3->gen, machine);
                        } else if(strcmp($1->var,"0")==0) {
                            sprintf($$->opti, "%s%s%s := %s\n", $1->opti, $3->opti, $$->var, $3->var);   
                            sprintf(machine, "MOV %s, R0\nMOV R0, %s\n", $3->var, $$->var);
                            sprintf($$->gen, "%s%s%s", $1->gen, $3->gen, machine);
                        }else {
                            sprintf($$->opti, "%s%s%s", $1->opti, $3->opti, line);
                            sprintf(machine, "MOV %s, R0\nADD %s, R0\nMOV R0, %s\n", $1->var, $3->var, $$->var);
                            sprintf($$->gen, "%s%s%s", $1->gen, $3->gen, machine);
                        }

                        sprintf($$->tac, "%s%s%s", $1->tac, $3->tac, line);

                        }
            | F '-' T   {
                        $$ = makeNode();
                        int val = var_count();
                        sprintf($$->var, "t%d", val);
                        sprintf($$->ovar, "%s", $$->var);
                        char line[100], machine[100];
                        sprintf(line, "%s := %s - %s\n", $$->var, $1->var, $3->var);

                        if(strcmp($3->var,"0")==0) {
                            sprintf($$->opti, "%s%s%s := %s\n", $1->opti, $3->opti, $$->var, $1->var);   
                            sprintf(machine, "MOV %s, R0\nMOV R0, %s\n", $1->var, $$->var);
                            sprintf($$->gen, "%s%s%s", $1->gen, $3->gen, machine);
                        }else {
                            sprintf($$->opti, "%s%s%s", $1->opti, $3->opti, line);
                            sprintf(machine, "MOV %s, R0\nSUB %s, R0\nMOV R0, %s\n", $1->var, $3->var, $$->var);
                            sprintf($$->gen, "%s%s%s", $1->gen, $3->gen, machine);
                        }

                        sprintf($$->tac, "%s%s%s", $1->tac, $3->tac, line);

                        }
            | F         { $$ = $1; }
            ;
F           : INT       {
                        $$ = makeNode();
                        sprintf($$->var, "%d", $1);
                        sprintf($$->tac, "");
                        sprintf($$->opti, "");
                        sprintf($$->gen, "");
                        }
            | TERM      {
                        $$ = makeNode();
                        sprintf($$->var, "%s", $1);
                        sprintf($$->tac, "");
                        sprintf($$->opti, "");
                        sprintf($$->gen, "");
                        }
            ;
%%
int yyerror(char* err) {
    fprintf(stderr, "\n%s\n", err);
    printf("bruuhh \n\n");
    return 0;
}

int yywrap() {
    return 1;
}

int main() {
    yyparse();
    return 0;
}