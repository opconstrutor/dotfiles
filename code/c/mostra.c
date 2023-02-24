#include <stdio.h>

void cat (FILE* file);

int
main (int args, char **argv)
{
    FILE *file;
    for (int i = 1; i < args; ++i) {
        file = fopen (argv[i], "r");
        cat (file);
        fclose (file);
    }

    return 0;
}

void
cat (FILE *file)
{
    int c;
    while ( (c = fgetc (file)) != EOF ) putchar (c);
}
