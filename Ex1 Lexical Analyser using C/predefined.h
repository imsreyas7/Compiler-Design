#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<math.h>
#include<limits.h>
#include<stdbool.h>
#include<ctype.h>
const int T = 1;
const int F = 0;
// Creating a global array of keywords , operators, symbols 

char keywords[][100]={"return","int","float","long","double","char","if","else"};
char operators[][10]={"+","-","*","/","^","%","<",">","!","?","==","<=",">=","||","&&"};
char symbol[]={'{','}',';',',','.',':',')','('};
int sym_size = 9;
int key_size = 10;
int op_size = 15;
int relop_size = 7;
int arthop_size = 6;
char arth_operators[][10]={"+","-","*","/","^","%",};
int logop_size = 4;
char log_operators[][10] = {"||","&&","&","|"};
char rel_operators[][10]={"<",">","!","?","==","<=",">="};
