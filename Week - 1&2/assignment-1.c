#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>
#include <stdbool.h>

struct dts{
    int date;
    char hour[100];
    char min[100];
    char sec[100];
};

void swap_structs(struct dts * a, int i, int j)
{
    struct dts temp = a[i];
    a[i] = a[j];
    a[j] = temp;
}

bool compare_time(struct dts a[], int j, int r)
{
    if(a[j].date < a[r].date) return true;
    if(a[j].date > a[r].date) return false;
    int h1 = atoi(a[j].hour);
    int h2 = atoi(a[r].hour);
    if(h1 < h2) return true;
    if(h1 > h2) return false;
    int m1 = atoi(a[j].min);
    int m2 = atoi(a[r].min);
    if(m1 < m2) return true;
    if(m1 > m2) return false;
    int s1 = atoi(a[j].sec);
    int s2 = atoi(a[r].sec);
    if(s1 < s2) return true;
    if(s1 > s2) return false;
    return false;
}

int partition_time(struct dts a[], int l, int r)
{
    int i = l - 1;
    int j = l;
    for (int j = l; j < r ; j++)
    {
        if (compare_time(a,j,r))
        {
            i++;
            swap_structs(a, i, j);
        }
    }
    swap_structs(a,i+1,r);
    return i+1;
}

int quick_sort_time(struct dts a[], int l, int r)
{
    if(l < r)
    {
        int q = partition_time(a,l,r);
        quick_sort_time(a,l,q-1);
        quick_sort_time(a,q+1,r);
    }
    return 0;
}

void bubblesort_time(struct dts a[], int count)
{
    for(int i = 0; i < count-1; i++)
    {
        for(int j = 0; j < count-i-1; j++)
        {
            if(!compare_time(a,j,j+1))
            {
                swap_structs(a,j+1,j);
            }
        }
    }
}

int swap(int *a, int *b)
{
    int temp = *a;
    *a = *b;
    *b = temp;
    return 0;
}

int partition(int a[], int l, int r)
{
    int i = l - 1;
    int j = l;
    for (int j = l; j < r ; j++)
    {
        if (a[j] <= a[r])
        {
            i++;
            swap(&a[i], &a[j]);
        }
    }
    swap(&a[i+1],&a[r]);
    return i+1;
}

int quick_sort(int a[], int l, int r)
{
    if(l < r)
    {
        int q = partition(a,l,r);
        quick_sort(a,l,q-1);
        quick_sort(a,q+1,r);
    }
    return 0;
}

void bubblesort(int a[], int count)
{
    for(int i = 0; i < count-1; i++)
    {
        int flag = 0;
        for(int j = 0; j < count-i-1; j++)
        {
            if(a[j] > a[j+1])
            {
                swap(&a[j+1],&a[j]);
                flag = 1;
            }
        }
        if(!flag)
        {
            break;
        }
    }
}

void quickSortIterative(int arr[], int l, int h)
{
    int stack[h - l + 1];
    int top = -1;
 
    stack[++top] = l;
    stack[++top] = h;
 
    while (top >= 0) 
    {
        h = stack[top--];
        l = stack[top--];
        int p = partition(arr, l, h);
        if (p - 1 > l) {
            stack[++top] = l;
            stack[++top] = p - 1;
        }
        if (p + 1 < h) {
            stack[++top] = p + 1;
            stack[++top] = h;
        }
    }
}

void integergenerator(int i)
{
    int num = i*10000;
    FILE *f1;
    if(i == 1)
        f1 = fopen("i10k.txt", "w");
    if(i == 2)
        f1 = fopen("i20k.txt", "w");
    if(i == 4)
        f1 = fopen("i40k.txt", "w");
    if(i == 8)
        f1 = fopen("i80k.txt", "w");
    if(i == 16)
        f1 = fopen("i160k.txt", "w");
    if(i == 32)
        f1 = fopen("i320k.txt", "w");
    if(i == 64)
        f1 = fopen("i640k.txt", "w");
    if(i == 128)
        f1 = fopen("i1280k.txt", "w");
    if(i == 256)
        f1 = fopen("i2560k.txt", "w");
    if(i == 512)
        f1 = fopen("i5120k.txt", "w");
    srand(time(0));
    for(int j = 0; j < num; j++)
    {
        fprintf(f1, "%d\n", rand()%1000000);
    }
    fclose(f1);
}

