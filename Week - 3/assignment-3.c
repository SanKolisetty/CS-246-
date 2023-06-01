#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

struct Student{
    char name[100];
    int number;
};

struct Course{
    int sem;
    char code[100]; 
    char name[200];
    int l;
    int t;
    int p;
    int credits;
};

struct grades{
    int numb;
    char cour[20];
    char grade[3];
};

void swap_structs(struct grades * a, int i, int j)
{
    struct grades temp = a[i];
    a[i] = a[j];
    a[j] = temp;
}

bool compare(struct grades a[], int j, int r)
{
    if(a[j].numb <= a[r].numb) return true;
    if(a[j].numb > a[r].numb) return false;
}

int partition_structs(struct grades a[], int l, int r)
{
    int i = l - 1;
    int j = l;
    for (int j = l; j < r ; j++)
    {
        if (compare(a,j,r))
        {
            i++;
            swap_structs(a, i, j);
        }
    }
    swap_structs(a,i+1,r);
    return i+1;
}

int quick_sort_structs(struct grades a[], int l, int r)
{
    if(l < r)
    {
        int q = partition_structs(a,l,r);
        quick_sort_structs(a,l,q-1);
        quick_sort_structs(a,q+1,r);
    }
    return 0;
}

void swap_structs1(struct Student * a, int i, int j)
{
    struct Student temp = a[i];
    a[i] = a[j];
    a[j] = temp;
}

bool compare1(struct Student a[], int j, int r)
{
    if(a[j].number <= a[r].number) return true;
    if(a[j].number > a[r].number) return false;
}

int partition_structs1(struct Student a[], int l, int r)
{
    int i = l - 1;
    int j = l;
    for (int j = l; j < r ; j++)
    {
        if (compare1(a,j,r))
        {
            i++;
            swap_structs1(a, i, j);
        }
    }
    swap_structs1(a,i+1,r);
    return i+1;
}

int quick_sort_structs1(struct Student a[], int l, int r)
{
    if(l < r)
    {
        int q = partition_structs1(a,l,r);
        quick_sort_structs1(a,l,q-1);
        quick_sort_structs1(a,q+1,r);
    }
    return 0;
}

struct final{
    char SName[100];
    char CName[200];
    int SCredits;
    char SGrade[3];
};

int find_name(char * str, struct Course * courses)
{
    int j = 0;
    for(j = 0; j < 63; j++)
    {
        if(strcmp(courses[j].code, str) == 0)
        {
            return j;
        }
    }
}

void swap_structs2(struct final * a, int i, int j)
{
    struct final temp = a[i];
    a[i] = a[j];
    a[j] = temp;
}

bool compare2(struct final a[], int j, int r)
{
    if(strcmp(a[j].SName, a[r].SName) < 0) return true;
    if(strcmp(a[j].SName, a[r].SName) > 0) return false;
    if(a[j].SCredits > a[r].SCredits) return true;
    if(a[j].SCredits < a[r].SCredits) return false;
    if(strcmp(a[j].SGrade, a[r].SGrade) < 0) return true;
    if(strcmp(a[j].SGrade, a[r].SGrade) > 0) return false;
    return true;
}

int partition_structs2(struct final a[], int l, int r)
{
    int i = l - 1;
    int j = l;
    for (int j = l; j < r ; j++)
    {
        if (compare2(a,j,r))
        {
            i++;
            swap_structs2(a, i, j);
        }
    }
    swap_structs2(a,i+1,r);
    return i+1;
}

int quick_sort_structs2(struct final a[], int l, int r)
{
    if(l < r)
    {
        int q = partition_structs2(a,l,r);
        quick_sort_structs2(a,l,q-1);
        quick_sort_structs2(a,q+1,r);
    }
    return 0;
}

void bubblesort_structs(struct final * a, int count)
{
    for(int i = 0; i < count-1; i++)
    {
        for(int j = 0; j < count-i-1; j++)
        {
            if(!compare2(a,j,j+1))
            {
                swap_structs2(a,j+1,j);
            }
        }
    }
}

void sorting_finale_Q(struct final * a)
{
    quick_sort_structs2(a,0,9953);
}

void sorting_finale_B(struct final * a)
{
    bubblesort_structs(a,9954);
}

int main()
{
    struct Student * studs = malloc(200 * sizeof(struct Student));

    FILE *f1 = fopen("students01.csv", "r");
    int i = 0;
    while(!feof(f1))
    {
        fscanf(f1, "%99[^,], %d\n", studs[i].name, &studs[i].number);
        i++;
    }
    int stu_count = i;

    struct Course * courses = malloc(100 * sizeof(struct Course));
    FILE *f2 = fopen("courses01.csv", "r");
    int j = 0;
    while(!feof(f2))
    {
        fscanf(f2, "%d, %99[^,], %99[^,], %d, %d, %d, %d\n", &courses[j].sem, courses[j].code, courses[j].name, &courses[j].l, &courses[j].t, &courses[j].p, &courses[j].credits);
        j++;
    }
    int course_count = j;

    struct grades * grade = malloc(10000 * sizeof(struct grades));
    FILE *f3 = fopen("grades01.csv", "r");
    int s = 0;
    do
    {
        fscanf(f3, "%d, %19[^,], %2s\n", &grade[s].numb, grade[s].cour, grade[s].grade);
        s++;
    }while (!feof(f3));

    quick_sort_structs(grade,0,s-1);
    FILE *f4 = fopen("sorted_grades.txt", "w");
    for(int j = 0; j < s; j++)
    {
        fprintf(f4, "%d, %s, %s\n", grade[j].numb, grade[j].cour, grade[j].grade);
    }
    fclose(f4);

    quick_sort_structs1(studs,0,stu_count-1);
    FILE *f5 = fopen("sorted_names.txt", "w");
    for(int j = 0; j < stu_count; j++)
    {
        fprintf(f5, "%d, %s\n", studs[j].number, studs[j].name);
    }
    fclose(f5);

    struct final * result = malloc(100000000 * sizeof(result));
    for(int j = 0; j < 9954; j++)
    {
        int numbe = j/63;
        strcpy(result[j].SName, studs[numbe].name);
        int ans = find_name(grade[j].cour, courses);
        strcpy(result[j].CName, courses[ans].name);
        result[j].SCredits = courses[ans].credits;
        strcpy(result[j].SGrade, grade[j].grade); 
    }
    
    sorting_finale_Q(result);

    FILE *f12 = fopen("210101093_grades-sorted-Q.csv", "w");
    for(int j = 0; j < 9954; j++)
    {
        fprintf(f12, "%s, %s, %d, %s\n", result[j].SName, result[j].CName, result[j].SCredits, result[j].SGrade);
    }

    sorting_finale_B(result);

    FILE *f13 = fopen("210101093_grades-sorted-B.csv", "w");
    for(int j = 0; j < 9954; j++)
    {
        fprintf(f13, "%s, %s, %d, %s\n", result[j].SName, result[j].CName, result[j].SCredits, result[j].SGrade);
    }

    printf("DONE !!!\n");
}
