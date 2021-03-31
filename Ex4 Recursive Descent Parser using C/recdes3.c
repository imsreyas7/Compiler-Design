#include <stdio.h>
#include <string.h>

#include "procedures.h"

void printResult(Result);

int main(void)
{
    string input;
    int opt = -1;
    while (opt != 0)
    {
        printf("Enter the input string: ");
        scanf("%s", input);
        printResult(recursiveParser(input));
        printf("---------------------------\n\n");
        printf("Do you want to continue 1/0: ");
        scanf("%d", &opt);
    }
}

void printResult(Result result)
{
    if (result == SUCCESS)
        printf("Given string is accepted!\n");
    else
        printf("Given string is not accepted!\n");
}