void dategenerator(int i)
{
    char monthfind[12][4] = {"Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"};
    int count = i*10000;
    FILE *f1;
    if(i == 1)
        f1 = fopen("d10k.txt", "w");
    if(i == 2)
        f1 = fopen("d20k.txt", "w");
    if(i == 4)
        f1 = fopen("d40k.txt", "w");
    if(i == 8)
        f1 = fopen("d80k.txt", "w");
    if(i == 16)
        f1 = fopen("d160k.txt", "w");
    if(i == 32)
        f1 = fopen("d320k.txt", "w");
    if(i == 64)
        f1 = fopen("d640k.txt", "w");
    if(i == 128)
        f1 = fopen("d1280k.txt", "w");
    if(i == 256)
        f1 = fopen("d2560k.txt", "w");
    if(i == 512)
        f1 = fopen("d5120k.txt", "w");
    for(int j = 0; j < count; j++)
    {
        int y_lower = 1947;
        int y_upper = 2023;
        int y = (rand()% (y_upper - y_lower + 1)) + y_lower;
        if(y == 2023)
        {
            int d1 = 0;
            int d2 = 1;
            fprintf(f1, "%d%d-%s-%d\n", d1,d2,monthfind[0],y);       
        }
        else if(y == 1947)
        {
            int m_lower = 8;
            int m_upper = 12;
            int d_lower = 1;
            int d_upper = 30;
            int m = (rand()% (m_upper - m_lower + 1)) + m_lower;
            if(m == 8) 
            {
                d_lower = 15;
            }
            int d = (rand()% (d_upper - d_lower + 1)) + d_lower;
            if(d < 10)
            {
                int d1 = 0;
                fprintf(f1, "%d%d-%s-%d\n", d1,d,monthfind[m-1],y);
            }
            else
            {
                fprintf(f1, "%d-%s-%d\n", d,monthfind[m-1],y);
            }
        }
        else
        {
            int m_lower = 1;
            int m_upper = 12;
            int d_lower = 1;
            int d_upper = 30;
            int m = (rand()% (m_upper - m_lower + 1)) + m_lower;
            if(m == 2) d_upper = 28;
            int d = (rand()% (d_upper - d_lower + 1)) + d_lower;
            if(d < 10)
            {
                int d1 = 0;
                fprintf(f1, "%d%d-%s-%d\n", d1,d,monthfind[m-1],y);
            }
            else
            {
                fprintf(f1, "%d-%s-%d\n", d,monthfind[m-1],y);
            }
        }
    }
    fclose(f1);
}

void datetimestampgenerator(int i)
{
    char monthfind[12][4] = {"Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"};
    int count = i*10000;
    FILE *f1;
    if(i == 1)
        f1 = fopen("dt10k.txt", "w");
    if(i == 2)
        f1 = fopen("dt20k.txt", "w");
    if(i == 4)
        f1 = fopen("dt40k.txt", "w");
    if(i == 8)
        f1 = fopen("dt80k.txt", "w");
    if(i == 16)
        f1 = fopen("dt160k.txt", "w");
    if(i == 32)
        f1 = fopen("dt320k.txt", "w");
    if(i == 64)
        f1 = fopen("dt640k.txt", "w");
    if(i == 128)
        f1 = fopen("dt1280k.txt", "w");
    if(i == 256)
        f1 = fopen("dt2560k.txt", "w");
    if(i == 512)
        f1 = fopen("dt5120k.txt", "w");
    for(int j = 0; j < count; j++)
    {
        int y_lower = 1947;
        int y_upper = 2023;
        int y = (rand()% (y_upper - y_lower + 1)) + y_lower;
        if(y == 2023)
        {
            int m = 1;
            int d_lower = 1;
            int d_upper = 9;    
            int d = (rand()% (d_upper - d_lower + 1)) + d_lower;
            int h_lower = 0;
            int h_upper = 23;
            int min_lower = 0;
            int min_upper = 59;
            int sec_lower = 0;
            int sec_upper = 59;
            int hour = (rand()% (h_upper - h_lower + 1)) + h_lower;
            int min = (rand()% (min_upper - min_lower + 1)) + min_lower;
            int sec = 0;
            if(d < 10)
            {
                int d1 =0;
                fprintf(f1, "%d%d-", d1,d);
            }
            else
            {
                fprintf(f1, "%d-", d);
            }
            fprintf(f1, "%s-", monthfind[m-1]);
            fprintf(f1,"%d ", y);
            if(hour == 0)
            {
                int d1 = 0;
                fprintf(f1, "%d%d:", d1,d1);
            }
            else if(hour < 10)
            {
                int d1 = 0;
                fprintf(f1, "%d%d:", d1,hour);
            }
            else
            {
                fprintf(f1, "%d:", hour);
            }
            if(min < 10)
            {
                int d1 = 0;
                fprintf(f1, "%d%d:", d1,min);
            }
            else
            {
                fprintf(f1, "%d:", min);
            }
            if(sec < 10)
            {
                int d1 = 0;
                fprintf(f1, "%d%d\n", d1,sec);
            }
            else
            {
                fprintf(f1, "%d\n", sec);
            }
        }
        else if(y == 1947)
        {
            int m_lower = 8;
            int m_upper = 12;
            int d_lower = 1;
            int d_upper = 30;
            int m = (rand()% (m_upper - m_lower + 1)) + m_lower;
            if(m == 8) d_lower = 15;
            int d = (rand()% (d_upper - d_lower + 1)) + d_lower;
            int h_lower = 0;
            int h_upper = 23;
            int min_lower = 0;
            int min_upper = 59;
            int sec_lower = 0;
            int sec_upper = 59;
            int hour = (rand()% (h_upper - h_lower + 1)) + h_lower;
            int min = (rand()% (min_upper - min_lower + 1)) + min_lower;
            int sec = (rand()% (sec_upper - sec_lower + 1)) + sec_lower;
            if(d < 10)
            {
                int d1 =0;
                fprintf(f1, "%d%d-", d1,d);
            }
            else
            {
                fprintf(f1, "%d-", d);
            }
            fprintf(f1, "%s-", monthfind[m-1]);
            fprintf(f1,"%d ", y);
            if(hour == 0)
            {
                int d1 = 0;
                fprintf(f1, "%d%d:", d1,d1);
            }
            else if(hour < 10)
            {
                int d1 = 0;
                fprintf(f1, "%d%d:", d1,hour);
            }
            else
            {
                fprintf(f1, "%d:", hour);
            }
            if(min < 10)
            {
                int d1 = 0;
                fprintf(f1, "%d%d:", d1,min);
            }
            else
            {
                fprintf(f1, "%d:", min);
            }
            if(sec < 10)
            {
                int d1 = 0;
                fprintf(f1, "%d%d\n", d1,sec);
            }
            else
            {
                fprintf(f1, "%d\n", sec);
            }
        }
        else
        {
            int m_lower = 1;
            int m_upper = 12;
            int d_lower = 1;
            int d_upper = 30;
            int m = (rand()% (m_upper - m_lower + 1)) + m_lower;
            if(m == 2) d_upper = 28;
            int d = (rand()% (d_upper - d_lower + 1)) + d_lower;
            int h_lower = 0;
            int h_upper = 23;
            int min_lower = 0;
            int min_upper = 59;
            int sec_lower = 0;
            int sec_upper = 59;
            int hour = (rand()% (h_upper - h_lower + 1)) + h_lower;
            int min = (rand()% (min_upper - min_lower + 1)) + min_lower;
            int sec = (rand()% (sec_upper - sec_lower + 1)) + sec_lower;
            if(d < 10)
            {
                int d1 =0;
                fprintf(f1, "%d%d-", d1,d);
            }
            else
            {
                fprintf(f1, "%d-", d);
            }
            fprintf(f1, "%s-", monthfind[m-1]);
            fprintf(f1,"%d ", y);
            if(hour == 0)
            {
                int d1 = 0;
                fprintf(f1, "%d%d:", d1,d1);
            }
            else if(hour < 10)
            {
                int d1 = 0;
                fprintf(f1, "%d%d:", d1,hour);
            }
            else
            {
                fprintf(f1, "%d:", hour);
            }
            if(min < 10)
            {
                int d1 = 0;
                fprintf(f1, "%d%d:", d1,min);
            }
            else
            {
                fprintf(f1, "%d:", min);
            }
            if(sec < 10)
            {
                int d1 = 0;
                fprintf(f1, "%d%d\n", d1,sec);
            }
            else
            {
                fprintf(f1, "%d\n", sec);
            }
        }
    }
    fclose(f1);
}

