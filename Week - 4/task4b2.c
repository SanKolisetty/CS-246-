#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

int main()
{
    FILE *f1 = fopen("additional_hss_course.csv", "r");

    FILE *f2 = fopen("task4b2.sql", "w");
    fprintf(f2, "USE week04;\n");

    int i = 0;
    while (i < 9)
    {
        int a,b;
        char name[200];
        char cname[50];
        char course[200];
        fscanf(f1, "%d,%d,%199[^,], %49[^,], %199[^\n]\n", &a, &b, name, cname, course);
        fprintf(f2, "INSERT INTO hss_table03 (sno, roll_number, sname, cid, cname) VALUES (%d, %d, \"%s\", \"%s\", \"%s\");\n", a, b, name, cname, course);     
        i++;
    }    
}