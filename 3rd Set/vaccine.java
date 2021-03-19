import java.util.*;
import java.io.*;

public class Vaccine {
    static char[] arr; //array
    static Queue<Stack<Character>> first; //import java.util.LinkedList; 
                            //import java.util.Queue;  Queue<Integer> q = new LinkedList<>();
    static Queue<Stack<Character>> second;
    static Queue<String> aux;
    // create a stack by importing java.util.stack and Stack<E> stack = new Stack<E>();
    static Stack<Character> first_stack;
    static Stack<Character> second_stack;
    public static void main(String[] args) {
        try {
                File myObj = new File(args[0]);
                Scanner myReader = new Scanner(myObj);
                int times = myReader.nextInt();
                String in;
                myReader.nextLine();
                
                
                for(int i=0; i<times; i++){
                    in = myReader.nextLine();
                    arr = in.toCharArray(); //This method converts this string to a new character array.
                    boolean finished = false;
                    first = new LinkedList<>();
                    second = new LinkedList<>();
                    aux = new LinkedList<>();
                    first_stack = new Stack<>();
                    second_stack = new Stack<>();
                    for(int j=0; j<in.length(); j++) 
                        first_stack.push(arr[j]);
                    //String str = "";
                    String blank = "";
                    first.add(first_stack);
                    second.add(second_stack);
                    aux.add("");
                    
                    //boolean top = false;
                    //String blank = "";
                    
                    while(!finished){
                        int size = first.size();
                        for(int k=0; k<size; k++){
                            Stack<Character> f = first.remove(); //The element is removed from the beginning or head of the linked list.
                            Stack<Character> s = second.remove(); //The element is removed from the beginning or head of the linked list.
                            String t = aux.remove();
                            int sizef = f.size();
                            int sizes = s.size();
                            int sizet = t.length();
                            if((!s.isEmpty()) && (s.peek() == f.peek()) ){ //peek returns the first elemnt of the list without removing it
                                s.push(f.pop());
                                if(f.isEmpty()) {
                                    finished = true;
                                    blank = t + "p";
                    
                                    //blank = t + "p";
                                    break;
                                }
                                first.add(f);
                                
                                second.add(s);
                                aux.add(t + "p");
                                
                            }
                            else{
                                if(t != "" && t.charAt(sizet-1) == 'p'){
                                    Stack<Character> new2 = new Stack<>();
                                    for(int n=0; n<sizef; n++){
                                        if (f.get(n) == 'A') new2.push('U');
                                        else if (f.get(n) == 'U') new2.push('A');
                                        else if (f.get(n) == 'C') new2.push('G');
                                        else if (f.get(n) == 'G') new2.push('C');
                                    }
                                    
                                    first.add(new2);
                                    second.add(s);
                                    aux.add(t + "c");
                                }
                                boolean top = false;
                                for(int n=0; n<sizes; n++) 
                                    if(s.get(n) == f.peek()){
                                        top = true; 
                                        break;
                                        }
                                if(t != "" && t.charAt(sizet-1) != 'r' && sizes > 1){
                                    Stack<Character> st1 = new Stack<>();
                                    for(int n=sizes-1; n>=0; n--) st1.push(s.get(n));
                                    
                                    first.add(f);
                                    second.add(st1);
                                    aux.add(t + "r");
                                    
                                    
                                }
                                if(!top){
                                    Stack<Character> st2 = new Stack<>();
                                    Stack<Character> st3 = new Stack<>();
                                    for(int n=0; n<sizef; n++) st2.push(f.get(n));
                                    for(int n=0; n<sizes; n++) st3.push(s.get(n));
                                    st3.push(st2.pop());
                                    if(st2.isEmpty()) {
                                        //blank = t + "p";
                                        finished = true;
                                        blank = t + "p";
                                        break;
                                    }
                                    first.add(st2);
                                    second.add(st3);
                                    aux.add(t + "p");
                            
                                }
                                
                        
                            }
                        }
                    }
                    System.out.println(blank);
                }
                myReader.close();
        } catch (FileNotFoundException e) {
                System.out.println("An error occurred.");
                e.printStackTrace();
        }
    }
}        