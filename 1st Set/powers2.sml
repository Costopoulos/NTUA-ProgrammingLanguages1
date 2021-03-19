fun parse file =
    let
    (* A function to read an integer from specified input. *)
        fun readInt input = 
        Option.valOf (TextIO.scanStream (Int.scan StringCvt.DEC) input)

    (* Open input file. *)
    	val inStream = TextIO.openIn file

        (* Read an integer (number of couples) and consume newline. *)
    val n = readInt inStream
    val m = 2*n
    val _ = TextIO.inputLine inStream

        (* A function to read N integers from the open file. *)
    fun readInts 0 acc = acc (* Replace with 'rev acc' for proper order. *)
      | readInts i acc = readInts (i - 1) (readInt inStream :: acc)
    in
   	(n, List.rev(readInts m []))
    end


fun f n =
let
  fun f' 0   = []
    | f' num = num mod 2 :: f' (num div 2) 
in
    (f' n)
end

fun printer (input: int list) =
    let
        fun pri nil     = print ("]" ^ "\n")
          | pri (h::[]) = (print(Int.toString(h)); pri [])
          | pri (h::t)  = (print(Int.toString(h) ^ ","); pri t)
    in
        print("[") before pri input
    end;


fun delete_zeros(list:int list, k: int) =

let val(list) = 

    if List.last(list) < 1 then delete_zeros(List.take(list,k-1),k-1) else list

    in 
        list
    end




fun change_element(list:int list, j:int, new: int) = 
    
let
       val(list) =
      
       if(List.length(list)>0) 
          
           then ( 
               List.rev(new::(List.tl(List.take(List.rev(List.take(list,j)),j))))@(List.drop(list,j))
                 )    
           
            else []

in  
        list 
end



fun transform (j:int,list:int list, sum: int, k: int) = 

let
    val(list) = 

if(sum < k) then ( 
 
if(j+1 > List.length(list)) then list
        
else (

if List.nth(list,j) > 0 then (

transform( 1, change_element(change_element(list,j+1,List.nth(list,j)-1),j,List.nth(list,j-1)+2), sum+1, k)

            )

else transform(j+1,list, sum, k) 

     )
)

else list
    
in 
    delete_zeros(list:int list, k: int)
end



fun traverse_list (i, k , list  , counter) =


if ( i +1 > List.length(list )) then (

if(counter > k) then printer([]) 
                         
else if(counter = k) then printer(list) 
                           
else if(counter < k) then printer(transform(1,list, counter,k)) 
else()
)
 
else  

 if List.nth(list,i)>0 then traverse_list(i+1, k, list , counter+1) 

else if List.nth(list,i)<1 then traverse_list(i+1, k, list, counter)

 else ()


fun run (n: int, list: int list) =
    if (n>0) then (
   traverse_list(0,List.nth(list,1), f (List.nth(list,0)),0);
     run (n-1,List.drop(list,2))
      )
    else
    ();

fun powers2 (infile: string) = run(parse(infile: string));