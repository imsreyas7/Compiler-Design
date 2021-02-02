#include"predefined.h"


/*Code checks for the following patterns
Identifier
Constant
Comments
Operators
Keywords*/

bool issymbol(char ch[100])
{
    int i;
    for(i=0;i<sym_size;i++)
    {
        if(ch[0]==symbol[i])
            return true;
    }
    return false;
}
bool check_function(char str[100])
{
    int i=0;
    bool a,b;
    for(i=0;i<strlen(str);i++)
    {
        if(str[i]=='(')
            a=true;
        if(str[i]==')')
            b=true;
    }
    if(a && b)
        return true;
    return false;
}
bool check_operator(char str[100])
{
    int i;
    for(i=0;i<op_size;i++)
    {
        if(strcmp(str,operators[i])==0)
            return true;
    }
    return false;
}
bool check_RELOP(char *str)
{
    int i;
    for(i=0;i<relop_size;i++)
    {
        if(strcmp(str,rel_operators[i])==0)
            return true;
    }
    return false;

}
bool check_LOGOP(char *str)
{
    int i;
    for(i=0;i<logop_size;i++)
    {
        if(strcmp(str,log_operators[i])==0)
            return true;
    }
    return false;

}
bool check_ARTHOP(char *str)
{
    int i;
    for(i=0;i<arthop_size;i++)
    {
        if(strcmp(str,arth_operators[i])==0)
            return true;
    }
    return false;

}
bool check_comment(char *str)
{
    if(str[0]=='\\' || str[1]=='\\')
        return true;
    return false;
}
bool check_keyword(char str[100])
{
    int i;
    for(i=0;i<key_size;i++)
    {
        if(strcmp(str,keywords[i])==0)
            return true;

    }
    return false;
}
bool check_assign(char ch)
{
    if(ch=='=')
        return true;
    return false;
}
bool check_num(char str[100])
{
    int len = strlen(str);
    int i=0;
    while(i<len)
    {
        if(!isdigit(str[i]))
            return false;
        i++;
    }
    return true;
}
bool check_char(char str[100])
{
    if((str[0]=='\"' || str[0]=='\'' ) && (str[strlen(str)-1]=='\"' || str[strlen(str)-1]=='\''))
        return true;
    return false;
}

void analyser(char input[100000])
{
    int i=0,temp=0;
    int len = strlen(input);
    char line[100][1000];
    int l=0;
    int flag=0;
    char *token = strtok(input,"\n");
    while(token!=NULL)
    {
        strcpy(line[l++],token);
        token = strtok(NULL,"\n");
    }
    int l1=0;
    while(l1<l)
    {
        if((line[l1][0]=='/') && (line[l1][1]=='/'))
        {
                printf(" SL CMT\n");
                l1++;
                continue;
        }
        if((line[l1][0]=='/') && (line[l1][1]=='*') && (flag == 0))
        {
                printf(" ML CMT STARTS\n");
                l1++;
                flag=1;
                continue;
        }
        if((line[l1][0]=='*') && (line[l1][1]=='/') && (flag == 1))
        {
                printf(" ML CMT ENDS\n");
                l1++;
                flag=0;
                continue;
        }
        if(flag)
        {
            l1++;
            continue;
        }
        token = strtok(line[l1]," ");
        if(strlen(token)==1 && token[0]=='\n')
            continue;
        while(token!=NULL)
        {
            if(check_keyword(token))
                printf(" KW ");
            else if(check_function(token))
                printf(" FC");
            else if(check_assign(token[0]))
                printf(" ASSIGN");
            else if(check_operator(token))
            {
                if(check_RELOP(token))
                    printf(" RELOP");
                else if(check_LOGOP(token))
                    printf(" LOGDOP");
                else if(check_ARTHOP(token))
                    printf(" ARTHOP");
                else
                    printf(" OP");
            }
            else if(issymbol(token))
                printf(" SP");
            else if(check_num(token))
                printf(" NUMCONST");
            else if(check_char(token))
                printf(" CHARCONST");
            else if(!isdigit(token[0]))
                printf(" ID");            
            else
                printf(" INVALID CHA");
            token = strtok(NULL," ");
        }
        printf("\n");    
        l1++;
    }
}
void main()
{
    char code[100000];
    FILE * file = fopen("input.txt", "r");
    char  c;
    int idx=0;
    while (fscanf(file , "%c" ,&c) == 1)
    {
        code[idx] = c;
        idx++;
    }
    code[idx] = '\0';
    printf("\n");
    analyser(code);
}