void sortintegers_quicksort()
{
    FILE *f3 = fopen("210101093-output.txt", "a");
    fprintf(f3, "               QUICK SORT\n");
    fprintf(f3, "               Only Sorting    Sorting and reading\n");
    for(int j = 1; j <= 512; j = j*2)
    {
        FILE *f1;
        if(j == 1)
            f1 = fopen("i10k.txt", "r");
        if(j == 2)
            f1 = fopen("i20k.txt", "r");
        if(j == 4)
            f1 = fopen("i40k.txt", "r");
        if(j == 8)
            f1 = fopen("i80k.txt", "r");
        if(j == 16)
            f1 = fopen("i160k.txt", "r");
        if(j == 32)
            f1 = fopen("i320k.txt", "r");
        if(j == 64)
            f1 = fopen("i640k.txt", "r");
        if(j == 128)
            f1 = fopen("i1280k.txt", "r");
        if(j == 256)
            f1 = fopen("i2560k.txt", "r");
        if(j == 512)
            f1 = fopen("i5120k.txt", "r");
        int count = j*10000;
        int *a = (int*)malloc(count * sizeof(int));
        for(int i = 0; i < count; i++)
        {
            int num;
            fscanf(f1, "%d", &num);
            a[i] = num;
        }
        FILE *f2;
        if(j == 1)
            f2 = fopen("qi10k.txt", "w");
        if(j == 2)
            f2 = fopen("qi20k.txt", "w");
        if(j == 4)
            f2 = fopen("qi40k.txt", "w");
        if(j == 8)
            f2 = fopen("qi80k.txt", "w");
        if(j == 16)
            f2 = fopen("qi160k.txt", "w");
        if(j == 32)
            f2 = fopen("qi320k.txt", "w");
        if(j == 64)
            f2 = fopen("qi640k.txt", "w");
        if(j == 128)
            f2 = fopen("qi1280k.txt", "w");
        if(j == 256)
            f2 = fopen("qi2560k.txt", "w");
        if(j == 512)
            f2 = fopen("qi5120k.txt", "w");
        time_t start_time = clock();
        quick_sort(a,0,count-1);
        time_t end_time = clock();
        for(int i = 0; i < count; i++)
        {
            fprintf(f2, "%d\n", a[i]);
        }
        time_t reading = clock();
        time_t full_time = reading - start_time;
        time_t time_taken = end_time - start_time;       
        fprintf(f3, "Integers %d %ld            %ld\n", count, time_taken, full_time);
        fclose(f1);
        fclose(f2);
        free(a);
    }
    fprintf(f3, "\n");
    fclose(f3);
}

