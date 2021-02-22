#include<stdio.h>  
#include<string.h> 
int main()
{
	char prod[50][50];
	char alpha[10],beta,nt,start,index=3;
	int n,flag,j=0;
	printf("\nEnter the number of productions: ");
	scanf("%d",&n);
	printf("\nEnter the grammar:\n");
	for(int i=0;i<n;i++){  
            scanf("%s",prod[i]);
	}	
	printf("\n=> GRAMMAR <=\n");
	for(int i=0;i<n;i++)
    {  
        printf("%s\n",prod[i]);			
	    nt=prod[i][0];  
        if(nt==prod[i][3])
	    {  
            alpha[0]=prod[i][4];
	        flag=1;
        }
	}	
	if(flag==1)
		printf("\nThe grammar is left recursive\n");
	else
		printf("\nThe grammar is not left recursive\n");
	
	printf("\nGrammar Without Left Recursion:\n");
    for(int i=0;i<n;i++)
    {	
		j=0;
        start=prod[i][0];
        if(start==prod[i][index])
        {
            while(prod[i][index]!=0 && prod[i][index]!='|')
            {
                alpha[j]=prod[i][index+1];
                j++;
                index++;
            }
            alpha[j-1]='\0';
            if(prod[i][index]!=0)
            {
                beta=prod[i][index+1];
                printf("\n%c->%c%c\'",start,beta,start);
                printf("\n%c\'->ϵ|%s%c\'\n",start,alpha,start);
            }
			index=3;

		}

	}
}