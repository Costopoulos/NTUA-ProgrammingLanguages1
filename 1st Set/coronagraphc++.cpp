#include<bits/stdc++.h> 
#include <iostream>
#include <fstream>
#include <algorithm> 
#include <stdio.h>

using namespace std; 

void addEdge(vector<int> adj[], int u, int v)    
{ 
    adj[u].push_back(v); 
    adj[v].push_back(u); 
} 

bool circle1 =  false;
bool circle2 = false;
int length = 0;
int c1 = 1;
int counter = 0;
int cir[1000000];

int Count (int u, bool cc[], bool vv[], int pp[],  vector<int> adj[] ) {
    
    


    vv[u] = true;
    for (auto x : adj[u]) {
    	if(!cc[x]) {
        
    		if(!vv[x] && !cc[x]) {
                pp[x] = u;
                c1 ++;
                Count (x, cc, vv, pp, adj);	
            }
            else if ( (circle2 == false) &&  (x != pp[u]) ) {

                
                circle2 = true;
                c1 = 0;
                return 0;	
           }
    }
}
return c1;	
}
        
    
  

 void MakeCircle (int a, int b, int parent[], vector<int> adj[] ) {
    while (a!=b) {

        cir[length] = a;
        a = parent[a];	
        length++;
    }
    cir[length] = a;
}


void Cyclic (int v, bool visited[], int parent[], vector<int> adj[] ) {

    visited[v] = true;
    for (auto x : adj[v]) { 
    	
        if(!visited[x]) {
            parent[x] = v;
            Cyclic (x, visited, parent, adj);	
        }
        else if ( (circle1 == false) &&  x != parent[v] ) {
                counter++;
                circle1 = true;
                MakeCircle(v, x, parent, adj);	
           }
    }

}
 


int main(int argc, char *argv[]) 
{   
int j=0,T,N,M,k,l,s=0, ss=0;

   ifstream myfile;
    myfile.open(argv[1]);
    
         myfile >> T;

        for (int m = 0; m <  T; m++) {
        
            myfile >> N;
            myfile >> M;
        vector<int> adj[N+1];
        for (j= 0; j < M ; j++){
        myfile>>k;

        myfile>>l;

       	addEdge(adj,k, l);
    }


bool visited[N+1] = {false};
bool cycle[N+1] = {false};
bool visited2[N+1] = {false}; 
int parent[N+1],  parent2[N+1],  out=1;
 

 
 for( int i=0; i< N+1; i++) {

    parent[i] = 0;
    parent2[i]= 0;
    
    }
      


  
  Cyclic (1, visited, parent, adj);
 	
 	

if( counter == 0) {

 	printf("NO CORONA\n");

}
else {

    
    int output[length+1];
 	
 	for(int i=0; i<length+1; i++) {
     cycle[cir[i]] = true;
}

    for(int i=0; i<length+1; i++) {

      out = Count(cir[i], cycle, visited2, parent2, adj);
      if ( out==0) break;	
      else 
      	if (i==0) {
      
      		output[i]=out;
      		s=out;
      	}
      	else
        	{
                
            output[i]= out- s +1 ;
      		s = out;
   			 }

}


 if( out == 0 )
    printf("NO CORONA\n");
 
 else
 {
 
 	 for( int i=0; i<(length+1); i++){
 	ss = output[i] +ss;
}

 if (ss == N) {
    printf("CORONA %d\n", length+1);
    sort(output, output + (length+1));
    for(int i=0; i<length; i++){
    	printf("%d ", output[i]);
       }
    	printf("%d\n", output[length] );
   }
else 
    printf("NO CORONA\n");
  }
} 

 circle1 =  false;
 circle2 = false;
 length = 0;
 c1 = 1;
 counter=0;
 ss = 0;
 out=1;
}

myfile.close();
    return 0; 
}