void sortintegers_bubblesort()
{
    FILE *f3 = fopen("210101093-output.txt", "a");
    fprintf(f3, "               BUBBLE SORT\n");
    fprintf(f3, "               Only Sorting    Sorting and reading\n");
    for(int j = 1; j <= 512; j = j*2)
    {
        FILE *f1;
        if(j == 1)
            f1 = fopen("i10k.txt", "r");
        if(j == 2)
            f1 = fopen("i20k.txt", "r");
        if(j == 4)
            f1 = fopen("i40k.txt", "r");
        if(j == 8)
            f1 = fopen("i80k.txt", "r");
        if(j == 16)
            f1 = fopen("i160k.txt", "r");
        if(j == 32)
            f1 = fopen("i320k.txt", "r");
        if(j == 64)
            f1 = fopen("i640k.txt", "r");
        if(j == 128)
            f1 = fopen("i1280k.txt", "r");
        if(j == 256)
            f1 = fopen("i2560k.txt", "r");
        if(j == 512)
            f1 = fopen("i5120k.txt", "r");
        int count = j*10000;
        int * a = (int*)malloc(count * sizeof(int));
        for(int i = 0; i < count; i++)
        {
            int num;
            fscanf(f1, "%d", &num);
            a[i] = num;
        }
        FILE *f2;
        if(j == 1)
            f2 = fopen("bi10k.txt", "w");
        if(j == 2)
            f2 = fopen("bi20k.txt", "w");
        if(j == 4)
            f2 = fopen("bi40k.txt", "w");
        if(j == 8)
            f2 = fopen("bi80k.txt", "w");
        if(j == 16)
            f2 = fopen("bi160k.txt", "w");
        if(j == 32)
            f2 = fopen("bi320k.txt", "w");
        if(j == 64)
            f2 = fopen("bi640k.txt", "w");
        if(j == 128)
            f2 = fopen("bi1280k.txt", "w");
        if(j == 256)
            f2 = fopen("bi2560k.txt", "w");
        if(j == 512)
            f2 = fopen("bi5120k.txt", "w");
        time_t start_time = clock();
        bubblesort(a,count);
        time_t end_time = clock();
        for(int i = 0; i < count; i++)
        {
            fprintf(f2, "%d\n", a[i]);
        }
        time_t reading = clock();
        time_t full_time = reading - start_time;
        time_t time_taken = end_time - start_time;       
        fprintf(f3, "Integers %d %ld            %ld\n", count, time_taken, full_time);
        fclose(f1);
        fclose(f2);
        free(a);
    }
    fclose(f3);
}

