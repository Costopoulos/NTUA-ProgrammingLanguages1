#include <iostream> 
#include <fstream>
using namespace std; 


// function to convert decimal to binary 
void decToBinary(int n, int k){ 
    int a[32]; 
    int sum=0;
    int d;
    int i=0; 
    
    while (n>0){
        a[i]=n%2; 
        sum+=a[i];
        n/=2; 
        i++; 
    } 

    if(sum>k) cout<<"[]"<<endl;
    else if(sum==k){
        d=i;
        while(a[i-1]==0){
            d--;
            i--;	
        }
        cout<<"[";
        for(int j=0; j<d-1; j++) cout<<a[j]<<",";	
        cout<<a[d-1]<<"]"<<endl;
    }
    else{
        int j=1;
        while(sum!=k){
            if(a[j]!=0){
                a[j]--;
                a[j-1]+=2;
                j=1;
                sum++;
            }
        	else j++;
        }
        d=i;
        while(a[i-1]==0){
            d--;
            i--;	
        }
        cout<<"[";
        for(int j=0; j<d-1;j++) cout<<a[j]<<",";	
        cout<<a[d-1]<<"]"<<endl;

    }
}
  
// Driver program to test above function 
int main(int argc, char *argv[]){ 
    int T, B[20], j=0;
    ifstream myfile;
    myfile.open(argv[1]);
    myfile >> T;
    
    for (int i=0;i<2*T;i++) myfile>>B[i];
    
    for (int i=0;i<T;i++){
        decToBinary(B[j],B[j+1]);
        j+=2;
    }
    myfile.close();
    return 0;
}