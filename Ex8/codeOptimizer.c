#include <stdio.h>
#include <string.h>

int main(int argc, char *argv[])
{
    stdin = fopen(argv[1], "r");
    // stdout = fopen("optimized.txt", "w");
    
    char line[100];

    scanf(" %s[^\n]", line);

    while (strcmp(line, "END") != 0)
    {
        if ((line[3] == '+' && line[4] == '0') || (line[3] == '*' && line[4] == '1'))
        {
            if (line[0] == line[2])
            {
                scanf(" %s[^\n]", line);
                continue;
            }
            printf("%c=%c\n", line[0], line[2]);
        }
        else if (line[3] == '*' && line[4] == '2')
        {
            printf("%c=%c+%c\n", line[0], line[2], line[2]);
        }
        else
            printf("%s\n", line);
        
        scanf(" %s[^\n]", line);
    }

    return (0);
}