void sort_date_quicksort()
{
    for(int j = 1; j <= 512; j = j*2)
    {
        FILE *f3 = fopen("210101093-output.txt", "a");
        FILE *f1;
        if(j == 1)
            f1 = fopen("d10k.txt", "r");
        if(j == 2)
            f1 = fopen("d20k.txt", "r");
        if(j == 4)
            f1 = fopen("d40k.txt", "r");
        if(j == 8)
            f1 = fopen("d80k.txt", "r");
        if(j == 16)
            f1 = fopen("d160k.txt", "r");
        if(j == 32)
            f1 = fopen("d320k.txt", "r");
        if(j == 64)
            f1 = fopen("d640k.txt", "r");
        if(j == 128)
            f1 = fopen("d1280k.txt", "r");
        if(j == 256)
            f1 = fopen("d2560k.txt", "r");
        if(j == 512)
            f1 = fopen("d5120k.txt", "r");
        int count = j*10000;
        FILE *f2;
        if(j == 1)
            f2 = fopen("qd10k.txt", "w");
        if(j == 2)
            f2 = fopen("qd20k.txt", "w");
        if(j == 4)
            f2 = fopen("qd40k.txt", "w");
        if(j == 8)
            f2 = fopen("qd80k.txt", "w");
        if(j == 16)
            f2 = fopen("qd160k.txt", "w");
        if(j == 32)
            f2 = fopen("qd320k.txt", "w");
        if(j == 64)
            f2 = fopen("qd640k.txt", "w");
        if(j == 128)
            f2 = fopen("qd1280k.txt", "w");
        if(j == 256)
            f2 = fopen("qd2560k.txt", "w");
        if(j == 512)
            f2 = fopen("qd5120k.txt", "w");
        int *a = (int*)malloc(count * sizeof(int));
        for(int j = 0; j < count; j++)
        {
            char input[100];
            char date[100];
            char mo[100];
            char yea[100];
            fscanf(f1, "%s", input );

            date[0] = input[0];
            date[1] = input[1];
            date[2] = '\0';
            mo[0] = input[3];
            mo[1] = input[4];
            mo[2] = input[5];
            mo[3] = '\0';
            yea[0] = input[7];
            yea[1] = input[8];
            yea[2] = input[9];
            yea[3] = input[10];
            yea[4] = '\0';

            char mon[100];
            if(strcmp(mo,"Jan")==0) 
            {
                strcpy(mon,"01");           
            }
            else if(strcmp(mo,"Feb")==0) 
            {
                strcpy(mon,"02");
            }
            else if(strcmp(mo,"Mar")==0) 
            {
                strcpy(mon,"03"); 
            }
            else if(strcmp(mo, "Apr")==0)
            {
                strcpy(mon,"04"); 
            }
            else if(strcmp(mo , "May") ==0)
            {
                strcpy(mon, "05") ;
            }
            else if(strcmp(mo,"Jun")==0 )
            {
                strcpy(mon, "06") ;
            } 
            else if(strcmp(mo ,"Jul")==0) 
            {
                strcpy(mon, "07") ; 
            }
            else if(strcmp(mo ,"Aug") ==0)
            {
                strcpy(mon, "08") ;
            }
            else if(strcmp(mo ,"Sep")==0 )
            {
                strcpy(mon, "08") ;
            }
            else if(strcmp(mo ,"Oct") ==0) 
            {
                strcpy(mon, "10") ;
            }
            else if(strcmp(mo ,"Nov") ==0) 
            {
                strcpy(mon, "11") ;
            }
            else if(strcmp(mo ,"Dec") ==0)
            {
                strcpy(mon, "12") ;
            }
            strcat(mon,date);
            strcat(yea, mon);
            int fi = atoi(yea);
            a[j] = fi;
        }
        time_t start_time = clock();
        quick_sort(a,0,count-1);
        time_t end_time = clock();
        for(int j = 0; j < count; j++)
        {
            int date = a[j]%100;
            int mon = (a[j]%10000)/100;
            char mo[4];
            if( mon == 1) strcpy(mo,"Jan");
            if( mon == 2) strcpy(mo,"Feb");
            if( mon == 3) strcpy(mo,"Mar");
            if( mon == 4) strcpy(mo,"Apr");
            if( mon == 5) strcpy(mo,"May");
            if( mon == 6) strcpy(mo,"Jun");
            if( mon == 7) strcpy(mo,"Jul");
            if( mon == 8) strcpy(mo,"Aug");
            if( mon == 9) strcpy(mo,"Sep");
            if( mon == 10) strcpy(mo,"Oct");
            if( mon == 11) strcpy(mo,"Nov");
            if( mon == 12) strcpy(mo,"Dec");
            int ye = a[j]/10000;
            if(date < 10)
                fprintf(f2, "0%d-%s-%d\n", date, mo, ye);
            else
                fprintf(f2, "%d-%s-%d\n", date, mo, ye);
        }
        time_t reading = clock();
        time_t full_time = reading - start_time;
        time_t time_taken = end_time - start_time;       
        fprintf(f3, "Date %d %ld            %ld\n", count, time_taken, full_time);
        fclose(f1);
        fclose(f2);
        free(a);
        fclose(f3);
    }   
    FILE *f3 = fopen("210101093-output.txt", "a");
    fprintf(f3, "\n");
    fclose(f3);
}

