#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int main(int argc, char *argv[]){
    stdin = fopen(argv[1], "r");
    char line[100];

    printf("\n---Parsed Code Starts---\n\n");
    system("cat Code.txt");
    printf("\n\n---Parsed Code Ends---\n");

    printf("\n---Optimized Code Starts---\n\n");

    scanf(" %s[^\n]", line);

    while (strcmp(line, "END") != 0){

        //FOR: x=y+0; x=y*1;
        if ((line[3] == '+' && line[4] == '0') || (line[3] == '*' && line[4] == '1')){
            if (line[0] == line[2]){
                scanf(" %s[^\n]", line);
                continue;
            }

            printf("%c=%c\n", line[0], line[2]);
        }

        //FOR: x=y-0; x=y/1;
        else if ((line[3] == '-' && line[4] == '0') || (line[3] == '/' && line[4] == '1')){
            if (line[0] == line[2]){
                scanf(" %s[^\n]", line);
                continue;
            }
            printf("%c=%c\n", line[0], line[2]);
        }

        //FOR: x=0+x; x=1*y
        else if ((line[3] == '+' && line[2] == '0') || (line[3] == '*' && line[2] == '1')){
            if (line[0] == line[4]){
                scanf(" %s[^\n]", line);
                continue;
            }
            printf("%c=%c\n", line[0], line[4]);
        }

        //FOR: x=y*2
        else if (line[3] == '*' && line[4] == '2'){
            printf("%c=%c+%c\n", line[0], line[2], line[2]);
        }

        //FOR: x=2*y
        else if (line[3] == '*' && line[2] == '2'){
            printf("%c=%c+%c\n", line[0], line[4], line[4]);
        }

        //FOR: x=pow(y,2);
        else if (line[2] == 'p' && line[3] == 'o' && line[4] == 'w' && line[5] == '(' && line[8] == '2'){
            printf("%c=%c*%c\n", line[0], line[6], line[6]);
        }

        else{
            printf("%s\n", line);
        }

        scanf(" %s[^\n]", line);    //next line
    }

    printf("\n---Optimized Code Ends---\n");

    return 0;
}