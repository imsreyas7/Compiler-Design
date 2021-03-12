
%{ 
#include<stdio.h> 
#include<math.h>
int flag=0; 
%} 
  
%token NUMBER or and eq neq le ge bl br

%left or

%left and 

%left '|'

%left '&'

%left eq neq

%left '>' '<' le ge

%left bl br

%left '+' '-'
  
%left '*' '/' '%' 

%right '^'

%right '!'
  
%left '(' ')'
  

%% 
  
ArithmeticExpression: E{ 
         printf("\nResult = %d\n", $$); 
         return 0; 
        }; 

 E: E or E {$$=$1||$3;}

 | E and E {$$=$1&&$3;}

 |E'+'E {$$=$1+$3;} 
  
 |E'-'E {$$=$1-$3;} 
  
 |E'*'E {$$=$1*$3;} 
  
 |E'/'E {$$=$1/$3;} 

 |E'^'E {$$=pow($1,$3);} 
  
 |E'%'E {$$=$1%$3;} 
  
 |'('E')' {$$=$2;} 

 |'!'E {$$=(!($2)); }

 | E'<'E {$$=$1<$3;}

 | E'>'E {$$=$1>$3;}

 | E eq E {$$=$1==$3;}

 | E neq E {$$=$1!=$3;}

 | E bl E {$$=$1<<$3;}

 | E br E {$$=$1>>$3;}

 | E le E {$$=$1<=$3;}

 | E ge E {$$=$1>=$3;}

 |E'&'E {$$=$1&$3;}

 |E'|'E {$$=$1|$3;}

 |'-'E {$$=(-($2));}

  
 | NUMBER {$$=$1;} 
  
 ; 
  
%% 
  

void main() 
{ 
   printf("\nEnter the Arithmetic Expression :\n"); 
  
   yyparse(); 

} 
  
void yyerror() 
{ 
   printf("\nInvalid expression\n\n"); 
   flag=1; 
} 