void sort_date_bubblesort()
{
    for(int j = 1; j <= 128; j = j*2)
    {
        FILE *f3 = fopen("210101093-output.txt", "a");
        FILE *f1;
        if(j == 1)
            f1 = fopen("d10k.txt", "r");
        if(j == 2)
            f1 = fopen("d20k.txt", "r");
        if(j == 4)
            f1 = fopen("d40k.txt", "r");
        if(j == 8)
            f1 = fopen("d80k.txt", "r");
        if(j == 16)
            f1 = fopen("d160k.txt", "r");
        if(j == 32)
            f1 = fopen("d320k.txt", "r");
        if(j == 64)
            f1 = fopen("d640k.txt", "r");
        if(j == 128)
            f1 = fopen("d1280k.txt", "r");
        if(j == 256)
            f1 = fopen("d2560k.txt", "r");
        if(j == 512)
            f1 = fopen("d5120k.txt", "r");
        int count = j*10000;
        FILE *f2;
        if(j == 1)
            f2 = fopen("bd10k.txt", "w");
        if(j == 2)
            f2 = fopen("bd20k.txt", "w");
        if(j == 4)
            f2 = fopen("bd40k.txt", "w");
        if(j == 8)
            f2 = fopen("bd80k.txt", "w");
        if(j == 16)
            f2 = fopen("bd160k.txt", "w");
        if(j == 32)
            f2 = fopen("bd320k.txt", "w");
        if(j == 64)
            f2 = fopen("bd640k.txt", "w");
        if(j == 128)
            f2 = fopen("bd1280k.txt", "w");
        if(j == 256)
            f2 = fopen("bd2560k.txt", "w");
        if(j == 512)
            f2 = fopen("bd5120k.txt", "w");
        int *a = (int*)malloc(count * sizeof(int));
        for(int j = 0; j < count; j++)
        {
            char input[100];
            char date[100];
            char mo[100];
            char yea[100];
            fscanf(f1, "%s", input );

            date[0] = input[0];
            date[1] = input[1];
            date[2] = '\0';
            mo[0] = input[3];
            mo[1] = input[4];
            mo[2] = input[5];
            mo[3] = '\0';
            yea[0] = input[7];
            yea[1] = input[8];
            yea[2] = input[9];
            yea[3] = input[10];
            yea[4] = '\0';

            char mon[100];
            if(strcmp(mo,"Jan")==0) 
            {
                strcpy(mon,"01");
            
            }
            else if(strcmp(mo,"Feb")==0) 
            {
                strcpy(mon,"02");
            }
            else if(strcmp(mo,"Mar")==0) 
            {
                strcpy(mon,"03"); 
            }
            else if(strcmp(mo, "Apr")==0)
            {
                strcpy(mon,"04"); 
            }
            else if(strcmp(mo , "May") ==0)
            {
                strcpy(mon, "05") ;
            }
            else if(strcmp(mo,"Jun")==0 )
            {
                strcpy(mon, "06") ;
            } 
            else if(strcmp(mo ,"Jul")==0) 
            {
                strcpy(mon, "07") ; 
            }
            else if(strcmp(mo ,"Aug") ==0)
            {
                strcpy(mon, "08") ;
            }
            else if(strcmp(mo ,"Sep")==0 )
            {
                strcpy(mon, "08") ;
            }
            else if(strcmp(mo ,"Oct") ==0) 
            {
                strcpy(mon, "10") ;
            }
            else if(strcmp(mo ,"Nov") ==0) 
            {
                strcpy(mon, "11") ;
            }
            else if(strcmp(mo ,"Dec") ==0)
            {
                strcpy(mon, "12") ;
            }
            strcat(mon,date);
            strcat(yea, mon);
            int fi = atoi(yea);
            a[j] = fi;
        }
        time_t start_time = clock();
        bubblesort(a,count);
        time_t end_time = clock();
        for(int j = 0; j < count; j++)
        {
            int date = a[j]%100;
            int mon = (a[j]%10000)/100;
            char mo[4];
            if( mon == 1) strcpy(mo,"Jan");
            if( mon == 2) strcpy(mo,"Feb");
            if( mon == 3) strcpy(mo,"Mar");
            if( mon == 4) strcpy(mo,"Apr");
            if( mon == 5) strcpy(mo,"May");
            if( mon == 6) strcpy(mo,"Jun");
            if( mon == 7) strcpy(mo,"Jul");
            if( mon == 8) strcpy(mo,"Aug");
            if( mon == 9) strcpy(mo,"Sep");
            if( mon == 10) strcpy(mo,"Oct");
            if( mon == 11) strcpy(mo,"Nov");
            if( mon == 12) strcpy(mo,"Dec");
            int ye = a[j]/10000;

            fprintf(f2, "%d-%s-%d\n", date, mo, ye);
        }
        time_t reading = clock();
        time_t full_time = reading - start_time;
        time_t time_taken = end_time - start_time;       
        fprintf(f3, "Date %d %ld            %ld\n", count, time_taken, full_time);
        fclose(f1);
        fclose(f2);
        free(a);
        fclose(f3);
    }  
    FILE *f3 = fopen("210101093-output.txt", "a");
    fprintf(f3, "\n");
    fclose(f3);
}

