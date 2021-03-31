typedef char string[30];

typedef enum
{
    FAIL,
    SUCCESS
} Result;

void indent(const int level)
{
    for (int i = 0; i < level; i++)
        printf("    ");
}

Result T(string, int *, int);
Result E(string, int *, int);
Result Eprime(string, int *, int);
Result Tprime(string, int *, int);
Result F(string, int *, int);

Result recursiveParser(string input)
{
    int index = 0;
    return E(input, &index, 0);
}

Result E(string input, int *idx, int depth)
{
    if (!input[*idx])
        return FAIL;

    indent(depth);
    printf("E()\n");
    Result result = T(input, idx, depth + 1);

    if (result == FAIL)
        return FAIL;

    result = Eprime(input, idx, depth + 1);
    return result;
}

Result Eprime(string input, int *idx, int depth)
{
    if (!input[*idx])
        return FAIL;
    indent(depth);
    printf("E'()\n");
    Result result;
    int current_idx = *idx;
    if (input[*idx] == '+')
    {
        indent(depth);
        printf("Non terminal \'+\' found!\n");
        (*idx) = (*idx) + 1;
        result = T(input, idx, depth + 1);
        if (result == FAIL)
            return FAIL;
        result = Eprime(input, idx, depth + 1);
        if (result == SUCCESS)
            return SUCCESS;
    }
    *idx = current_idx;
    indent(depth);
    printf("Non terminal \'+\' found!\n");
    return SUCCESS;
}

Result T(string input, int *idx, int depth)
{
    if (!input[*idx])
        return FAIL;
    indent(depth);
    printf("T()\n");
    Result result = F(input, idx, depth + 1);
    if (result == FAIL)
        return FAIL;
    result = Tprime(input, idx, depth + 1);
    return result;
}

Result Tprime(string input, int *idx, int depth)
{
    if (!input[*idx])
        return FAIL;
    indent(depth);
    printf("T'()\n");
    Result result;
    int current_idx = *idx;
    if (input[*idx] == '*')
    {
        indent(depth);
        printf("Non terminal \'*\' found!\n");
        (*idx) = (*idx) + 1;
        result = F(input, idx, depth + 1);
        if (result == FAIL)
            return FAIL;
        result = Tprime(input, idx, depth + 1);
        if (result == SUCCESS)
            return SUCCESS;
    }
    *idx = current_idx;
    indent(depth);
    printf("Non terminal \'*\' not found!\n");
    return SUCCESS;
}

Result F(string input, int *idx, int depth)
{
    if (!input[*idx])
        return FAIL;
    indent(depth);
    printf("F()\n");
    int current_idx = *idx;
    if (input[*idx] == 'i' && input[*idx + 1] == 'd')
    {
        (*idx) += 2;
        indent(depth);
        printf("Non terminal \'id\' found!\n");
        return SUCCESS;
    }
    else if (input[*idx] == '(')
    {
        indent(depth);
        printf("Non terminal \'(\' found!\n");
        Result result = E(input, idx, depth + 1);
        if (result == FAIL)
            return FAIL;

        if (input[*idx] == ')')
            return SUCCESS;
    }
    return FAIL;
}