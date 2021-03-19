//package File;
import java.util.*; 
import java.io.*;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;

public class StayHome {
static ArrayList<Character> input;
static ArrayList<Integer> X;
static ArrayList<Integer> A;
static int M,N,S,W,T,z, size;
static int[] vir;
static int[] visited;
static char[] path;

public static void main(String[] args) {
    try {
      File f=new File(args[0]);
      FileReader fr=new FileReader(f);   //Creation of File Reader object
      BufferedReader br=new BufferedReader(fr);  //Creation of BufferedReader object
      int c = 0;
      
      
      input = new ArrayList<Character>();
      X = new ArrayList<Integer>();
      A = new ArrayList<Integer>();
      while ((c = br.read()) != -1) {
            char character = (char) c;
            input.add(character);
        }
      br.close();
       size = input.size(); 
      for(int i =0; i<size; i++){
          if(input.get(i)=='\n'){ 
              M=i;
              break;
          }
      }
      N=0;
        
      vir = new int[size];
      path = new char[size];
      visited = new int[size];	
     
     for(int i =0; i<size; i++){
        vir[i]=0;
        path[i]='N';
        visited[i]=0;
        if(input.get(i)=='S')
            S=i;
        if(input.get(i)=='X')
            X.add(i);
        if(input.get(i)=='W')
            W=i;
        if(input.get(i)=='A')
            A.add(i);
        if(input.get(i)=='T')
            T=i;
        if(input.get(i)=='\n')
            N++;
      }
      N=N;
     
      move_virus(W,0);

      int n=1;
      ArrayList<Integer> listd = new ArrayList<Integer>();
      listd.add(S);
      
      while(!listd.isEmpty()){
          ArrayList<Integer> listdtemp = listd;
          listd = new ArrayList<Integer>();
           int[] L = new int[4];
           char[] D = {'D', 'L', 'R', 'U'};
           for(int kk = 0; kk < listdtemp.size(); kk++) {
                                int x = listdtemp.get(kk);
                                L[0] = move_down(x);
                                L[1] = move_left(x);
                                L[2] = move_right(x);
                                L[3] = move_up(x);
                                for(int i = 0; i<4; i++) {
                                        if(L[i] != -1) {
                                                if(visited[L[i]] == 0 && n<vir[L[i]]) {
                                                        visited[L[i]] = n;
                                                        visited[S]=-1;
                                                        path[L[i]] = D[i];
                                                        listd.add(L[i]);
                                                }
                                        }
                                }
                        }
                        n += 1;
                }

      if(visited[T] == 0)
                        System.out.println("IMPOSSIBLE");
                else{
                        System.out.println(visited[T]);
                        String way = "";
                        int x = T;
                        while(x != S) {
                                way = path[x] + way;
                                if(path[x] == 'D')
                                        x = x - M-1;
                                else if(path[x] == 'L')
                                        x = x + 1;
                                else if(path[x] == 'R')
                                        x = x - 1;
                                else if(path[x] == 'U')
                                        x = x + M+1;

                        }
                        System.out.println(way);
                } 
    }
     catch (IOException  e) {
      System.out.println("An error occurred.");
      e.printStackTrace();
      
    }
  }
  
  
  static int move_up(int x){
            if (x-(M+1)>=0)
                if((x-(M+1)>=0) && (input.get(x)!='X') && (input.get(x)!='\n') && (input.get(x-M-1)!='X') && (input.get(x-M-1)!='W') ) 
                    return x-(M+1);
                else
                    return -1;
            else
                return -1;
      }	
      static int move_down(int x){
            if (x+(M+1)<=(size-1))
                if((input.get(x)!='X') && (input.get(x)!='\n') && (input.get(x+M+1)!='X') && (input.get(x+M+1)!='W') ) 
                    return x+(M+1);
                else
                    return -1;
            else
                return -1;

      }	
      static int move_right(int x){
            if((x%(M+1)!= M-1))
                if((input.get(x+1)!='\n') && (input.get(x+1)!='X') && (input.get(x)!='X') && (input.get(x+1)!='W') ) 
                    return x+1;
                else
                    return -1;
            else
                return -1; 
      }	
      static int move_left(int x){
            if ((x % (M+1))!=0)
                if( (input.get(x)!='X') && (input.get(x-1)!='X') && (input.get(x-1)!='\n') && (input.get(x-1)!='W') ) 
                    return x-1;
                else
                    return -1;
            else
                return -1;
      }	
 static void move_virus(int x, int y){
    
    if(vir[x]==0 || y<=vir[x] ){
        vir[x]=y;
        if (move_down(x)!= -1){
            if (input.get(x+M+1)!='A'){
                z=y+2;
                move_virus(x+M+1, z); 
            }
            else{
                if(vir[x+M+1]==0){
                    z=y+2;
                    vir[x+M+1]=z;
                    for (int i=0; i<A.size(); i++){
                        if (A.get(i)!=(x+M+1)) vir[A.get(i)]= z+5;
                    
                    }
                    for (int i=0; i<A.size(); i++) move_virus(A.get(i),vir[A.get(i)] ); 	
                }
            }		
        }	
            
         
        if(move_left(x)!=-1){
            if(input.get(x-1)!='A'){
                z=y+2;
                move_virus(x-1, z);
            }
            else{
                if(vir[x-1]==0){
                    z=y+2;
                    vir[x-1]=z;
                    for (int i=0; i<A.size(); i++){
                        if (A.get(i)!=(x-1)) vir[A.get(i)]= z+5;
                    
                    }
                    for (int i=0; i<A.size(); i++) move_virus(A.get(i),vir[A.get(i)] ); 	
                }
            }				
        }	
    
 
        
        if(move_right(x)!=-1){
            if(input.get(x+1)!='A'){
                z=y+2;
                move_virus(x+1,z);
            }
            
             else{
                if(vir[x+1]==0){
                    z=y+2;
                    vir[x+1]=z;
                    for (int i=0; i<A.size(); i++){
                        if (A.get(i)!=(x+1)) vir[A.get(i)]= z+5;
                    
                    }
                    for (int i=0; i<A.size(); i++) move_virus(A.get(i),vir[A.get(i)] ); 	
                }
            }	
        }
        
        if (move_up(x)!= -1){
            if (input.get(x-(M+1))!='A'){
                z=y+2;
                move_virus(x-M-1, z);
            }
             else{
                if(vir[x-M-1]==0){
                    z=y+2;
                    vir[x-M-1]=z;
                    for (int i=0; i<A.size(); i++){
                        if (A.get(i)!=(x-M-1)) vir[A.get(i)]= z+5;
                    
                    }
                    for (int i=0; i<A.size(); i++) move_virus(A.get(i),vir[A.get(i)] ); 	
                }
            }	
        }
    }
    
    }
}	