void sort_datetime_quicksort()
{
    for(int j = 1; j <= 512; j = j*2)
    {
        FILE *f3 = fopen("210101093-output.txt", "a");
        FILE *f1;
        if(j == 1)
            f1 = fopen("dt10k.txt", "r");
        if(j == 2)
            f1 = fopen("dt20k.txt", "r");
        if(j == 4)
            f1 = fopen("dt40k.txt", "r");
        if(j == 8)
            f1 = fopen("dt80k.txt", "r");
        if(j == 16)
            f1 = fopen("dt160k.txt", "r");
        if(j == 32)
            f1 = fopen("dt320k.txt", "r");
        if(j == 64)
            f1 = fopen("dt640k.txt", "r");
        if(j == 128)
            f1 = fopen("dt1280k.txt", "r");
        if(j == 256)
            f1 = fopen("dt2560k.txt", "r");
        if(j == 512)
            f1 = fopen("dt5120k.txt", "r");
        int count = j*10000;
        FILE *f2;
        if(j == 1)
            f2 = fopen("qdt10k.txt", "w");
        if(j == 2)
            f2 = fopen("qdt20k.txt", "w");
        if(j == 4)
            f2 = fopen("qdt40k.txt", "w");
        if(j == 8)
            f2 = fopen("qdt80k.txt", "w");
        if(j == 16)
            f2 = fopen("qdt160k.txt", "w");
        if(j == 32)
            f2 = fopen("qdt320k.txt", "w");
        if(j == 64)
            f2 = fopen("qdt640k.txt", "w");
        if(j == 128)
            f2 = fopen("qdt1280k.txt", "w");
        if(j == 256)
            f2 = fopen("qdt2560k.txt", "w");
        if(j == 512)
            f2 = fopen("qdt5120k.txt", "w");
        struct dts * a = malloc(count * sizeof(struct dts));
        FILE *f10 = fopen("trying.txt", "w");
        for(int j = 0; j < count; j++)
        {
            char input[100];
            char da[100];
            char mo[100];
            char yea[100];
            char input1[100];
            fscanf(f1, "%s", input );
            fscanf(f1, "%s", input1);
            da[0] = input[0];
            da[1] = input[1];
            da[2] = '\0';
            mo[0] = input[3];
            mo[1] = input[4];
            mo[2] = input[5];
            mo[3] = '\0';
            yea[0] = input[7];
            yea[1] = input[8];
            yea[2] = input[9];
            yea[3] = input[10];
            yea[4] = '\0';

            a[j].hour[0] = input1[0];
            a[j].hour[1] = input1[1];
            a[j].hour[2] = '\0';

            a[j].min[0] = input1[3];
            a[j].min[1] = input1[4];
            a[j].min[2] = '\0';

            a[j].sec[0] = input1[6];
            a[j].sec[1] = input1[7];
            a[j].sec[2] = '\0';

            char mon[100];
            if(strcmp(mo,"Jan")==0) 
            {
                strcpy(mon,"01");          
            }
            else if(strcmp(mo,"Feb")==0) 
            {
                strcpy(mon,"02");
            }
            else if(strcmp(mo,"Mar")==0) 
            {
                strcpy(mon,"03"); 
            }
            else if(strcmp(mo, "Apr")==0)
            {
                strcpy(mon,"04"); 
            }
            else if(strcmp(mo , "May") ==0)
            {
                strcpy(mon, "05") ;
            }
            else if(strcmp(mo,"Jun")==0 )
            {
                strcpy(mon, "06") ;
            } 
            else if(strcmp(mo ,"Jul")==0) 
            {
                strcpy(mon, "07") ; 
            }
            else if(strcmp(mo ,"Aug") ==0)
            {
                strcpy(mon, "08") ;
            }
            else if(strcmp(mo ,"Sep")==0 )
            {
                strcpy(mon, "08") ;
            }
            else if(strcmp(mo ,"Oct") ==0) 
            {
                strcpy(mon, "10") ;
            }
            else if(strcmp(mo ,"Nov") ==0) 
            {
                strcpy(mon, "11") ;
            }
            else if(strcmp(mo ,"Dec") ==0)
            {
                strcpy(mon, "12") ;
            }
            strcat(mon,da);
            strcat(yea,mon);
            int dat = atoi(yea);
            a[j].date = dat;
        }
        time_t start_time = clock();
        quick_sort_time(a,0,count-1);
        time_t end_time = clock();
        for(int j = 0; j < count; j++)
        {
            int date = a[j].date%100;
            int mon = (a[j].date%10000)/100;
            char mo[4];
            if( mon == 1) strcpy(mo,"Jan");
            if( mon == 2) strcpy(mo,"Feb");
            if( mon == 3) strcpy(mo,"Mar");
            if( mon == 4) strcpy(mo,"Apr");
            if( mon == 5) strcpy(mo,"May");
            if( mon == 6) strcpy(mo,"Jun");
            if( mon == 7) strcpy(mo,"Jul");
            if( mon == 8) strcpy(mo,"Aug");
            if( mon == 9) strcpy(mo,"Sep");
            if( mon == 10) strcpy(mo,"Oct");
            if( mon == 11) strcpy(mo,"Nov");
            if( mon == 12) strcpy(mo,"Dec");
            int ye = a[j].date/10000;
            if(date < 10)
                fprintf(f2, "0%d-%s-%d %s:%s:%s\n", date, mo, ye, a[j].hour, a[j].min, a[j].sec);
            else
                fprintf(f2, "%d-%s-%d %s:%s:%s\n", date, mo, ye, a[j].hour, a[j].min, a[j].sec);
        }
        time_t reading = clock();
        time_t full_time = reading - start_time;
        time_t time_taken = end_time - start_time;       
        fprintf(f3, "Date & Time %d %ld            %ld\n", count, time_taken, full_time);
        fclose(f1);
        fclose(f2);
        free(a);
        fclose(f3);
    }   
    FILE *f3 = fopen("210101093-output.txt", "a");
    fprintf(f3, "\n");
    fclose(f3);
}

