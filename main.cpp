#include <bits/stdc++.h>
#include <time.h>
using namespace std;

vector< pair<int,int> > a;

void quicksort( int left, int right)
{
    int mid = (left+right)/2;


    int i = left;
    int j = right;
    int pivot = a[mid].second;

    while(left<j || i<right)
    {
        while(a[i].second<pivot)
            i++;
        while(a[j].second>pivot)
            j--;

        if(i<=j)
        {
            swap(a[i],a[j]);
            i++;
            j--;
        }
        else
        {
            if(left<j)
                quicksort(left, j);
            if(i<right)
                quicksort(i,right);
            return;
        }
    }
}

int main()
{
//    freopen("input.txt", "r", stdin);
//    freopen("output_analysis.txt", "w", stdout);
//    srand(time(NULL));
    int n;
//    printf("Size\t\t\t\tTime\n");
//    clock_t t1, t2;
//    while(scanf("%d", &n) != EOF)
//    {
    scanf("%d", &n);
        for(int i=0; i<n; i++) {
            int x,y;
//            x=rand()%1000;
//            y=rand()%1000;
//            if(x>y)
//                swap(x,y);
            pair<int ,int > p;
            p.first=x;
            p.second=y;
            scanf("%d%d", &p.first, &p.second);
            a.push_back(p);
        }
        //t1 = clock();
        quicksort(0,n-1);
//        cout<<"After Sortin"<<endl;
//        for(int i=0; i<n; i++)
//            cout<<a[i].first<< " "<<a[i].second<<endl;
//        cout<<endl;
//
//        cout<<"Possible tasks: "<<endl;
        int strt=0;
        for(int i=0; i<n; i++) {
            if(a[i].first>strt) {

                cout<<a[i].first<< " "<<a[i].second<<endl;
                strt=a[i].second;
            }

        }
//        t2 = clock();
//        t2 = t2 - t1;
//        //printf("%d\t\t\t\t%f\n", n, ((float)t2/CLOCKS_PER_SEC));
//        printf("%f\n", ((float)t2/CLOCKS_PER_SEC));
//    }
}


