#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

int main()
{
    FILE *f1 = fopen("hss_courses.csv", "r");

    FILE *f2 = fopen("task6c.sql", "w");
    fprintf(f2, "USE week04;\n");

    int i = 0;
    while (i < 21)
    {
        char cid[10];
        char cname[60];
        fscanf(f1, "%9[^,], %59[^\n]\n", cid, cname);
        fprintf(f2, "INSERT INTO hss_course01 (cid, cname) VALUES (\"%s\", \"%s\");\n", cid,cname);     
        i++;
    }    
}