void sort_datetime_bubblesort()
{
    for(int j = 1; j <= 1; j = j*2)
    {
        FILE *f3 = fopen("210101093-output.txt", "a");
        FILE *f1;
        if(j == 1)
            f1 = fopen("dt10k.txt", "r");
        if(j == 2)
            f1 = fopen("dt20k.txt", "r");
        if(j == 4)
            f1 = fopen("dt40k.txt", "r");
        if(j == 8)
            f1 = fopen("dt80k.txt", "r");
        if(j == 16)
            f1 = fopen("dt160k.txt", "r");
        if(j == 32)
            f1 = fopen("dt320k.txt", "r");
        if(j == 64)
            f1 = fopen("dt640k.txt", "r");
        if(j == 128)
            f1 = fopen("dt1280k.txt", "r");
        if(j == 256)
            f1 = fopen("dt2560k.txt", "r");
        if(j == 512)
            f1 = fopen("dt5120k.txt", "r");
        int count = j*10000;
        FILE *f2;
        if(j == 1)
            f2 = fopen("bdt10k.txt", "w");
        if(j == 2)
            f2 = fopen("bdt20k.txt", "w");
        if(j == 4)
            f2 = fopen("bdt40k.txt", "w");
        if(j == 8)
            f2 = fopen("bdt80k.txt", "w");
        if(j == 16)
            f2 = fopen("bdt160k.txt", "w");
        if(j == 32)
            f2 = fopen("bdt320k.txt", "w");
        if(j == 64)
            f2 = fopen("bdt640k.txt", "w");
        if(j == 128)
            f2 = fopen("bdt1280k.txt", "w");
        if(j == 256)
            f2 = fopen("bdt2560k.txt", "w");
        if(j == 512)
            f2 = fopen("bdt5120k.txt", "w");
        struct dts * a = malloc(count * sizeof(struct dts));
        for(int j = 0; j < count; j++)
        {
            char input[100];
            char da[100];
            char mo[100];
            char yea[100];
            char input1[100];
            fscanf(f1, "%s", input );
            fscanf(f1, "%s", input1);
            da[0] = input[0];
            da[1] = input[1];
            da[2] = '\0';
            mo[0] = input[3];
            mo[1] = input[4];
            mo[2] = input[5];
            mo[3] = '\0';
            yea[0] = input[7];
            yea[1] = input[8];
            yea[2] = input[9];
            yea[3] = input[10];
            yea[4] = '\0';

            a[j].hour[0] = input1[0];
            a[j].hour[1] = input1[1];
            a[j].hour[2] = '\0';

            a[j].min[0] = input1[3];
            a[j].min[1] = input1[4];
            a[j].min[2] = '\0';

            a[j].sec[0] = input1[6];
            a[j].sec[1] = input1[7];
            a[j].sec[2] = '\0';

            char mon[100];
            if(strcmp(mo,"Jan")==0) 
            {
                strcpy(mon,"01");          
            }
            else if(strcmp(mo,"Feb")==0) 
            {
                strcpy(mon,"02");
            }
            else if(strcmp(mo,"Mar")==0) 
            {
                strcpy(mon,"03"); 
            }
            else if(strcmp(mo, "Apr")==0)
            {
                strcpy(mon,"04"); 
            }
            else if(strcmp(mo , "May") ==0)
            {
                strcpy(mon, "05") ;
            }
            else if(strcmp(mo,"Jun")==0 )
            {
                strcpy(mon, "06") ;
            } 
            else if(strcmp(mo ,"Jul")==0) 
            {
                strcpy(mon, "07") ; 
            }
            else if(strcmp(mo ,"Aug") ==0)
            {
                strcpy(mon, "08") ;
            }
            else if(strcmp(mo ,"Sep")==0 )
            {
                strcpy(mon, "08") ;
            }
            else if(strcmp(mo ,"Oct") ==0) 
            {
                strcpy(mon, "10") ;
            }
            else if(strcmp(mo ,"Nov") ==0) 
            {
                strcpy(mon, "11") ;
            }
            else if(strcmp(mo ,"Dec") ==0)
            {
                strcpy(mon, "12") ;
            }
            strcat(mon,da);
            strcat(yea,mon);
            int dat = atoi(yea);
            a[j].date = dat;
        }
        time_t start_time = clock();
        bubblesort_time(a,count);
        time_t end_time = clock();
        for(int j = 0; j < count; j++)
        {
            int date = a[j].date%100;
            int mon = (a[j].date%10000)/100;
            char mo[4];
            if( mon == 1) strcpy(mo,"Jan");
            if( mon == 2) strcpy(mo,"Feb");
            if( mon == 3) strcpy(mo,"Mar");
            if( mon == 4) strcpy(mo,"Apr");
            if( mon == 5) strcpy(mo,"May");
            if( mon == 6) strcpy(mo,"Jun");
            if( mon == 7) strcpy(mo,"Jul");
            if( mon == 8) strcpy(mo,"Aug");
            if( mon == 9) strcpy(mo,"Sep");
            if( mon == 10) strcpy(mo,"Oct");
            if( mon == 11) strcpy(mo,"Nov");
            if( mon == 12) strcpy(mo,"Dec");
            int ye = a[j].date/10000;
            if(date < 10)
                fprintf(f2, "0%d-%s-%d %s:%s:%s\n", date, mo, ye, a[j].hour, a[j].min, a[j].sec);
            else
                fprintf(f2, "%d-%s-%d %s:%s:%s\n", date, mo, ye, a[j].hour, a[j].min, a[j].sec);
        }
        time_t reading = clock();
        time_t full_time = reading - start_time;
        time_t time_taken = end_time - start_time;       
        fprintf(f3, "Date & Time %d %ld            %ld\n", count, time_taken, full_time);
        fclose(f1);
        fclose(f2);
        free(a);
        fclose(f3);
    }   
    FILE *f3 = fopen("210101093-output.txt", "a");
    fprintf(f3, "\n");
    fclose(f3);
}

void printRandoms(int lower, int upper, int count)
{
    int i;
    for (i = 0; i < count; i++) 
    {
        int num = (rand() %(upper - lower + 1)) + lower;
        printf("%d ", num);
    }
}

int main()
{
    for(int j = 1; j <= 512; j = j*2)
    {
        integergenerator(j);
    }
    for(int j = 1; j <= 512; j = j*2)
    {
        dategenerator(j);
    }
    for(int j = 1; j <= 512; j = j*2)
    {
        datetimestampgenerator(j);
    }
    sortintegers_quicksort();
    sort_date_quicksort();
    sort_datetime_quicksort();
    sortintegers_bubblesort();
    sort_date_bubblesort();
    sort_datetime_bubblesort();
}
