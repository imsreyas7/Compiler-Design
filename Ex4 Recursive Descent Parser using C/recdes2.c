#include<stdio.h>
#include<stdlib.h>
#include<string.h>

/*Recursive Descent Parser*/

/*
Grammar: G: E->E+T|E-T|T
            T->T*F|T/F|F
            F->(E)|i
*/

/*
Removed Left Recursion
Grammar G': E->TE'
            E'->+TE'|-TE'|e
            T->FT'
            T'->*FT'|/FT'|e
            F->(E)|i
*/

struct parse_struct{
    char str[100];
    int pos;
    int len;
};

typedef struct parse_struct parser;

parser E(parser p);
parser T(parser p);
parser EPrime(parser p);
parser F(parser p);
parser TPrime(parser p);
parser parse(parser p, char s);

int main(void){
    parser p;

    printf("\n\t\tRecursive Descent Parser\n");
    printf("\nEnter a string to parse: ");
    scanf("%s", p.str);

    p.len = strlen(p.str);
    p.pos = 0;

    p = E(p);
    
    if(p.pos == p.len){
        //All characters have been parsed
        printf("\nParse Success!\n");
    }

    else{
        //Some characters haven't been parsed, but returned to main
        printf("\nError parsing at Position %d!\n", p.pos);
    }

    return 0;
}

parser E(parser p){
    //printf("\nAt E");
    p = T(p);
    p = EPrime(p);
    
    return p;
}

parser T(parser p){
    //printf("\nAt T");
    p = F(p);
    p = TPrime(p);
    
    return p;
}

parser EPrime(parser p){
    //printf("\nAt EPrime");
    if(p.str[p.pos] == '+'){
        p = parse(p, '+');
        p = T(p);
        p = EPrime(p);
    }
    else if(p.str[p.pos] == '-'){
        p = parse(p, '-');
        p = T(p);
        p = EPrime(p);
    }

    return p;
}

parser TPrime(parser p){
    //printf("\nAt TPrime");
    if(p.str[p.pos] == '*'){
        p = parse(p, '*');
        p = F(p);
        p = TPrime(p);
    }
    else if(p.str[p.pos] == '/'){
        p = parse(p, '/');
        p = F(p);
        p = TPrime(p);
    }

    return p;
}

parser F(parser p){
    //printf("\nAt F");
    if(p.str[p.pos] == '('){
        p = parse(p, '(');
        p = E(p);
        p = parse(p, ')');
    }
    else if(p.str[p.pos] == 'i'){
        p = parse(p, 'i');
    }
    else{
        printf("\nError parsing at Position %d!\n", p.pos);
        exit(0);
    }

    return p;
}

parser parse(parser p, char s){
    if(p.str[p.pos] != s){
        printf("\nError parsing at Position %d!\n", p.pos);
        exit(0);
    }
    else{
        p.pos++;
    }

    return p;
}